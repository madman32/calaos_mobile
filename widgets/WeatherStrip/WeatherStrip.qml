import QtQuick 2.12
import QtQml 2.12
import SharedComponents 1.0
import WeatherInfo 1.0

Item {
    id: weatherStrip

    property variant widgetModel
    property size minimumSize: bg.sourceSize
    property size maximumSize: bg.sourceSize
    
    WeatherModel {
        id: weatherModel
    }
    
    width: bg.width
    height: bg.height
    
    property int slider: 0

    Fonts { id: calaosFont }

    Timer {
        //update weather data every hour
        interval: 3600000; running: true; repeat: true;
        onTriggered: weatherModel.refreshWeather()
        triggeredOnStart: true
    }

    Image {
        id: bg
        source: "widget_base_back.png"
    }
    
    function clickedLeft()
    {
        if (weatherStrip.slider > 0)
        {
            weatherStrip.slider = weatherStrip.slider - 1;
        }
    }
    
    function clickedRight()
    {
        if (weatherStrip.slider < 3)
        {
            weatherStrip.slider = weatherStrip.slider + 1;
        }
    }
    
    Row {
       spacing: 10
        
       anchors {
           fill: parent
           centerIn: parent
           left: parent.left; leftMargin: Units.dp(10)
           top: parent.top; topMargin: Units.dp(10)
        }
        
        Arrow {
            slideRight: false
            rot: -90
            onArrowClickedRight: weatherStrip.clickedRight()
            onArrowClickedLeft: weatherStrip.clickedLeft()
        }
        WeatherSegment{
          id: seg1
          weather: weatherModel.forecast24[(slider * 6) + 0]
        }
        WeatherSegment{
          id: seg2
          weather: weatherModel.forecast24[(slider * 6) + 1]
        }
        WeatherSegment{
          id: seg3
          weather: weatherModel.forecast24[(slider * 6) + 2]
        }
        WeatherSegment{
          id: seg4
          weather: weatherModel.forecast24[(slider * 6) + 3]
        }
        WeatherSegment{
          id: seg5
          weather: weatherModel.forecast24[(slider * 6) + 4]
        }
        WeatherSegment{
          id: seg6
          weather: weatherModel.forecast24[(slider * 6) + 5]
        }
        
        Arrow {
            slideRight: true
            rot: 90
            onArrowClickedRight: weatherStrip.clickedRight()
            onArrowClickedLeft: weatherStrip.clickedLeft()
        }
    }
}
