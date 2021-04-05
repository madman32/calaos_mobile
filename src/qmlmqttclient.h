#ifndef QMLMQTTCLIENT_H
#define QMLMQTTCLIENT_H

#include <QtCore/QMap>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttSubscription>

class QmlMqttClient;

class QmlMqttSubscription : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QMqttTopicFilter topic MEMBER m_topic NOTIFY topicChanged)
public:
    QmlMqttSubscription(QMqttSubscription *s);
    ~QmlMqttSubscription();

Q_SIGNALS:
    void topicChanged(QString);
    void messageReceived(const QString &msg);

public slots:
    void handleMessage(const QMqttMessage &qmsg);

private:
    Q_DISABLE_COPY(QmlMqttSubscription)
    QMqttSubscription *sub;
    QMqttTopicFilter m_topic;
};

/*class QmlMqttClient : public QMqttClient
{
    Q_OBJECT
public:
    QmlMqttClient(QObject *parent = nullptr);

    Q_INVOKABLE QmlMqttSubscription *subscribe(const QString &topic);
private:
    Q_DISABLE_COPY(QmlMqttClient)
};*/

class QmlMqttClient: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString hostname READ name WRITE setName)
    Q_PROPERTY(int port READ port WRITE setPort)
public:
    QmlMqttClient(QObject *parent = nullptr);

    QString name() const {return m_hostname;}
    void setName(const QString &n) {m_hostname = n;}

    int port() const {return m_port;}
    void setPort(int p) {m_port = p;}
    
    Q_INVOKABLE void connectToHost();
    Q_INVOKABLE QmlMqttSubscription * subscribe(const QString &topic);
    Q_INVOKABLE void disconnectFromHost();
private:
    QString m_hostname;
    int m_port;
    
    QSharedPointer<QMqttClient> m_client;
};


#endif // QMLMQTTCLIENT_H
