import QtQuick 2.0

Rectangle {
    id: root
    // TODO: inherit keyboardItem instead of agregation

    property alias source: keyboardItem.source
    property alias keyWidth: keyboardItem.keyWidth
    property alias keyHeight: keyboardItem.keyHeight
    property alias bounds: keyboardItem.bounds
    property alias mainFont: keyboardItem.mainFont
    property alias mainFontColor: keyboardItem.mainFontColor
    property alias secondaryFont: keyboardItem.secondaryFont
    property alias secondaryFontColor: keyboardItem.secondaryFontColor
    property alias keyColor: keyboardItem.keyColor
    property alias keyPressedColor: keyboardItem.keyPressedColor

    color: "#192430"
    width: 1024
    height: 540

    Image {
        source: "qrc:/img/keyboard_background.png"
        anchors.fill: parent
    }

    KeyboardItem {
        id: keyboardItem
        anchors.fill: parent
        source: "qrc:/qml/keyboard_fr.xml"
        onKeyClicked: console.log(key)
        onSwitchSource: root.source = source
    }
}

