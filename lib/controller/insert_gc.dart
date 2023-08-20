import 'package:exam_2/model/insert_model/insert.dart';
import 'package:exam_2/utils/utils.dart';
import 'package:get/get.dart';

class Insert_GC extends GetxController{
  Insert insert = Insert(insert: box.read('insert') ?? false, insertBag: box.read('insertBag') ?? false);

  trueWhenInsert() async {
    insert.insert = true;
    await box.write('insert', insert.insert);
  }
  trueWhenInsertBag() async {
    insert.insertBag = true;
    await box.write('insertBag', insert.insertBag);
  }
}