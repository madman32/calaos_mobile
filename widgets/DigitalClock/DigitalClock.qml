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

    function getLastSunday(year, month) {
      // Create date for last day in month
      var d = new Date(year, month, 0);
      // Adjust to previous Sunday
      d.setDate(d.getDate() - d.getDay());
      return d;
    }

    function timeChanged() {
        var d = new Date();

        var dstS = getLastSunday(d.getFullYear(), 3);
        var dstE = getLastSunday(d.getFullYear(), 10);

        dstS = new Date(Date.UTC(dstS.getFullYear(), dstS.getMonth(), dstS.getDate(),1));
        dstE = new Date(Date.UTC(dstE.getFullYear(), dstE.getMonth(), dstE.getDate(),1));

        if (d > dstS && d < dstE) {
            d.setUTCHours(d.getUTCHours() +1);
        }
        textClock.text = d.toLocaleTimeString(locale, "hh:mm");
    }

    Fonts { id: calaosFont }

    Timer {
        interval: 1000; running: true; repeat: true;
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
