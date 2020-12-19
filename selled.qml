import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Material.impl 2.3
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

Item {
    anchors.fill: parent

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
                text: "Всего: " +selledMalePrice+" руб"
            }
        }
        id: maleGridView
        model: maleSelledList
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
                fillMode: Image.PreserveAspectFit
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
                text: "Продано: " + modelData.count + " шт\nКод товара: "+modelData.oldId
                font.family: "Roboto Regular"
                font.pointSize: 9
                color: "#646464"
            }
            Text {
                anchors.topMargin: 15
                anchors.top: countAndId.bottom
                id:buy
                text: "ВОЗВРАТ"
                font.family: "Roboto Medium"
                font.pointSize: 9
                color: "#6202EE"
                MouseArea{
                    anchors.fill: buy
                    onClicked: {
                        trashSelledItem(modelData.id)
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
        model: femaleSelledList
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
                text: "Всего: "+selledFemalePrice+" руб"
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
                fillMode: Image.PreserveAspectFit
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
                text: "Продано: " + modelData.count + " шт\nКод товара: "+modelData.oldId
                font.family: "Roboto Regular"
                font.pointSize: 9
                color: "#646464"
            }
            Text {
                anchors.topMargin: 15
                anchors.top: femaleCountAndId.bottom
                id:femaleBuy
                text: "ВОЗВРАТ"
                font.family: "Roboto Medium"
                font.pointSize: 9
                color: "#6202EE"
                MouseArea{
                    anchors.fill: femaleBuy
                    onClicked: { trashSelledItem(modelData.id) }
                }
            }
        }
    }
}
