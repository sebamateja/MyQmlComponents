import QtQuick 2.0

Item {
    id: root
    width: 800
    height: 480

    Image {
        anchors.fill: parent

        source: "qrc:/images/FlappyBird/bg.png"
    }

    Image {
        id: clouds

        y: 200

        width: 800 * 2.0

        source: "qrc:/images/FlappyBird/bg-clouds.png"
        fillMode: Image.TileHorizontally
    }

    Rectangle {
        id: cloudFill

        color: Qt.rgba(0.95294,0.98431,0.99607)
        width: 800
        height: 480 - 343
        y: 343
    }

    Image {
        id: forest

        anchors.bottom: root.bottom

        source: "qrc:/images/FlappyBird/bg-forest.png"
    }

    ParallelAnimation {
        running: true
        loops: Animation.Infinite

        NumberAnimation { target: clouds; property: "x"; from: 0; to: -clouds.width*0.5; duration: 20000; }
    }
}
