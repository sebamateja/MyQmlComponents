import QtQuick 2.0

Item {
    id: root
    width: 800
    height: 480

    property real points: 0.0
    property bool gameRunning: mainMenu.hidden
    property MainMenu mainMenu: null

    clip: true

    function doOverlap(lx1 : real, ly1 : real, rx1 : real, ry1 : real, lx2 : real, ly2 : real, rx2 : real, ry2 : real) : bool{
        if (lx1 > rx2 || lx2 > rx1) {
            return false;
        }
        
        if (ly1 > ry2 || ly2 > ry1) {
            return false;
        }

        return true;
    }

    function resetGame() {
        player.x = 40
        player.y = 40
        obstacles.x = 800 + obstacles.width
        root.points = 0.0
        mainMenu.startShowMainMenu()
    }

    onGameRunningChanged: {
        if(gameRunning) {
            timer.start()
        } else {
            timer.stop()
        }
    }

    Background {

    }

    Image {
        id: player

        source: "qrc:/images/FlappyBird/player.png"
        width: 30; height: 30;
        x: 40; y: 40;
    }

    Obstacle {
        id: obstacles
    }

    Item {
        id: floor

        width: 800
        height: 32

        anchors.horizontalCenter: root.horizontalCenter
        anchors.bottom: root.bottom

        Image {
            source: "qrc:/images/FlappyBird/floor.png"
        }
    }

    Item {
        id: ceil

        width: 800
        height: 32

        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: root.top

        Image {
            source: "qrc:/images/FlappyBird/ceiling.png"
        }
    }

    // Just a jump, for games like mario etc
    SequentialAnimation {
        id: jumpAnimation

        alwaysRunToEnd: true
        running: false

        NumberAnimation {
            target: player; property: "y"; to: 290; duration: 300; easing.type: Easing.Linear
        }
        NumberAnimation {
            target: player; property: "y"; to: 440; 
            duration: 300; easing.type: Easing.Linear
        }
        ScriptAction { script: {jumpAnimation.stop()} }
    }

    SequentialAnimation {
        id: alaFlappyBirdAnim

        property real yPlayerPos: 0

        alwaysRunToEnd: false
        running: false

        ScriptAction { script: { alaFlappyBirdAnim.yPlayerPos = player.y } }
        NumberAnimation {
            target: player; property: "y"; from: player.y; to: alaFlappyBirdAnim.yPlayerPos-30; duration: 300; easing.type: Easing.Linear
        }
    }

    MouseArea {
        anchors.fill: parent

        enabled: root.gameRunning

        onClicked: {
            alaFlappyBirdAnim.start();
            // if (jumpAnimation.running) {
                
            // } else {
            //     jumpAnimation.start()
            // }
        }
    }

    Text {
        visible: true
        text: "Points: "
        color: "black"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 50
        anchors.topMargin: 30
    }

    Text {
        id: textPoints

        property string pt: root.points.toFixed(0)
        visible: true
        text: textPoints.pt
        color: "black"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.topMargin: 30
    }

//    Text {
//        visible: QulPerf.enabled
//        text: QulPerf.fps.toString()
//        color: "green"
//        anchors.left: parent.left
//        anchors.top: parent.top
//    }

    Timer {
        id: timer

        interval: 17
        repeat: true
        running: false
        onTriggered: {
            obstacles.x -= 3
            player.y += 3
            root.points += 0.1
            // Checking for obstacles
            if(doOverlap(player.x, player.y, player.x + player.width, player.y + player.height,
                        obstacles.x, obstacles.y, obstacles.x + obstacles.width, obstacles.y + obstacles.firstRandomHeight)) {
                resetGame()
            } else if(doOverlap(player.x, player.y, player.x + player.width, player.y + player.height,
                        floor.x, floor.y, floor.x + floor.width, floor.y + floor.height)){
                resetGame()
            } else if(doOverlap(player.x, player.y, player.x + player.width, player.y + player.height,
                        obstacles.x, 480-obstacles.secondRandomHeight, obstacles.x + obstacles.width, obstacles.y + 480)) {
                resetGame()
            } else if(doOverlap(ceil.x, ceil.y, ceil.x + ceil.width, ceil.y + ceil.height, 
                player.x, player.y, player.x + player.width, player.y + player.height)){
                resetGame()
            } 
        }
    }
}
