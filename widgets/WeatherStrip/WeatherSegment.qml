import QtQuick 2.12
import SharedComponents 1.0
import WeatherInfo 1.0

Item {
  property variant weather: WeatherData
  
  id: weatherSegment
  
  width: 115
  height: 115
  
  Text {
        elide: Text.ElideMiddle
        font.pixelSize: Units.dp(28)
        font.family: calaosFont.fontFamily
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Thin
        color: "#E7E7E7"

        text: weather.timestamp

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
            verticalCenterOffset: Units.dp(-40)
        }
    }
    
    Loader {
        property int code: weather.weatherCode
        id: weatherIcon

        function getIcon(c) {
            // When this is created no icon data is available, filled out after
            if (c == 0) {
                return ""
            }
            if (c >= 200 && c <= 232) {
                return "IconThunder.qml"
            } else if (c >= 300 && c <= 321 ||
                       c >= 500 && c <= 531) {
                return "IconRain.qml"
            } else if (c >= 600 && c <= 622) {
                return "IconSnow.qml"
            } else if (c >= 701 && c <= 781 ||
                       c >= 900) {
                return "IconSpecial.qml"
            } else if (c >= 801 && c <= 804) {
                return "IconCloud.qml"
            } else if (c == 800) {
                return "IconSun.qml"
            }

            console.log("Unknown weather icon code: " + c)
            return ""
        }

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
            verticalCenterOffset: Units.dp(10)
        }
        source: getIcon(code)
        
        onLoaded: item.weatherModel = weatherModel.weather
    }
    
    Text {
        elide: Text.ElideMiddle
        font.pixelSize: Units.dp(28)
        font.family: calaosFont.fontFamily
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Thin
        color: "#E7E7E7"

        text: "%1 °C".arg(weather.temperature)

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
            verticalCenterOffset: Units.dp(40)
        }
    }
}
