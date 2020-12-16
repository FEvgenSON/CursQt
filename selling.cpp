#include <QObject>
#include <QQmlListProperty>
#include "data.cpp"

class Selling : public QObject{

    Q_OBJECT

    Q_PROPERTY(QVariantList maleList READ maleList CONSTANT)
    QVariantList maleList(){
        auto list = getAllMaleProduct();
        QVariantList result;
        for (auto item : list){
            result << QVariant::fromValue(item);
        }
        return result;
    }

    Q_PROPERTY(QVariantList femaleList READ femaleList CONSTANT)
    QVariantList femaleList(){
        auto list = getAllFemaleProduct();
        QVariantList result;
        for (auto item : list){
            result << QVariant::fromValue(item);
        }
        return result;
    }
};
#include "selling.moc"
