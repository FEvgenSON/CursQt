import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Item {
    anchors.fill: parent

    Label{
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        id:maleLable
        font.family: "Roboto Light"
        font.pointSize: 60
        color: "#3d3d3d"
        text: "Мужская"
    }

    Label{
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.horizontalCenter
        id:femaleLable
        font.family: "Roboto Light"
        font.pointSize: 60
        color: "#3d3d3d"
        text: "Женская"
    }

    //мужская
    GridView{
        topMargin: 10
        leftMargin: 10
        anchors.top: maleLable.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.horizontalCenter
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
                source: "data:image/png;base64,"+modelData.photo
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
                    onClicked: { container.clicked() }
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
                    onClicked: { container.clicked() }
                }
            }
        }
    }
    //женская
    GridView{
        topMargin: 10
        leftMargin: 10
        anchors.top: femaleLable.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.horizontalCenter
        id: femaleGridView
        model: maleList
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
                source: "data:image/png;base64,"+modelData.photo
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
                    onClicked: { container.clicked() }
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
                    onClicked: { container.clicked() }
                }
            }
        }
    }
}
