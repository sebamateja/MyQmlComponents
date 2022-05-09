import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    id: root
    width: frontLayer.sourceSize.width + root.mouseAreaOffset
    height: frontLayer.sourceSize.height + root.mouseAreaOffset

    property var sourceFrontLayer : "qrc:/images/FancyButton25D/card.png"
    property var sourceShadow : "qrc:/images/FancyButton25D/shadow.png"
    property var sourceSpecular : "qrc:/images/FancyButton25D/specular.png"
    property var sourceGlow : "qrc:/images/FancyButton25D/glow.png"

    readonly property real centerX: frontLayer.sourceSize.width / 2 + mouseAreaOffset/2
    readonly property real centerY: frontLayer.sourceSize.height / 2 + mouseAreaOffset/2

    property real mouseXPosition: centerX
    property real mouseYPosition: centerY

    property real maxAngleFrontLayer: 30
    property real scaleOnPressed: 0.9

    property real mouseAreaOffset: 20

    property real behaviorDuration: 170

    property bool isPressed: false

    MouseArea {
        id: mouseArea
        width: frontLayer.width + root.mouseAreaOffset
        height: frontLayer.height + root.mouseAreaOffset

        onPositionChanged: {
            if (mouseX < mouseArea.width && mouseY < mouseArea.height
                    && mouseX > 0 && mouseY > 0) {
                root.mouseXPosition = mouseX
                root.mouseYPosition = mouseY
            } else {
                root.mouseXPosition = root.centerX
                root.mouseYPosition = root.centerY
            }
        }

        onReleased: {
            console.log("OnReleased")
            root.mouseXPosition = centerX
            root.mouseYPosition = centerY
//            isPressed = false
        }

        onEntered: {
            console.log("OnEntered")
            root.mouseXPosition = mouseX
            root.mouseYPosition = mouseY
        }

        onExited: {
            console.log("OnExited")
            root.mouseXPosition = centerX
            root.mouseYPosition = centerY
        }

        onCanceled: {
            console.log("OnCanceled")
            root.mouseXPosition = centerX
            root.mouseYPosition = centerY
        }

        onPressed: {
            console.log("OnPressed")
            isPressed = !isPressed
            root.mouseXPosition = mouseX
            root.mouseYPosition = mouseY
        }
    }

    Image {
        id: shadow
        antialiasing: true
        source:root.sourceShadow
        //        anchors.top: frontLayer.top
        //        anchors.horizontalCenter: frontLayer.horizontalCenter
        scale: isPressed == true ? scaleOnPressed : 1

        Behavior on scale {
            NumberAnimation { duration: behaviorDuration }
        }

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

    Image {
        id: glowLayer
        anchors.centerIn: mouseArea
        antialiasing: true
        source: root.sourceGlow
        visible: isPressed
        scale: isPressed == true ? scaleOnPressed : 1

        Behavior on scale {
            NumberAnimation { duration: behaviorDuration }
        }

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

    Image {
        id: frontLayer
        anchors.centerIn: mouseArea
        antialiasing: true
        source: root.sourceFrontLayer
        scale: isPressed == true ? scaleOnPressed : 1

        Behavior on scale {
            NumberAnimation { duration: behaviorDuration }
        }

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

    Rectangle {
        antialiasing: true
        width: frontLayer.sourceSize.width
        height: frontLayer.sourceSize.height
        anchors.centerIn: mouseArea
        radius: 20
        scale: isPressed == true ? scaleOnPressed : 1
        color: "transparent"

        layer.enabled: true

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

        Behavior on scale {
            NumberAnimation { duration: behaviorDuration }
        }

        Behavior on x {
            NumberAnimation { duration: behaviorDuration }
        }

        Behavior on y {
            NumberAnimation { duration: behaviorDuration }
        }

        layer.samplerName: "maskSource"
        layer.effect: ShaderEffect {
            property var colorSource: specular;
            fragmentShader: "
                            uniform lowp sampler2D colorSource;
                            uniform lowp sampler2D maskSource;
                            uniform lowp float qt_Opacity;
                            varying highp vec2 qt_TexCoord0;
                            void main() {
                                gl_FragColor =
                                    texture2D(colorSource, qt_TexCoord0)
                                    * texture2D(maskSource, qt_TexCoord0).a
                                    * qt_Opacity;
                            }
                        "
        }

        Image {
            id: specular
            antialiasing: true
            source:root.sourceSpecular
            visible: isPressed

            layer.enabled: true

            x: mouseArea.width - root.mouseXPosition - specular.sourceSize.width/2
            y: mouseArea.height - root.mouseYPosition - specular.sourceSize.height/2

            Behavior on x {
                NumberAnimation { duration: behaviorDuration }
            }

            Behavior on y {
                NumberAnimation { duration: behaviorDuration }
            }
        }
    }
}
