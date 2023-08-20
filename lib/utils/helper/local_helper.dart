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

  insertBagDB({required DataBaseProduct data}) async {
    await initDB();

      String query = "INSERT INTO bag(id, name, price, qts) VALUES(?, ?, ?, ?);";

      List args = [
        data.id,
        data.name,
        data.price,
        data.qts,
      ];

      await db!.rawInsert(query, args);

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

  Future<List<DataBaseBag>> fetchBagData() async {
    await initDB();
    // if(box.read('insertBag') != true){
    //   await insertDB();
    // }

    Insert_GC insert = Insert_GC();

    // insert.trueWhenInsert();

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
  deleteBagDB({required int id}) async {
    await initDB();

    String query = "DELETE FROM bag WHERE id = ?";

    List args = [id];

    await db!.rawUpdate(query,args);
  }
}
