import 'package:exam_2/model/product_model/product.dart';
import 'package:exam_2/utils/helper/local_helper.dart';
import 'package:exam_2/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<DataBaseProduct>> getData;

  @override
  void initState() {
    super.initState();
    getData = DBHelper.dbHelper.fetchData();
    localData();
  }

  localData() async {
    print("${getData}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed('cart_page');
                },
                icon: Icon(
                  CupertinoIcons.bag,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
            future: getData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                List<DataBaseProduct>? data = snapshot.data;

                return (data == null || data.isEmpty)
                    ? Center(
                        child: Text("Error : null"),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              leading: Text(data[i].id.toString()),
                              title: Text(data[i].name),
                              subtitle: Text(data[i].price.toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      print("1");
                                      DBHelper.dbHelper.insertBagDB(data: data[i]);

                                      totalPrice += data[i].price;
                                      print("2");
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
