import QtQuick 2.15

Item {
    id: delegateRoot

    signal clicked

    width: parent.width
    height: 50

    Rectangle {
        anchors.fill: parent
        color: "lightgrey"
        radius: 10

        Text {
            anchors.centerIn: parent
            text: modelData['name']
            font.pixelSize: 20
            textFormat: Text.StyledText
        }
    }

    MouseArea {
        anchors.fill: parent

        opacity: pressed ? 0.5 : 1.0
        onClicked: delegateRoot.clicked()
    }
}
