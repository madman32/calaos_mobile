import QtQuick 2.5
import SharedComponents 1.0

Item {
    id: digitalclock

    property variant widgetModel
    property size minimumSize: bg.sourceSize
    property size maximumSize: bg.sourceSize
   
    width: 600
    height: 300

    property var locale: Qt.locale()
    
    property date currentTime: new Date()

    function timeChanged() {
        var date = new Date;
        textClock.text = date.toLocaleTimeString(locale, "hh:mm");
    }

    Fonts { id: calaosFont }

    Timer {
        interval: 100; running: true; repeat: true;
        onTriggered: digitalclock.timeChanged()
    }

    BorderImage {
        id: bg      
        width: parent.width
        height: parent.height  
        anchors.centerIn: parent
        source: "widget_lcd_clock_back.png"
    }

    Text {
        id: textClock
        anchors {
            centerIn: parent
            horizontalCenterOffset: Units.dp(-10)
        }
        color: "#efefef"
        font { family: calaosFont.fontFamily; pixelSize: Units.dp(parent.height/1.5); weight: Font.Thin }
        opacity: 0.8
    }
}
