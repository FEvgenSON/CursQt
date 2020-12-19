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

    Q_PROPERTY(int sellingMalePrice READ sellingMalePrice NOTIFY maleListChanged)
    int sellingMalePrice(){
        return getMaleSellingPrice();
    }

    Q_PROPERTY(int sellingFemalePrice READ sellingFemalePrice NOTIFY maleListChanged)
    int sellingFemalePrice(){
        return getFemaleSellingPrice();
    }

    Q_PROPERTY(QVariantList maleSelledList READ maleSelledList NOTIFY maleListChanged)
    QVariantList maleSelledList(){
        auto list = getAllSelledMaleProduct();
        QVariantList result;
        for (auto item : list){
            result << QVariant::fromValue(item);
        }
        return result;
    }

    Q_PROPERTY(QVariantList femaleSelledList READ femaleSelledList NOTIFY maleListChanged)
    QVariantList femaleSelledList(){
        auto list = getAllSelledFemaleProduct();
        QVariantList result;
        for (auto item : list){
            result << QVariant::fromValue(item);
        }
        return result;
    }

    Q_PROPERTY(int selledMalePrice READ selledMalePrice NOTIFY maleListChanged)
    int selledMalePrice(){
        return getMaleSelledPrice();
    }

    Q_PROPERTY(int selledFemalePrice READ selledFemalePrice NOTIFY maleListChanged)
    int selledFemalePrice(){
        return getFemaleSelledPrice();
    }


    Q_PROPERTY(QVariantList maleTrashList READ maleTrashList NOTIFY maleListChanged)
    QVariantList maleTrashList(){
        auto list = getAllTrashMaleProduct();
        QVariantList result;
        for (auto item : list){
            result << QVariant::fromValue(item);
        }
        return result;
    }

    Q_PROPERTY(QVariantList femaleTrashList READ femaleTrashList NOTIFY maleListChanged)
    QVariantList femaleTrashList(){
        auto list = getAllTrashFemaleProduct();
        QVariantList result;
        for (auto item : list){
            result << QVariant::fromValue(item);
        }
        return result;
    }

    Q_PROPERTY(int trashMalePrice READ trashMalePrice NOTIFY maleListChanged)
    int trashMalePrice(){
        return getMaleTrashPrice();
    }

    Q_PROPERTY(int trashFemalePrice READ trashFemalePrice NOTIFY maleListChanged)
    int trashFemalePrice(){
        return getFemaleTrashPrice();
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

    Q_INVOKABLE void buyItem(int id){
        buyProduct(id);
        emit maleListChanged();
        emit femaleListChanged();
    }

    Q_INVOKABLE void trashItem(int id){
        sellingTrash(id);
        emit maleListChanged();
        emit femaleListChanged();
    }

    Q_INVOKABLE void trashSelledItem(int id){
        selledTrash(id);
        emit maleListChanged();
        emit femaleListChanged();
    }

signals:
    void maleListChanged();
    void femaleListChanged();
};
#include "selling.moc"
