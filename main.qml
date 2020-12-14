import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.4
import QtGraphicalEffects 1.0

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Curs Filimoshin IP-816")

    Loader {
        id: container
        anchors.bottom: bottomNavigation.top
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        source: "selling.qml"

        function loadScreen(index) {
            switch (index) {
            case 0:
                container.source = "selling.qml"
                break
            case 1:
                container.source = "selled.qml"
                break
            case 2:
                container.source = "returned.qml"
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
                implicitHeight: 40
                color: "white"
            }
            contentItem: Item {
                anchors.fill: sellingButton
                Image {
                    id: sellingIcon
                    source: "selling.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.verticalCenter
                }
                ColorOverlay {
                    anchors.fill: sellingIcon
                    source: sellingIcon
                    color: bottomNavigation.currentIndex === 0 ? "#6202EE" : "#757575"
                }
                Text {
                    id: sellinText
                    text: "В продаже"
                    color: bottomNavigation.currentIndex === 0 ? "#6202EE" : "#757575"
                    anchors.top: sellingIcon.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            SequentialAnimation {
                ScaleAnimator {
                    target: sellingButton
                    from: 1
                    to: 0.5
                }
                ScaleAnimator {
                    target: sellingButton
                    from: 0.5
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
                implicitHeight: 40
                color: "white"
            }
            contentItem: Item {
                anchors.fill: selledButton
                Image {
                    id: selledIcon
                    source: "selled.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.verticalCenter
                }
                ColorOverlay {
                    anchors.fill: selledIcon
                    source: selledIcon
                    color: bottomNavigation.currentIndex === 1 ? "#6202EE" : "#757575"
                }
                Text {
                    id: selledText
                    text: "Продано"
                    color: bottomNavigation.currentIndex === 1 ? "#6202EE" : "#757575"
                    anchors.top: selledIcon.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            SequentialAnimation {
                ScaleAnimator {
                    target: selledButton
                    from: 1
                    to: 0.5
                }
                ScaleAnimator {
                    target: selledButton
                    from: 0.5
                    to: 1
                }
                alwaysRunToEnd: true
                running: selledButton.down
            }
        }

        TabButton {
            id: returnedButton
            onClicked: container.loadScreen(2)
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                color: "white"
            }
            contentItem: Item {
                anchors.fill: returnedButton
                Image {
                    id: returnedIcon
                    source: "returned.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.verticalCenter
                }
                ColorOverlay {
                    anchors.fill: returnedIcon
                    source: returnedIcon
                    color: bottomNavigation.currentIndex === 2 ? "#6202EE" : "#757575"
                }
                Text {
                    id: returnedText
                    text: "Возврат/брак"
                    color: bottomNavigation.currentIndex === 2 ? "#6202EE" : "#757575"
                    anchors.top: returnedIcon.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            SequentialAnimation {
                ScaleAnimator {
                    target: returnedButton
                    from: 1
                    to: 0.5
                }
                ScaleAnimator {
                    target: returnedButton
                    from: 0.5
                    to: 1
                }
                alwaysRunToEnd: true
                running: returnedButton.down
            }
        }
    }
}
