import QtQuick 2.0

Image {
    id: frontLayer

    property var sourceLayer: ""
    property real maxAngleLayer: 0

    antialiasing: true
    smooth: true
    source: sourceLayer
    scale: isPressed == true ? scaleOnPressed : 1

    transform: [
        Rotation {
            origin.x: root.centerX
            origin.y: root.centerY
            axis {x: 0; y: 1; z: 0}
            angle: (root.mouseXPosition - root.centerX)/root.centerX * maxAngleFrontLayer

            Behavior on angle {
                NumberAnimation { duration: behaviorDuration }
            }
        },
        Rotation {
            origin.x: root.centerX
            origin.y: root.centerY
            axis {x: 1; y: 0; z: 0}
            angle: (root.centerY - root.mouseYPosition)/root.centerY * maxAngleFrontLayer

            Behavior on angle {
                NumberAnimation { duration: behaviorDuration }
            }
        }
    ]
}
