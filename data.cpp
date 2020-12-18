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

struct SelledProduct{
    int id = 0;
    std::string name;
    int price;
    int count;
    std::string photo;
    bool male;
};

struct TrashProduct{
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

QMLProduct toQMLProduct(SelledProduct product){
    QMLProduct qmlProduct;
    qmlProduct._id = product.id;
    qmlProduct._name = QString::fromStdString(product.name);
    qmlProduct._price = product.price;
    qmlProduct._count = product.count;
    qmlProduct._photo = QString::fromStdString(product.photo);
    qmlProduct._male = product.male;
    return qmlProduct;
}

QMLProduct toQMLProduct(TrashProduct product){
    QMLProduct qmlProduct;
    qmlProduct._id = product.id;
    qmlProduct._name = QString::fromStdString(product.name);
    qmlProduct._price = product.price;
    qmlProduct._count = product.count;
    qmlProduct._photo = QString::fromStdString(product.photo);
    qmlProduct._male = product.male;
    return qmlProduct;
}

SelledProduct toSelledProduct(Product product){
    SelledProduct selledProduct;
    selledProduct.id = product.id;
    selledProduct.name = product.name;
    selledProduct.price = product.price;
    selledProduct.count = product.count;
    selledProduct.photo = product.photo;
    selledProduct.male = product.male;
    return selledProduct;
}

TrashProduct toTrashProduct(Product product){
    TrashProduct trashProduct;
    trashProduct.id = product.id;
    trashProduct.name = product.name;
    trashProduct.price = product.price;
    trashProduct.count = product.count;
    trashProduct.photo = product.photo;
    trashProduct.male = product.male;
    return trashProduct;
}

TrashProduct toTrashProduct(SelledProduct product){
    TrashProduct trashProduct;
    trashProduct.id = product.id;
    trashProduct.name = product.name;
    trashProduct.price = product.price;
    trashProduct.count = product.count;
    trashProduct.photo = product.photo;
    trashProduct.male = product.male;
    return trashProduct;
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
                ),
            make_table(
                "selled",
                make_column("id",&SelledProduct::id, autoincrement(), primary_key()),
                make_column("name",&SelledProduct::name),
                make_column("price",&SelledProduct::price),
                make_column("count",&SelledProduct::count),
                make_column("photo",&SelledProduct::photo),
                make_column("male",&SelledProduct::male)
                ),
            make_table(
                "trash",
                make_column("id",&TrashProduct::id, autoincrement(), primary_key()),
                make_column("name",&TrashProduct::name),
                make_column("price",&TrashProduct::price),
                make_column("count",&TrashProduct::count),
                make_column("photo",&TrashProduct::photo),
                make_column("male",&TrashProduct::male)
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

void buyProduct(int id){
    auto product = storage.get<Product>(id);
    if (product.count == 1){
        storage.remove<Product>(id);
    }else{
        product.count--;
        storage.update<Product>(product);
    }
    auto selledProduct = storage.get_pointer<SelledProduct>(id);
    if (selledProduct == nullptr){
        product.count = 1;
        storage.insert<SelledProduct>(toSelledProduct(product));
    }else{
        selledProduct->count++;
        storage.update<SelledProduct>(*selledProduct);
    }
}

void sellingTrash(int id){
    auto product = storage.get<Product>(id);
    if (product.count == 1){
        storage.remove<Product>(id);
    }else{
        product.count--;
        storage.update<Product>(product);
    }
    auto trashProduct = storage.get_pointer<TrashProduct>(id);
    if (trashProduct == nullptr){
        product.count = 1;
        storage.insert<TrashProduct>(toTrashProduct(product));
    }else{
        trashProduct->count++;
        storage.update<TrashProduct>(*trashProduct);
    }
}

void selledTrash(int id){
    auto product = storage.get<SelledProduct>(id);
    if (product.count == 1){
        storage.remove<SelledProduct>(id);
    }else{
        product.count--;
        storage.update<SelledProduct>(product);
    }
    auto trashProduct = storage.get_pointer<TrashProduct>(id);
    if (trashProduct == nullptr){
        product.count = 1;
        storage.insert<TrashProduct>(toTrashProduct(product));
    }else{
        trashProduct->count++;
        storage.update<TrashProduct>(*trashProduct);
    }
}
#include "data.moc"
