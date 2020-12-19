import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Material.impl 2.3
import QtQuick.Dialogs 1.2

Item{

    Loader {
        id: container
        anchors.bottom: bottomNavigation.top
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        source: "help1.qml"

        function loadScreen(index) {
            switch (index) {
            case 0:
                container.source = "help1.qml"
                break
            case 1:
                container.source = "help2.qml"
                break
            }
        }
    }

    TabBar {
        id: bottomNavigation
        width: parent.width
        anchors.bottom: parent.bottom
        background: Rectangle {
            color: "white"
        }

        TabButton {
            id: sellingButton
            onClicked: container.loadScreen(0)
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 50
                color: "transparent"
                Ripple {
                    clipRadius: 2
                    width: parent.width
                    height: parent.height
                    pressed: sellingButton.pressed
                    anchor: sellingButton
                    active: sellingButton.down || sellingButton.visualFocus
                            || sellingButton.hovered
                    color: "#e6e6e6"
                }
            }
            contentItem: Item {
                anchors.fill: sellingButton
                Text {
                    id: sellinText
                    text: "Как работает"
                    color: bottomNavigation.currentIndex === 0 ? "#6202EE" : "#757575"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            SequentialAnimation {
                ScaleAnimator {
                    target: sellingButton
                    from: 1
                    to: 0.7
                }
                ScaleAnimator {
                    target: sellingButton
                    from: 0.7
                    to: 1.2
                }
                ScaleAnimator {
                    target: sellingButton
                    from: 1.2
                    to: 1
                }
                alwaysRunToEnd: true
                running: sellingButton.down
            }
        }
        TabButton {
            id: selledButton
            onClicked: container.loadScreen(1)
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 50
                color: "transparent"
                Ripple {
                    clipRadius: 2
                    width: parent.width
                    height: parent.height
                    pressed: selledButton.pressed
                    anchor: selledButton
                    active: selledButton.down || selledButton.visualFocus
                            || selledButton.hovered
                    color: "#e6e6e6"
                }
            }
            contentItem: Item {
                anchors.fill: selledButton
                Text {
                    id: selledText
                    text: "Авторы"
                    color: bottomNavigation.currentIndex === 1 ? "#6202EE" : "#757575"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            SequentialAnimation {
                ScaleAnimator {
                    target: selledButton
                    from: 1
                    to: 0.7
                }
                ScaleAnimator {
                    target: selledButton
                    from: 0.7
                    to: 1.2
                }
                ScaleAnimator {
                    target: selledButton
                    from: 1.2
                    to: 1
                }
                alwaysRunToEnd: true
                running: selledButton.down
            }
        }
    }
}
