import 'dart:developer';

import 'package:exam_2/controller/insert_gc.dart';
import 'package:exam_2/model/product_model/product.dart';
import 'package:exam_2/utils/product/allProduct.dart';
import 'package:exam_2/utils/utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static Database? db;

  static final DBHelper dbHelper = DBHelper._();

  initDB() async {
    String dbLocation = await getDatabasesPath();

    String path = join(dbLocation, 'local.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {

        String query =
            "CREATE TABLE IF NOT EXISTS data(id INTEGER,name TEXT, price INTEGER, qts INTEGER);";

        db.execute(query);

        String query1 =
            "CREATE TABLE IF NOT EXISTS bag(id INTEGER,name TEXT, price INTEGER, qts INTEGER);";

        db.execute(query1);

        String query2 =
            "CREATE TABLE IF NOT EXISTS coupon(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, applied INTEGER);";

        db.execute(query2);


      },
    );
  }

  insertDB() async {
    await initDB();
    List<Product> product = AllProduct.allitems;
    log(product.length.toString());
    for(int i = 0; i < product.length; i++){
      String query = "INSERT INTO data(id, name, price, qts) VALUES(?, ?, ?, ?);";

      List args = [
        product[i].id,
        product[i].name,
        product[i].price,
        product[i].qts,
      ];

      await db!.rawInsert(query, args);
    }
  }

  Future<List<DataBaseProduct>> fetchData() async {
    await initDB();
    if(box.read('insert') != true){
      await insertDB();
    }

    Insert_GC insert = Insert_GC();

    insert.trueWhenInsert();

    String query = "SELECT * FROM data";

    List<Map<String, dynamic>> allQuotes = (await db!.rawQuery(query));

    List<DataBaseProduct> quotes = allQuotes
        .map((e) => DataBaseProduct.fromMap(
      data: e,
    ))
        .toList();

    return quotes;
  }

  insertBagDB({required List<DataBaseProduct> data}) async {
    await initDB();

   for(int i = 0; i < data.length; i++){
     String query = "INSERT INTO bag(id, name, price, qts) VALUES(?, ?, ?, ?);";

     List args = [
       data[i].id,
       data[i].name,
       data[i].price,
       data[i].qts,
     ];

     await db!.rawInsert(query, args);
   }

  }

  Future<List<DataBaseBag>> fetchBagData() async {
    await initDB();

    String query = "SELECT * FROM bag";

    List<Map<String, dynamic>> allQuotes = (await db!.rawQuery(query));

    List<DataBaseBag> quotes = allQuotes
        .map((e) => DataBaseBag.fromMap(
      data: e,
    ))
        .toList();

    return quotes;
  }

  updateBagDB({required int qts, required int id}) async {
    await initDB();

    String query = "UPDATE bag SET qts = ? WHERE id = ?;";

    List args = [qts, id];

    await db!.rawUpdate(query,args);
  }

  deleteBagAllItemDB() async {
    await initDB();

    String query = "DELETE FROM bag";

    await db!.rawUpdate(query);

  }

  deleteBagDB({required int id}) async {
    await initDB();

    String query = "DELETE FROM bag WHERE id = ?";

    List args = [id];

    await db!.rawUpdate(query,args);
  }

  insertCouponDB({required String name, required bool applied}) async {
    await initDB();
    print("Start");

    int applyCoupon = (applied)?1:0;
    String query = "INSERT INTO coupon(name, applied) VALUES(?, ?);";

    List args = [
      name,
      applyCoupon,
    ];

    await db!.rawInsert(query, args);
    print("End");
  }

  Future<List<DataBaseCoupon>> fetchCouponDB() async {
    await initDB();

    String sql = "SELECT * FROM coupon";

    List<Map<String, dynamic>> decoded = await db!.rawQuery(sql);

    List<DataBaseCoupon> data = decoded.map((e) => DataBaseCoupon.fromMap(data: e)).toList();

    return data;
  }

  updateCouponDB({required String name, required bool applied}) async {
    await initDB();

    int isApply = applied ? 1 : 0;

    String sql = "UPDATE coupon SET applied = ? WHERE name = ?;";

    List args = [
      isApply,
      name,
    ];

    db!.rawUpdate(sql, args);

  }
}
