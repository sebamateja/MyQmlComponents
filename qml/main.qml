import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1920
    height: 1080
    visible: true
    title: qsTr("My QML Components")

    Rectangle {
        anchors.fill: listView
        color: "dimgray"
    }

    MyListModel {
        id: componentModel

        listOfComponents: listOfComponents
    }

    ListOfComponents { id: listOfComponents }

    ListView {
        id: listView

        width: 500
        height: parent.height

        spacing: 10
        model: componentModel.model

        delegate: MyListViewDelegate {
            onClicked: {
                componentLoader.sourceComponent = modelData['component']
            }
        }
    }

    Loader {
        id: componentLoader

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: listView.right
        }
    }
}
