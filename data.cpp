#include <string>
#include <sqlite_orm/sqlite_orm.h>
#include <vector>
#include <QObject>

using namespace sqlite_orm;

struct Product{
    int id = 0;
    std::string name;
    int price;
    int count;
    std::string photo;
    bool male;
};

struct QMLProduct{
    Q_GADGET
    Q_PROPERTY(int id MEMBER _id)
    Q_PROPERTY(QString name MEMBER _name)
    Q_PROPERTY(int price MEMBER _price)
    Q_PROPERTY(int count MEMBER _count)
    Q_PROPERTY(QString photo MEMBER _photo)
    Q_PROPERTY(bool male MEMBER _male)
public:
    int _id = 0;
    QString _name;
    int _price;
    int _count;
    QString _photo;
    bool _male;
};
Q_DECLARE_METATYPE(QMLProduct)

QMLProduct toQMLProduct(Product product){
    QMLProduct qmlProduct;
    qmlProduct._id = product.id;
    qmlProduct._name = QString::fromStdString(product.name);
    qmlProduct._price = product.price;
    qmlProduct._count = product.count;
    qmlProduct._photo = QString::fromStdString(product.photo);
    qmlProduct._male = product.male;
    return qmlProduct;
}

auto storage = make_storage(
            "main.db",
            make_table(
                "selling",
                make_column("id",&Product::id, autoincrement(), primary_key()),
                make_column("name",&Product::name),
                make_column("price",&Product::price),
                make_column("count",&Product::count),
                make_column("photo",&Product::photo),
                make_column("male",&Product::male)
                )
            );

bool syncSchema(){
    storage.sync_schema();
    return true;
}

bool schemaSynced = syncSchema();

QMLProduct getProduct(int id){
    return toQMLProduct(storage.get<Product>(id));
}

void insertProduct(Product product){
    storage.insert(product);
}

void updateProduct(Product product){
    storage.update<Product>(product);
}

QList<QMLProduct> getAllMaleProduct(){
    auto productList = storage.get_all<Product>();
    QList<QMLProduct> qmlProductList;
    for(auto product: productList){
        if (product.male){
            qmlProductList.push_back(toQMLProduct(product));
        }
    }
    return qmlProductList;
}

QList<QMLProduct> getAllFemaleProduct(){
    auto productList = storage.get_all<Product>();
    QList<QMLProduct> qmlProductList;
    for(auto product: productList){
        if (!product.male){
            qmlProductList.push_back(toQMLProduct(product));
        }
    }
    return qmlProductList;
}

void deleteProduct(int id){
    storage.remove<Product>(id);
}
#include "data.moc"
