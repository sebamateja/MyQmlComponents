import QtQuick 2.0
import QtGraphicalEffects 1.13

Item {
    id: root
    width: frontLayer.sourceSize.width + root.mouseAreaOffset
    height: frontLayer.sourceSize.height + root.mouseAreaOffset

    //Properties for images/FancyButton25D source
    property var sourceFrontLayer : "qrc:/images/FancyButton25D/card.png"
    property var sourceBackLayer1 : "qrc:/images/FancyButton25D/hole.png"
    property var sourceBackLayer2 : "qrc:/images/FancyButton25D/gear_bigger.png"
    property var sourceBackLayer3 : "qrc:/images/FancyButton25D/gear_smaller.png"
    property var sourceShadow : "qrc:/images/FancyButton25D/shadow.png"
    property var sourceSpecular : "qrc:/images/FancyButton25D/specular.png"
    property var sourceGlow : "qrc:/images/FancyButton25D/glow.png"

    property real maxAngleBackLayer1: 30
    property real maxAngleBackLayer2: 16
    property real maxAngleBackLayer3: 12
    property real maxAngleFrontLayer: 30

    property real maxTranslateBackLayer1: 20
    property real maxTranslateBackLayer2: 16
    property real maxTranslateBackLayer3: 12

    property real scaleOnPressed: 0.9

    property real mouseAreaOffset: 20

    property real behaviorDuration: 170

    property bool isAnimated: false
    property bool isPressed: false

    property real mouseXPosition: centerX
    property real mouseYPosition: centerY

    readonly property real centerX: frontLayer.sourceSize.width / 2 + mouseAreaOffset/2
    readonly property real centerY: frontLayer.sourceSize.height / 2 + mouseAreaOffset/2

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
            isPressed = false
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
            isPressed = true
            root.mouseXPosition = mouseX
            root.mouseYPosition = mouseY
        }
    }

    SimpleImageLayer {
        id: shadow

        anchors.centerIn: mouseArea
        anchors.top: frontLayer.top
        anchors.horizontalCenter: frontLayer.horizontalCenter

        sourceLayer: root.sourceShadow
        maxAngleLayer: root.maxAngleFrontLayer
    }

    SimpleImageLayer {
        id: glowLayer

        anchors.centerIn: mouseArea
        visible: root.isPressed

        Behavior on scale {
            NumberAnimation { duration: behaviorDuration }
        }

        sourceLayer: root.sourceGlow
        maxAngleLayer: root.maxAngleFrontLayer
    }

    SimpleImageLayer {
        id: frontLayer

        anchors.centerIn: mouseArea

        sourceLayer: root.sourceFrontLayer
        maxAngleLayer: root.maxAngleFrontLayer
    }

    ImageLayer {
        id: backLayer1

        anchors.centerIn: frontLayer

        sourceBackLayer: root.sourceBackLayer1
        maxAngleBackLayer: root.maxAngleBackLayer1
        maxTranslateBackLayer: root.maxTranslateBackLayer1
    }

    ImageLayer {
        id: backLayer2

        anchors.centerIn: frontLayer

        sourceBackLayer: root.sourceBackLayer2
        maxAngleBackLayer: root.maxAngleBackLayer2
        maxTranslateBackLayer: root.maxTranslateBackLayer2
    }

    ImageLayer {
        id: backLayer3

        anchors.centerIn: frontLayer

        sourceBackLayer: root.sourceBackLayer3
        maxAngleBackLayer: root.maxAngleBackLayer3
        maxTranslateBackLayer: root.maxTranslateBackLayer3
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

    Timer {
        interval: 33
        repeat: true
        running: isAnimated
        onTriggered: {
            backLayer2.rotation += 1;
            backLayer3.rotation -= 1;
        }
    }
}
