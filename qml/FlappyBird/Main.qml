import QtQuick 2.15

Item {
    id: root
    width: 800
    height: 480

    property real highscore: 0.0

    Game {
        id: game

        mainMenu: menu

        onPointsChanged: {
            if (game.points > root.highscore)
                root.highscore = game.points
        }
    }

    MainMenu {
        id: menu

    }

    Text {
        visible: true
        text: "Highscore: "
        color: "black"
        anchors.right: root.right
        anchors.rightMargin: 40
        anchors.bottom: root.bottom
        anchors.bottomMargin: 30
    }

    Text {
        id: textPoints

        property string pt: root.highscore.toFixed(0)
        visible: true
        text: textPoints.pt
        color: "black"
        anchors.right: root.right
        anchors.bottom: root.bottom
        anchors.bottomMargin: 30
    }
}
