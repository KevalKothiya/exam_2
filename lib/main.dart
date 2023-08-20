import 'package:exam_2/screen/cart_page.dart';
import 'package:exam_2/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage(),),
        GetPage(name: '/cart_page', page: () => CartPage(),),
      ],
    ),
  );
}
