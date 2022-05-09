import QtQuick 2.0

Item {
    id: root

    property real firstRandomHeight: 0
    property real secondRandomHeight: 0
    readonly property real minimalGap: 80
    readonly property real maximumGap: 100

    width: 30
    height: 480

    function getRandomFloat(min : real, max : real) : real {
        return Math.random() * (max - min + 1) + min
    }

    Item {
        id: topObstacle
        width: 30; height: 0

        anchors.top: root.top

        Image {
            source: "qrc:/images/FlappyBird/pipe2.png"

            anchors.bottom: topObstacle.bottom
        }
    }

    Item {
        id: bottomObstacle
        width: 30; height: 0

        anchors.bottom: root.bottom

        Image {
            source: "qrc:/images/FlappyBird/pipe.png"

            anchors.top: bottomObstacle.top
        }
    }

    onXChanged: {
        if (x < (0-root.width)) {
            root.firstRandomHeight = getRandomFloat(100,300)
            root.secondRandomHeight = getRandomFloat(480 - root.firstRandomHeight - root.minimalGap - root.maximumGap,
                                                    480 - root.firstRandomHeight - root.minimalGap)

            topObstacle.height = root.firstRandomHeight
            bottomObstacle.height = root.secondRandomHeight
            root.x = 800 + root.width
        }
    }

    Component.onCompleted: {
        root.firstRandomHeight = getRandomFloat(100,300)
        root.secondRandomHeight = getRandomFloat(root.maximumGap-root.minimalGap,480 - root.firstRandomHeight - root.minimalGap)

        topObstacle.height = root.firstRandomHeight
        bottomObstacle.height = root.secondRandomHeight
        root.x = 800 + root.width
    }
}
