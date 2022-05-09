import QtQuick 2.15

Item {
    property ListOfComponents listOfComponents

    property var model: ([
         { name: "Fancy Button 2.5D", component: listOfComponents.fancyButtonComponent },
         { name: "Simple Button 2.5D", component: listOfComponents.simpleButtonComponent },
         { name: "<del>Flappy bird</del> - TBD", component: listOfComponents.flappyBirdComponent },
         { name: "Loading Button", component: listOfComponents.loadingButtonComponent },
     ])
}
