import QtQuick 2.15
import QtQuick.Controls 2.15
import "../"

BaseItem {
    QtObject {
        id: internal

        readonly property int durationAnimation: 150
        readonly property int scaleDurationAnimation: 100
    }

    Item {
        anchors.centerIn: parent

        width: 400
        height: 400

        Rectangle {
            anchors.centerIn: parent
            width: 420
            height: width
            radius: width / 2
            color: "lightgray"
        }

        Repeater {
            id: repeater

            anchors.fill: parent

            model: 8
            delegate: Item {
                id: root

                 anchors.fill: parent

                Rectangle {
                    id: rec

                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                    }

                    width: 20
                    height: width
                    radius: width / 2
                    color: "dimgray"
                }

                SequentialAnimation {
                    running: true
                    RotationAnimator {
                        target: root
                        from: 0
                        to: (360 / 8) * index
                        duration: internal.durationAnimation * index
                    }

                    PauseAnimation {
                        duration: (repeater.count - index) * internal.durationAnimation
                    }

                    ScaleAnimator {
                        target: rec
                        from: 1.0
                        to: 2.0
                        duration: internal.scaleDurationAnimation
                        easing.type: Easing.OutQuad
                    }

                    ScaleAnimator {
                        target: rec
                        from: 2.0
                        to: 1.0
                        duration: internal.scaleDurationAnimation
                        easing.type: Easing.InQuad
                    }

                    RotationAnimator {
                        target: root
                        from: (360 / 8) * index
                        to: 360
                        duration: (repeater.count - index) * internal.durationAnimation
                    }

                    OpacityAnimator {
                        target: rec
                        from: 1
                        to: 0
                        duration: 0
                    }
                }
            }
        }

        Image {
            anchors.centerIn: parent

            width: 300
            height: 300
            source: "qrc:/images/LoadingButton/play-icon.png"
        }
    }
}
