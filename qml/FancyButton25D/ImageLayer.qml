import QtQuick 2.0

Image {
    id: imageLayer

    property var sourceBackLayer: ""
    property real maxAngleBackLayer: 0
    property real maxTranslateBackLayer: 0

    antialiasing: true
    source: sourceBackLayer

    smooth: true
    scale: isPressed == true ? scaleOnPressed : 1

    transform: [
        Rotation {
            origin.x: root.centerX
            origin.y: root.centerY
            axis {x: 0; y: 1; z: 0}
            angle: (root.mouseXPosition - root.centerX)/root.centerX * maxAngleBackLayer

            Behavior on angle {
                NumberAnimation { duration: behaviorDuration }
            }
        },
        Rotation {
            origin.x: root.centerX
            origin.y: root.centerY
            axis {x: 1; y: 0; z: 0}
            angle: (root.centerY - root.mouseYPosition)/root.centerY * maxAngleBackLayer

            Behavior on angle {
                NumberAnimation { duration: behaviorDuration }
            }
        },
        Translate {
            x: (root.mouseXPosition - root.centerX)/root.centerX * maxTranslateBackLayer
            y: (root.mouseYPosition - root.centerY)/root.centerY * maxTranslateBackLayer

            Behavior on x {
                NumberAnimation { duration: behaviorDuration }
            }

            Behavior on y {
                NumberAnimation { duration: behaviorDuration }
            }
        }
    ]
}
