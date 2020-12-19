import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Material.impl 2.3
import QtQuick.Dialogs 1.2

Loader{

    id: loader

    sourceComponent: loading
    active: true
    visible: true
    onStatusChanged: {
        if (loading.status === Loader.Ready)
            item.show()
    }

    Component{
        id: loading
        Window {
            id: splashWindow
            signal timeout
            width: 300
            height: 200
            modality: Qt.ApplicationModal
            flags: Qt.SplashScreen
            Text{
                text: "LOADING...."
                font.family: "Roboto Light"
                font.pointSize: 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "#3d3d3d"
            }

            ProgressBar {
                id: progress
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                value: 0
                from: 0
                to: 50
            }
            Timer {
                id: timer
                interval: 50
                running: true
                repeat: true
                onTriggered: {
                    progress.value++
                    if (progress.value >= 50) {
                        timer.stop()
                        loader.sourceComponent = main
                        loader.item.show()
                    }
                }
            }
        }
    }

    Component{
        id: main
        Window {
            width: 1280
            height: 720
            maximumHeight: 720
            maximumWidth: 1280

            minimumHeight: 720
            minimumWidth: 1280
            visible: true
            title: qsTr("Curs Filimoshin IP-816")

            Dialog{
                id: helpDialog
                title: "HELP"
                width: 640
                height: 480
                contentItem: Loader{
                    source: "help.qml"
                }
            }

            Text {
                id: help
                text: "Help"
                anchors.margins: 5
                anchors.left: parent.left
                anchors.top: parent.top
                font.pointSize: 15
                MouseArea{
                    anchors.fill: help
                    onClicked: {
                        helpDialog.open()
                    }
                }
            }

            Loader {
                id: container
                anchors.bottom: bottomNavigation.top
                anchors.top: help.bottom
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

                TabButton {
                    id: returnedButton
                    onClicked: container.loadScreen(2)
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "transparent"
                        Ripple {
                            clipRadius: 2
                            width: parent.width
                            height: parent.height
                            pressed: returnedButton.pressed
                            anchor: returnedButton
                            active: returnedButton.down || returnedButton.visualFocus
                                    || returnedButton.hovered
                            color: "#e6e6e6"
                        }
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
                            to: 0.7
                        }
                        ScaleAnimator {
                            target: returnedButton
                            from: 0.7
                            to: 1.2
                        }
                        ScaleAnimator {
                            target: returnedButton
                            from: 1.2
                            to: 1
                        }
                        alwaysRunToEnd: true
                        running: returnedButton.down
                    }
                }
            }
        }
    }
}
