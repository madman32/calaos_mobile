#include "qmlmqttclient.h"
#include <QDebug>

#include <unistd.h>

/*QmlMqttClient::QmlMqttClient(QObject *parent)
    : QMqttClient(parent)
{
}*/
QmlMqttClient::QmlMqttClient(QObject *parent)
    : QObject(parent)
    , m_hostname("192.168.1.38")
    , m_port(1883)
{
    m_client = QSharedPointer<QMqttClient>(new QMqttClient);
}

void QmlMqttClient::connectToHost()
{
    m_client->setHostname(m_hostname);
    m_client->setPort(m_port);
    m_client->connectToHost();
    int count = 0;
    while (m_client->state() != QMqttClient::ClientState::Connected)
    {
        usleep(1000);
        count ++;
        if (count > 10000)
        {
            qWarning() << "Unable to connect to MQTT socket within 10 sec";
            break;
        }
    }
}

void QmlMqttClient::disconnectFromHost()
{
    m_client->disconnectFromHost();
}

QmlMqttSubscription* QmlMqttClient::subscribe(const QString &topic)
{
    QMqttTopicFilter f(topic);
    auto sub = m_client->subscribe(f);
    if (!sub)
    {
        qWarning() << "topic is " << topic;
        if (!f.isValid()) {
            qWarning() << "Invalid subscription topic filter";
        }
        qWarning() << "Sub is null about to crash";
    }
    auto result = new QmlMqttSubscription(sub);
    return result;
}

QmlMqttSubscription::QmlMqttSubscription(QMqttSubscription *s)
    : sub(s)
{
    connect(sub, &QMqttSubscription::messageReceived, this, &QmlMqttSubscription::handleMessage);
    m_topic = sub->topic();
}

QmlMqttSubscription::~QmlMqttSubscription()
{
}

void QmlMqttSubscription::handleMessage(const QMqttMessage &qmsg)
{
    emit messageReceived(qmsg.payload());
}
