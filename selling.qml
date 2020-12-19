import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Material.impl 2.3
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

Item {
    anchors.fill: parent

    property var var_male: true
    property var var_photoPath: ""
    property var var_id: -1
    property var var_name: ""
    property var var_price: -1
    property var var_count: -1

    FileDialog {
        id: fileDialog
        title: "Выберите фото"
        folder: shortcuts.home
        onAccepted: {
            var_photoPath = fileDialog.fileUrl
        }
    }

    Popup {
        id: addMalePopup
        x:0
        y:0
        width: 1280
        height: 720
        modal: true
        focus: true

        Text {
            id: addMaleTopText
            anchors.margins: 20
            anchors.top: parent.top
            anchors.left: parent.left
            font.family: "Roboto regular"
            font.pointSize: 18
            color: "#66666666"
            text: var_id == -1? "Создание товара" : "Редактирование товара"
        }
        TextField{
            id: addMaleName
            width: 328
            height: 76
            Material.accent: Material.DeepPurple
            anchors.top: addMaleTopText.bottom
            anchors.left: parent.left
            anchors.margins: 20
            text: var_id === -1? "" : var_name
            placeholderText: "Название"
        }
        TextField{
            id: addMalePrice
            width: 328
            height: 76
            Material.accent: Material.DeepPurple
            anchors.top: addMaleName.bottom
            anchors.left: parent.left
            anchors.margins: 20
            text: var_id === -1? "" : var_price
            placeholderText: "Цена"
        }
        TextField{
            id: addMaleNumber
            width: 328
            height: 76
            Material.accent: Material.DeepPurple
            anchors.top: addMalePrice.bottom
            anchors.left: parent.left
            anchors.margins: 20
            text: var_id === -1? "" : var_count
            placeholderText: "Количество"
        }
        Pane {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 20
            width: 222
            height: 243
            Material.elevation: 6
            Image{
                id: addMaleImagePreview
                height: 100
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                source: var_photoPath
            }
            Label{
                anchors.topMargin: 9
                anchors.top:  addMaleImagePreview.bottom
                id: addMaleNamePreview
                text: addMaleName.text
                font.family: "Roboto medium"
                font.pointSize: 13
                color: "#202020"
            }
            Label{
                anchors.topMargin: 3
                anchors.top: addMaleNamePreview.bottom
                id: addMalePricePreview
                text: addMalePrice.text + " рублей"
                font.family: "Roboto Regular"
                font.pointSize: 9
                color: "#202020"
            }
            Label{
                anchors.topMargin: 15
                anchors.top: addMalePricePreview.bottom
                id: addMaleCountAndIdPreview
                text: "Осталось: " + addMaleNumber.text + " шт\nКод товара: автоматически"
                font.family: "Roboto Regular"
                font.pointSize: 9
                color: "#646464"
            }
        }
        RoundButton{
            anchors.right: parent.right
            anchors.verticalCenter: addPhoto.verticalCenter
            anchors.margins: 20
            id: save
            icon.source: "save.png"
            icon.color: "white"
            background: Rectangle {
                implicitWidth: 40
                implicitHeight: 40
                color: "#6202EE"
                radius: parent.radius
            }
            onClicked: {
                if (var_id == -1){
                    insertItem(addMaleName.text, addMalePrice.text, addMaleNumber.text, var_photoPath, var_male)
                }else{
                    updateItem(var_id, addMaleName.text, addMalePrice.text, addMaleNumber.text, var_photoPath, var_male)
                }

                addMalePopup.close()
            }
        }
        RoundButton{
            anchors.right: save.left
            anchors.bottom: parent.bottom
            anchors.margins: 20
            id: addPhoto
            contentItem: Item {
                anchors.fill: addPhoto
                Image {
                    id: addIcon
                    source: "add.png"
                    anchors.margins: 10
                    anchors.right: addText.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                ColorOverlay {
                    anchors.fill: addIcon
                    source: addIcon
                    color: "white"
                }
                Text {
                    id: addText
                    text: "ФОТО"
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            background: Rectangle {
                implicitWidth: 90
                implicitHeight: 50
                color: "#6202EE"
                radius: parent.radius
            }
            onClicked: {
                fileDialog.open()
            }
        }
    }


    //мужская
    GridView{
        leftMargin: 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.horizontalCenter
        cellWidth: 232
        cellHeight: 253
        header: Item {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: topTextText.height + bottomTextText.height
            Label{
                id: topTextText
                anchors.bottomMargin: 10
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                font.family: "Roboto Light"
                font.pointSize: 60
                color: "#3d3d3d"
                text: "Мужская"
            }
            Label{
                id:bottomTextText
                anchors.bottomMargin: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.top: topTextText.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                font.family: "Roboto Light"
                font.pointSize: 25
                color: "#3d3d3d"
                text: "Всего: " + sellingMalePrice + " руб"
            }
        }
        id: maleGridView
        model: maleList
        delegate: Pane{
            width: 222
            height: 243
            Material.elevation: 6
            Image{
                id: image
                height: 100
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                source: modelData.photo
            }
            Label{
                anchors.topMargin: 9
                anchors.top: image.bottom
                id: name
                text: modelData.name
                font.family: "Roboto medium"
                font.pointSize: 13
                color: "#202020"
            }
            Label{
                anchors.topMargin: 3
                anchors.top: name.bottom
                id: price
                text: modelData.price + " рублей"
                font.family: "Roboto Regular"
                font.pointSize: 9
                color: "#202020"
            }
            Label{
                anchors.topMargin: 15
                anchors.top: price.bottom
                id: countAndId
                text: "Осталось: " + modelData.count + " шт\nКод товара: "+modelData.id
                font.family: "Roboto Regular"
                font.pointSize: 9
                color: "#646464"
            }
            Text {
                anchors.topMargin: 15
                anchors.top: countAndId.bottom
                id:buy
                text: "КУПИТЬ"
                font.family: "Roboto Medium"
                font.pointSize: 9
                color: "#6202EE"
                MouseArea{
                    anchors.fill: buy
                    onClicked: {
                        buyItem(modelData.id)
                    }
                }
            }
            Text {
                anchors.topMargin: 15
                anchors.leftMargin: 15
                anchors.top: countAndId.bottom
                anchors.left: buy.right
                id: trash
                text: "БРАК"
                font.family: "Roboto Medium"
                font.pointSize: 9
                color: "#6202EE"
                MouseArea{
                    anchors.fill: trash
                    onClicked: { trashItem(modelData.id) }
                }
            }
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onClicked: { maleMenu.popup() }
                Menu{
                    id: maleMenu
                    MenuItem {
                        text: "Редактировать"
                        onClicked: {
                            var_id = modelData.id
                            var_name = modelData.name
                            var_count = modelData.count
                            var_price = modelData.price
                            var_photoPath = modelData.photo
                            var_male = true
                            addMalePopup.open()
                        }
                    }
                    MenuItem {
                        text: "Удалить"
                        onClicked: {
                            deleteItem(modelData.id)
                        }
                    }
                }
            }
        }
    }
    //женская
    GridView{
        leftMargin: 10
        cellWidth: 232
        cellHeight: 253
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.horizontalCenter
        id: femaleGridView
        model: femaleList
        header: Item {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: topTextText2.height + bottomTextText2.height
            Label{
                id: topTextText2
                anchors.bottomMargin: 10
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                font.family: "Roboto Light"
                font.pointSize: 60
                color: "#3d3d3d"
                text: "Женская"
            }
            Label{
                id:bottomTextText2
                anchors.bottomMargin: 20
                horizontalAlignment: Text.AlignHCenter
                anchors.top: topTextText2.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                font.family: "Roboto Light"
                font.pointSize: 25
                color: "#3d3d3d"
                text:"Всего: " + sellingFemalePrice + " руб"
            }
        }
        delegate: Pane{
            width: 222
            height: 243
            Material.elevation: 6
            Image{
                id: femaleImage
                height: 100
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                source: modelData.photo
            }
            Label{
                anchors.topMargin: 9
                anchors.top: femaleImage.bottom
                id: femaleName
                text: modelData.name
                font.family: "Roboto medium"
                font.pointSize: 13
                color: "#202020"
            }
            Label{
                anchors.topMargin: 3
                anchors.top: femaleName.bottom
                id: femalePrice
                text: modelData.price + " рублей"
                font.family: "Roboto Regular"
                font.pointSize: 9
                color: "#202020"
            }
            Label{
                anchors.topMargin: 15
                anchors.top: femalePrice.bottom
                id: femaleCountAndId
                text: "Осталось: " + modelData.count + " шт\nКод товара: "+modelData.id
                font.family: "Roboto Regular"
                font.pointSize: 9
                color: "#646464"
            }
            Text {
                anchors.topMargin: 15
                anchors.top: femaleCountAndId.bottom
                id:femaleBuy
                text: "КУПИТЬ"
                font.family: "Roboto Medium"
                font.pointSize: 9
                color: "#6202EE"
                MouseArea{
                    anchors.fill: femaleBuy
                    onClicked: { buyItem(modelData.id) }
                }
            }
            Text {
                anchors.topMargin: 15
                anchors.leftMargin: 15
                anchors.top: femaleCountAndId.bottom
                anchors.left: femaleBuy.right
                id: femaleTrash
                text: "БРАК"
                font.family: "Roboto Medium"
                font.pointSize: 9
                color: "#6202EE"
                MouseArea{
                    anchors.fill: femaleTrash
                    onClicked: { trashItem(modelData.id) }
                }
            }
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onClicked: { femaleMenu.popup() }
                Menu{
                    id: femaleMenu
                    MenuItem {
                        text: "Редактировать"
                        onClicked: {
                            var_id = modelData.id
                            var_name = modelData.name
                            var_count = modelData.count
                            var_price = modelData.price
                            var_photoPath = modelData.photo
                            var_male = false
                            addMalePopup.open()
                        }
                    }
                    MenuItem {
                        text: "Удалить"
                        onClicked: {
                            deleteItem(modelData.id)
                        }
                    }
                }
            }
        }
    }

    RoundButton{
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 20
        id: addMale
        icon.source: "add.png"
        icon.color: "white"
        background: Rectangle {
            implicitWidth: 40
            implicitHeight: 40
            color: "#6202EE"
            radius: parent.radius
        }
        onClicked: {
            var_id = -1
            var_photoPath = ""
            var_male = true
            addMalePopup.open()
        }
    }

    RoundButton{
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        id: addFemaleMale
        icon.source: "add.png"
        icon.color: "white"
        background: Rectangle {
            implicitWidth: 40
            implicitHeight: 40
            color: "#6202EE"
            radius: parent.radius
        }
        onClicked: {
            var_id = -1
            var_photoPath = ""
            var_male = false
            addMalePopup.open()
        }
    }
}
