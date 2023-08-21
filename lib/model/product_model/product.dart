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

class DataBaseProduct {
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

  factory DataBaseProduct.fromMap({required Map data}) {
    return DataBaseProduct(
        id: data['id'],
        name: data['name'],
        price: data['price'],
        qts: data['qts']);
  }
}

class DataBaseBag {
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

  factory DataBaseBag.fromMap({required Map data}) {
    return DataBaseBag(
        id: data['id'],
        name: data['name'],
        price: data['price'],
        qts: data['qts']);
  }
}

class DataBaseCoupon {
  late int id;
  late String name;
  late bool applied;

  DataBaseCoupon({
    required this.id,
    required this.name,
    required this.applied,
  });

  factory DataBaseCoupon.fromMap({required Map data}) {
    return DataBaseCoupon(
      id: data['id'],
      name: data['name'],
      applied: (data['applied'] == 0) ? false : true,
    );
  }
}
