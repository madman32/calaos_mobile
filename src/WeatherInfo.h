#ifndef WEATHERINFO_H
#define WEATHERINFO_H

#include <QtCore>
#include <QQmlListProperty>
#include <QtNetwork>
#include "qqmlhelpers.h"

/* Classes for exposing weather info from Openweathermap to QML
*/

class WeatherData: public QObject
{
    Q_OBJECT

    QML_READONLY_PROPERTY(QString, dayOfWeek)
    QML_READONLY_PROPERTY(QString, weatherIcon)
    QML_READONLY_PROPERTY(int, weatherCode)
    QML_READONLY_PROPERTY(QString, weatherDescription)
    QML_READONLY_PROPERTY(QString, weatherText)
    QML_READONLY_PROPERTY(QString, temperature)
    QML_READONLY_PROPERTY(QString, temperatureMin)
    QML_READONLY_PROPERTY(QString, temperatureMax)
    QML_READONLY_PROPERTY(QString, pressure)
    QML_READONLY_PROPERTY(QString, humidity)
    QML_READONLY_PROPERTY(bool, isNight)
    QML_READONLY_PROPERTY(QString, timestamp)
public:
    WeatherData();
    WeatherData(const WeatherData &other);

    void setWeatherData(const QJsonObject &obj);
    void setWeatherForecastData(const QJsonObject &obj);

private:
    QString convertTemp(double t);
};
Q_DECLARE_METATYPE(WeatherData)

class WeatherModel: public QObject
{
    Q_OBJECT

    QML_READONLY_PROPERTY(WeatherData *, weather)
    Q_PROPERTY(QQmlListProperty<WeatherData> forecast24 READ getForecast24 NOTIFY forecast24Changed)
    Q_PROPERTY(QQmlListProperty<WeatherData> forecast READ getForecast NOTIFY forecastChanged)
public:
    WeatherModel(QObject *parent = 0);
    virtual ~WeatherModel();

    Q_INVOKABLE void refreshWeather();

    QQmlListProperty<WeatherData> getForecast();
    WeatherData *getForecastData(int i);
    int getForecastCount();
    void forecastDataClear();

    QQmlListProperty<WeatherData> getForecast24();
    WeatherData *getForecast24Data(int i);
    int getForecast24Count();
    void forecast24DataClear();
    
    static void registerQmlClasses();

signals:
    void forecastChanged();
    void forecast24Changed();

private slots:
    void handleWeatherNetworkData();
    void handleForecastHourlyNetworkData();
    void handleForecastWeekNetworkData();

private:
    QNetworkAccessManager *accessManager;

    WeatherData dataNow;
    QList<WeatherData *> dataForecast;
    QList<WeatherData *> dataForecastHourly;
    QQmlListProperty<WeatherData> *qdataForecastHourly;
    QQmlListProperty<WeatherData> *qdataForecast;

    //time info to prevent querying server too fast
    QTime refreshTime;
};

#endif // WEATHERINFO_H
