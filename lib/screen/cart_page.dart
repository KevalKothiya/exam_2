import 'package:exam_2/model/product_model/product.dart';
import 'package:exam_2/utils/helper/local_helper.dart';
import 'package:exam_2/utils/utils.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<DataBaseBag>> getDataBag;

  @override
  void initState() {
    super.initState();
    getDataBag = DBHelper.dbHelper.fetchBagData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
      ),
      body: Container(
        child: FutureBuilder(
            future: getDataBag,
            builder: (context, ss) {
              if (ss.hasError) {
                return Center(
                  child: Text(ss.error.toString()),
                );
              } else if (ss.hasData) {
                List<DataBaseBag>? data = ss.data;
                return (data == null || data.isEmpty)
                    ? Center(
                        child: Text("Error"),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              color: Colors.grey.withOpacity(0.2),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total Price : $totalPrice'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      leading: Text(data[i].id.toString()),
                                      title: Text(data[i].name),
                                      subtitle: Text(
                                          "${data[i].price} \n ${data[i].qts}"),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              print("1");
                                              DBHelper.dbHelper.updateBagDB(
                                                  qts: --data[i].qts,
                                                  id: data[i].id);
                                              totalPrice -= data[i].price;
                                              if (data[i].qts == 0) {
                                                DBHelper.dbHelper.deleteBagDB(
                                                    id: data[i].id);
                                              }
                                              setState(() {});
                                              print("2");
                                            },
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              print("1");
                                              DBHelper.dbHelper.updateBagDB(
                                                  qts: ++data[i].qts,
                                                  id: data[i].id);
                                              print("2");

                                              totalPrice += data[i].price;

                                              setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStatePropertyAll(Size(50, 20))
                              ),
                              onPressed: () {},
                              child: Text("Check Out"),
                            ),
                          ),
                        ],
                      );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
