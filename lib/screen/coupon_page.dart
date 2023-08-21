import 'dart:ffi';

import 'package:exam_2/model/product_model/product.dart';
import 'package:exam_2/utils/helper/local_helper.dart';
import 'package:exam_2/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {


  late Future<List<DataBaseCoupon>> getCouponData;

  @override
  void initState() {
    super.initState();
    getCouponData = DBHelper.dbHelper.fetchCouponDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupon Page"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Cansel"),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (controller.text.isEmpty)
                ? Text(
                    "Enter Username First",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Container(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                onFieldSubmitted: (val) {
                  name = val;
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter username...",
                  labelText: "Username",
                ),
              ),
            ),
            (controller.text.isEmpty)
                ? Container()
                : FutureBuilder(
                    future: getCouponData,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        List<DataBaseCoupon>? data = snapshot.data;
                        bool apply = true;

                        if (name != null) {
                          if (data!.isNotEmpty) {
                            for (int i = 0; i < data.length; i++) {
                              if (name == data[i].name) {
                                apply = true;
                                break;
                              } else {
                                apply = false;
                              }
                            }
                          }
                        }
                        return (data == null)
                            ? Center(
                                child: Text("Empty"),
                              )
                            : (data.isEmpty)
                                ? Column(
                                    children: [
                                      ElevatedButton(onPressed: null, child: Text("Save"),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [

                                          Text("Apply For 5% Discount"),
                                          Spacer(),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: (apply5)
                                                  ? MaterialStatePropertyAll(
                                                      Colors.green)
                                                  : MaterialStatePropertyAll(
                                                      Color(0xfff7f1f9),
                                                    ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                apply5 = !apply5;
                                                if(apply5){
                                                  totalPrice = totalPrice - ((totalPrice ~/ 100) * 5).toInt();
                                                  Navigator.pushReplacementNamed(context, '/cart_page').then((value) => setState((){}));
                                                }
                                              });
                                            },
                                            child: Text("Apply"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Apply For 10% Discount"),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                apply10 = !apply10;
                                                if(apply10){
                                                  totalPrice = totalPrice - ((totalPrice ~/ 100) * 10).toInt();
                                                  Navigator.pushReplacementNamed(context, '/cart_page').then((value) => setState((){}));
                                                }
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: (apply10)
                                                  ? MaterialStatePropertyAll(
                                                  Colors.green)
                                                  : MaterialStatePropertyAll(
                                                Color(0xfff7f1f9),
                                              ),
                                            ),
                                            child: Text("Apply"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Apply For 15% Discount"),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                apply15 = !apply15;
                                                if(apply15){
                                                  totalPrice = totalPrice - ((totalPrice ~/ 100) * 15).toInt();
                                                  Navigator.pushReplacementNamed(context, '/cart_page').then((value) => setState((){}));
                                                }
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: (apply15)
                                                  ? MaterialStatePropertyAll(
                                                  Colors.green)
                                                  : MaterialStatePropertyAll(
                                                Color(0xfff7f1f9),
                                              ),
                                            ),
                                            child: Text("Apply"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Apply For 20% Discount"),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                apply20 = !apply20;
                                                if(apply20){
                                                  totalPrice = totalPrice - ((totalPrice ~/ 100) * 20).toInt();
                                                  Navigator.pushReplacementNamed(context, '/cart_page').then((value) => setState((){}));
                                                }
                                              });
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: (apply20)
                                                  ? MaterialStatePropertyAll(
                                                  Colors.green)
                                                  : MaterialStatePropertyAll(
                                                Color(0xfff7f1f9),
                                              ),
                                            ),
                                            child: Text("Apply"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(onPressed: (){}, child: Text("Save"),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      (apply)
                                          ? Center(
                                              child: Text(
                                                  "User Already Use Coupon"),
                                            )
                                          : Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Text("Apply For 5% Discount"),
                                              Spacer(),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: (apply5)
                                                      ? MaterialStatePropertyAll(
                                                      Colors.green)
                                                      : MaterialStatePropertyAll(
                                                    Color(0xfff7f1f9),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    apply5 = !apply5;
                                                    if(apply5){
                                                      totalPrice = totalPrice - ((totalPrice ~/ 100) * 5).toInt();
                                                      Navigator.pushReplacementNamed(context, '/cart_page').then((value) => setState((){}));
                                                    }
                                                  });
                                                },
                                                child: Text("Apply"),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Apply For 10% Discount"),
                                              Spacer(),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    apply10 = !apply10;
                                                    if(apply10){
                                                      totalPrice = totalPrice - ((totalPrice ~/ 100) * 10).toInt();
                                                      Navigator.pushReplacementNamed(context, '/cart_page').then((value) => setState((){}));
                                                    }
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: (apply10)
                                                      ? MaterialStatePropertyAll(
                                                      Colors.green)
                                                      : MaterialStatePropertyAll(
                                                    Color(0xfff7f1f9),
                                                  ),
                                                ),
                                                child: Text("Apply"),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Apply For 15% Discount"),
                                              Spacer(),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    apply15 = !apply15;
                                                    if(apply15){
                                                      totalPrice = totalPrice - ((totalPrice ~/ 100) * 15).toInt();
                                                      Navigator.pushReplacementNamed(context, '/cart_page').then((value) => setState((){}));
                                                    }
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: (apply15)
                                                      ? MaterialStatePropertyAll(
                                                      Colors.green)
                                                      : MaterialStatePropertyAll(
                                                    Color(0xfff7f1f9),
                                                  ),
                                                ),
                                                child: Text("Apply"),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Apply For 20% Discount"),
                                              Spacer(),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    apply20 = !apply20;
                                                    if(apply20){
                                                      totalPrice = totalPrice - ((totalPrice ~/ 100) * 20).toInt();
                                                      Navigator.pushReplacementNamed(context, '/cart_page').then((value) => setState((){}));
                                                    }
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: (apply20)
                                                      ? MaterialStatePropertyAll(
                                                      Colors.green)
                                                      : MaterialStatePropertyAll(
                                                    Color(0xfff7f1f9),
                                                  ),
                                                ),
                                                child: Text("Apply"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
