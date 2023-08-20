class Product {
  late int id;
  late String name;
  late int price;
  late int qts;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.qts,
  });
}

class DataBaseProduct{
  late int id;
  late String name;
  late int price;
  late int qts;

  DataBaseProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.qts,
  });

  factory DataBaseProduct.fromMap({required Map data}){
    return DataBaseProduct(id: data['id'], name: data['name'], price: data['price'], qts: data['qts']);
  }
}
class DataBaseBag{
  late int id;
  late String name;
  late int price;
  late int qts;

  DataBaseBag({
    required this.id,
    required this.name,
    required this.price,
    required this.qts,
  });

  factory DataBaseBag.fromMap({required Map data}){
    return DataBaseBag(id: data['id'], name: data['name'], price: data['price'], qts: data['qts']);
  }
}
