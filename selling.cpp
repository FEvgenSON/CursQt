#include <QObject>
#include <QQmlListProperty>
#include "data.cpp"

class Selling : public QObject{

    Q_OBJECT

    Q_PROPERTY(QVariantList maleList READ maleList NOTIFY maleListChanged)
    QVariantList maleList(){
        auto list = getAllMaleProduct();
        QVariantList result;
        for (auto item : list){
            result << QVariant::fromValue(item);
        }
        return result;
    }

    Q_PROPERTY(QVariantList femaleList READ femaleList NOTIFY maleListChanged)
    QVariantList femaleList(){
        auto list = getAllFemaleProduct();
        QVariantList result;
        for (auto item : list){
            result << QVariant::fromValue(item);
        }
        return result;
    }

public:
    Q_INVOKABLE void deleteItem(int id){
        deleteProduct(id);
        emit maleListChanged();
        emit femaleListChanged();
    }

    Q_INVOKABLE void insertItem(QString name, int price, int count, QString photo, bool male){
        Product product;
        product.name = name.toStdString();
        product.price = price;
        product.count = count;
        product.male = male;
        product.photo = photo.toStdString();
        insertProduct(product);
        emit maleListChanged();
        emit femaleListChanged();
    }

    Q_INVOKABLE void updateItem(int id, QString name, int price, int count, QString photo, bool male){
        Product product;
        product.id = id;
        product.name = name.toStdString();
        product.price = price;
        product.count = count;
        product.photo = photo.toStdString();
        product.male = male;
                updateProduct(product);
        emit maleListChanged();
        emit femaleListChanged();
    }

signals:
    void maleListChanged();
    void femaleListChanged();
};
#include "selling.moc"
