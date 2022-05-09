import QtQuick 2.15
import "FancyButton25D"
import "FlappyBird"
import "LoadingButton"

Item {
    property alias fancyButtonComponent: fancyButtonComponent
    property alias simpleButtonComponent: simpleButtonComponent
    property alias flappyBirdComponent: flappyBirdComponent
    property alias loadingButtonComponent: loadingButtonComponent

    Component {
        id: fancyButtonComponent

        BaseItem {
            FancyButton25D {
                scale: 1.5
                y: 120
                isAnimated: true
                anchors.centerIn: parent
            }
        }
    }

    Component {
        id: simpleButtonComponent

        BaseItem {
            SimpleButton25D {
                scale: 1.5
                anchors.centerIn: parent
            }
        }
    }

    Component {
        id: flappyBirdComponent

        BaseItem {
            Main {
                anchors.centerIn: parent
            }
        }
    }

    Component {
        id: loadingButtonComponent

        LoadingButton { }
    }
}
