import QtQuick 2.0

Item {
    id: root

    property bool hidden: false

    function startShowMainMenu() {
        showMainMenu.start()
    }

    width: 800
    height: 480

    Rectangle {
        anchors.fill: parent

        color: "yellow"
    }

    Rectangle {
        anchors.centerIn: parent

        width: 250
        height: 80

        color: "blue"

        Text {
            anchors.centerIn: parent

            text: "START GAME"
            color: "black"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                hideMainMenu.start()
            }
        }
    }

    SequentialAnimation {
        id: hideMainMenu

        running: false

        NumberAnimation { 
            target: root; property: "x"; to: 800
            duration: 500; easing.type: Easing.InOutQuad 
        }
        ScriptAction {
            script: { root.visible = false; root.hidden = true; }
        }
    }

    SequentialAnimation {
        id: showMainMenu

        running: false
        ScriptAction {
            script: { root.visible = true; root.hidden = false; }
        }
        NumberAnimation { 
            target: root; property: "x"; to: 0
            duration: 500; easing.type: Easing.InOutQuad 
        }
    }
}
