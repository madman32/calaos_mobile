import QtQuick 2.12
import SharedComponents 1.0

Item {
    id: arrow
    property bool slideRight: false
    property int rot
    
    signal arrowClickedRight
    signal arrowClickedLeft
    
    width: 115
    height: 115
  
    function clicked()
    {
        if (slideRight == true)
        {
            arrowClickedRight();
        }
        else
        {
            arrowClickedLeft();
        }
    }
    
    Image {
        source: "arrow.png"
        anchors.fill: parent
        width: parent.width
        height: parent.height
        transformOrigin: Item.Center
        rotation: arrow.rot
    }
    
    MouseArea {
        anchors.fill: parent
        anchors.margins: Units.dp(-5)
        onClicked: arrow.clicked()
    }
}

