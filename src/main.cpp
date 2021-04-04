#include "Application.h"
#include "Common.h"
#include "HardwareUtils.h"
#ifdef HAVE_WEBENGINE
#include <QtWebEngine>
#endif
#if defined(CALAOS_DESKTOP)
#include "qmlmqttclient.h"
#include <QGuiApplication>
#include <QLoggingCategory>
#endif

int main(int argc, char *argv[])
{
#if defined(CALAOS_DESKTOP)
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
#endif

#if !defined(Q_OS_IOS) && !defined(Q_OS_ANDROID)
    Common::installMessageOutputHandler();
#endif

#ifdef Q_OS_ANDROID
    //This disables Handles that are visible somehow in the HomeView
    qputenv( "QT_QPA_NO_TEXT_HANDLES", QByteArray( "1" ) );
#endif

    //Instanciate hardware class early so it can register
    //all observer before Qt starts
    HardwareUtils::Instance();

    QAPP::setAttribute(Qt::AA_EnableHighDpiScaling);
    Application app(argc, argv);

#if defined(CALAOS_DESKTOP) && defined(HAVE_WEBENGINE)
    QtWebEngine::initialize();
#endif

    //init platform code after QApp is created and initialized
    HardwareUtils::Instance()->platformInit(app.getEngine());
#if defined(CALAOS_DESKTOP)
        qmlRegisterType<QmlMqttClient>("MqttClient", 1, 0, "MqttClient");
        qmlRegisterUncreatableType<QmlMqttSubscription>("MqttClient", 1, 0, "MqttSubscription", QLatin1String("Subscriptions are read-only"));
#endif
    //QML app creation needs to be created after platform init is done
    app.createQmlApp();

    return app.exec();
}
