import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabkabazaar/views/product/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cart/cart.dart';
import '../../themes/color.dart';
import 'dart:convert';

List<dynamic> category = [];
var cartitem;

class categories extends StatefulWidget {
  @override
  _categoriesState createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  Future fetchCategory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', "loggedin");
    final String response = await rootBundle.loadString('assets/category.json');
    category = json.decode(response);
    setState(() {
      category = json.decode(response);
      cartitem = preferences.getString("cartitem");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          flexibleSpace: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 38, left: 50, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sabka Bazaar",
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
        ),
        body: Body());
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
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Shop by category",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          card2(),
        ],
      ),
    );
  }
}

class card2 extends StatefulWidget {
  @override
  _card2State createState() => _card2State();
}

class _card2State extends State<card2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      child: category.length < 1
          ? Center(
              child: Column(children: [
              SizedBox(
                height: 200,
              ),
              Text(
                "",
              )
            ]))
          : GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: category.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (orientation == Orientation.portrait) ? 2 : 3),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Products(category_id: category[index]["id"]))).then(onBack);
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            child: Image(
                                image: AssetImage(
                                  category[index]["image"],
                                ),
                                fit: BoxFit.fill)),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              category[index]["name"],
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                ));
              },
            ),
    );
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
}
