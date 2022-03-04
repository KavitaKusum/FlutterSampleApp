import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../cart/cart.dart';
import '../../themes/color.dart';
import 'productdetail.dart';

class Products extends StatefulWidget {
  final category_id;

  Products({@required this.category_id});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var id;

  var cartitem;
  List products = [];

  fetchProducts() async {
    setState(() {
      id = widget.category_id;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String response = await rootBundle.loadString('assets/products.json');
    var data = json.decode(response);
    setState(() {
      data = json.decode(response);
      products = data[widget.category_id];
      cartitem = preferences.getString("cartitem");
    });
  }

  bool like = false;
  Color grey = Colors.grey;
  Color red = Colors.red;
  var qty;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  FutureOr onBack(dynamic value) {
    refreshCartItem();
  }

  Future<void> refreshCartItem() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      cartitem = preferences.getString("cartitem");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 38, left: 50, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => cart())).then(onBack);
                          },
                          child: Icon(Icons.shopping_cart)),
                      CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.red,
                          child: Text(cartitem.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        backgroundColor: primary,
      ),
      body: Container(
          child: products.length < 1
              ? Container(
                  child: Center(
                      child: Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.green),
                )))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: size.height * 0.21,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                        product_id: products[index]["id"],
                                        productImg: products[index]["img"],
                                        name: products[index]["name"],
                                        price: products[index]["price"],
                                        weight: products[index]["weight"]))).then(onBack);
                          },
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 135,
                                      height: 135,
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 100,
                                              width: 100,
                                              margin: EdgeInsets.only(
                                                left: 20,
                                              ),
                                              child: Image(
                                                  image: AssetImage(
                                                      products[index]["img"]),
                                                  fit: BoxFit.fill)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Row(children: [
                                          Text(
                                            products[index]["name"].toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ]),
                                        SizedBox(height: 10),
                                        Row(children: [
                                          Text("M.R.P :  ₹"),
                                          Text(
                                            products[index]["price"].toString(),
                                            style: TextStyle(
                                                color: Colors.black87),
                                          )
                                        ]),
                                        SizedBox(height: 10),
                                        Container(
                                            margin: EdgeInsets.only(right: 100),
                                            child: Text(
                                              products[index]["weight"]
                                                      .toString() +
                                                  " Kg",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                  })),
    );
  }
}
