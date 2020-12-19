import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Material.impl 2.3
import QtQuick.Dialogs 1.2

Item{
    anchors.fill: parent
    Text {
        anchors.fill: parent
        text: "На экране продажи можно:
1) создавать товар по нажатию на кнопку + (слева мужской, справа женский)
2) редактировать и удалять товар по нажатию на правую кнопку мыши
3) покупать один item товара (товар переходит в раздел проданно)
4) помечать один item товара как брак (товар перейдет в разде брак)
5) смотреть стоимость всех мужских и женских товаров в продаже

На экране создания товара можно создавать и редактировать товар

На экране продано можно:
1) помечать возврат товара (товар перейдет в раздел возврат)
2) смотреть прибыль с иужских и женских товаров

На экране возврат и брак можно смотреть потеряную прибыль"
        font.family: "Roboto regular"
        font.pointSize: 12
        color: "#3d3d3d"
    }
}
