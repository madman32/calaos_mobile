import QtQuick 2.0
import QtCharts 2.3
import SharedComponents 1.0

Item {

    property variant widgetModel
    property variant modelData
    id: graphWidget
    
    property double count: 0
    property double averageValue: 0
    property variant chartData: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    width: 400
    height: 300
    property size minimumSize: Qt.size(width, height)
    property size maximumSize: Qt.size(width, height)
   
    function updateGraph() {
        var maxValue = 0;
        for (var i = chartData.length - 1; i > 0 ; i--){
            dataSeries.replace(0 - i, chartData[i], 0 - i, chartData[i - 1]);
            chartData[i] = chartData[i-1];
            if (chartData[i] > maxValue)
            {
                maxValue = Math.ceil(chartData[i]);
            }
        }
        if (count > 0)
        {
            chartData[0] = averageValue/count;
            averageValue = 0;
            count = 0;
        }
        dataSeries.replace(0, chartData[1], 0, chartData[0]);
        if (chartData[0] > maxValue)
        {
            maxValue = Math.ceil(chartData[0]);
        }
        axisY.max = maxValue + 1;
    }
    
    function averageTime() {
        count = count + 1;
        averageValue = averageValue + modelData.stateInt;
    }

    Timer {
        //update every 10 second
        interval: 10000; running: true; repeat: true;
        onTriggered: graphWidget.averageTime()
        triggeredOnStart: true
    }
    
    Timer {
        //update every 1 second, change to 3600000 to get hourly
        interval: 3600000; running: true; repeat: true;
        onTriggered: graphWidget.updateGraph()
        triggeredOnStart: false
    }


    LineSeries {
        id: dataSeries
        XYPoint { x: 0; y: chartData[0] }
        XYPoint { x: -1; y: chartData[1] }
        XYPoint { x: -2; y: chartData[2] }
        XYPoint { x: -3; y: chartData[3] }
        XYPoint { x: -4; y: chartData[4] }
        XYPoint { x: -5; y: chartData[5] }
        XYPoint { x: -6; y: chartData[6] }
        XYPoint { x: -7; y: chartData[7] }
        XYPoint { x: -8; y: chartData[8] }
        XYPoint { x: -9; y: chartData[9] }
        XYPoint { x: -10; y: chartData[10] }
        XYPoint { x: -11; y: chartData[11] }
        XYPoint { x: -12; y: chartData[12] }
        XYPoint { x: -13; y: chartData[13] }
        XYPoint { x: -14; y: chartData[14] }
        XYPoint { x: -15; y: chartData[15] }
        XYPoint { x: -16; y: chartData[16] }
        XYPoint { x: -17; y: chartData[17] }
        XYPoint { x: -18; y: chartData[18] }
        XYPoint { x: -19; y: chartData[19] }
        XYPoint { x: -20; y: chartData[20] }
        XYPoint { x: -21; y: chartData[21] }
        XYPoint { x: -22; y: chartData[22] }
        XYPoint { x: -23; y: chartData[23] }
        XYPoint { x: -24; y: chartData[24] }
    }

   ValueAxis {
        id: axisY
        min: 0
        max: 25
    }

    ChartView {
        id: graphView
        anchors.fill: parent
        antialiasing: true
        legend.visible: false

        //animationOptions: ChartView.NoAnimation
        theme: ChartView.ChartThemeDark

        ValueAxis {
            id: axisX
            min: -24
            max: 0
        }
        AreaSeries {
            name: "data"
            axisX: axisX
            axisY: axisY
            upperSeries: dataSeries
        }
    }
}
