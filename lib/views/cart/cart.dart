import 'package:flutter/material.dart';
import 'package:sabkabazaar/views/home/bottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../themes/color.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  void initState() {
    currentuserid();
    super.initState();
  }

  var numberOfProduct = [];
  var cartitem;
  var userid;

  currentuserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userid = preferences.getString("Id");
    });
    fetchcartitem();
  }

  fetchcartitem() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final path = (await getApplicationDocumentsDirectory()).path;
    final cartFile = File('$path/cart.json');
    if (await cartFile.exists()) {
      try {
        final _jsonString = await cartFile.readAsString();
        setState(() {
          numberOfProduct = json.decode(_jsonString);
          preferences.setString("cartitem", numberOfProduct.length.toString());
          cartitem = preferences.getString("cartitem");
        });
      } catch (e) {
        print('Tried reading _file error: $e');
      }
    }
  }

  cartitemremove(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if (numberOfProduct.isNotEmpty) numberOfProduct.removeAt(index);
      preferences.setString("cartitem", numberOfProduct.length.toString());
    });
    final _jsonString = jsonEncode(numberOfProduct);
    final path = (await getApplicationDocumentsDirectory()).path;
    final cartFile = File('$path/cart.json');
    (await cartFile).writeAsString(_jsonString);
  }

  showAlertDialog(BuildContext context, var total) {
    Widget okbtn = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        checkout(getTotalPrice());
      },
    );

    Widget nobtn = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text("Are you sure that you want to complete this order "),
      actions: [okbtn, nobtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  checkout(var total) async {
    Fluttertoast.showToast(
      msg: "Your Order is Successfully Placed.",
      fontSize: 15,
      backgroundColor: Colors.black,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
    );

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("cartitem", "0");
    final path = (await getApplicationDocumentsDirectory()).path;
    final cartFile = File('$path/cart.json');
    (await cartFile).delete();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => main2()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: primary,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
            color: Colors.white,
            height: 120,
            child: numberOfProduct.length == 0 || numberOfProduct.length == null
                ? Text("")
                : Column(
                    children: <Widget>[
                      Row(children: [
                        Text("SubTotal  ", style: TextStyle(fontSize: 12)),
                        Spacer(),
                        Text(" ₹ ", style: TextStyle(fontSize: 12)),
                        Text(getTotalPrice().toString(),
                            style: TextStyle(fontSize: 12)),
                        SizedBox(width: 10),
                      ]),
                      SizedBox(height: 5),
                      Row(children: [
                        Text("Delivery Charge    ",
                            style: TextStyle(fontSize: 12)),
                        Spacer(),
                        Text(" ₹ ", style: TextStyle(fontSize: 12)),
                        Text("0  ", style: TextStyle(fontSize: 12)),
                        SizedBox(width: 10),
                      ]),
                      Row(children: [
                        Text("Total    ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Text(" ₹ ", style: TextStyle(fontSize: 14)),
                        Text(getTotalPrice().toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        SizedBox(width: 10, height: 30),
                      ]),
                      GestureDetector(
                          onTap: () {
                            showAlertDialog(context, numberOfProduct.length);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Row(children: [
                                Center(
                                    child: Text(
                                        "  Total ${numberOfProduct.length} item(s)  ₹ ${getTotalPrice()} ",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                Spacer(),
                                Text("Checkout",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward, color: Colors.white),
                                SizedBox(height: 50)
                              ])))
                    ],
                  )),
      ),
      body: Container(
          child: numberOfProduct.length < 1
              ? Container(
                  child: Center(
                      child: Center(
                  child: Column(children: [
                    SizedBox(height: size.height * 0.4),
                    Text("Your cart is empty ", style: TextStyle(fontSize: 25))
                  ]),
                )))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: numberOfProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: size.height * 0.202,
                        child: GestureDetector(
                          onTap: () {},
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 135,
                                      height: 130,
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
                                                      numberOfProduct[index]
                                                          ["img"]),
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
                                            numberOfProduct[index]["name"]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 50),
                                        ]),
                                        Container(
                                            margin: EdgeInsets.only(right: 100),
                                            child: Text(
                                              numberOfProduct[index]["weight"]
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )),
                                        SizedBox(height: 10),
                                        Row(children: [
                                          Container(
                                              margin: EdgeInsets.only(right: 0),
                                              child: Text(
                                                numberOfProduct[index]["price"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Text("  X  ",
                                              style: TextStyle(fontSize: 12)),
                                          Container(
                                              margin: EdgeInsets.only(right: 0),
                                              child: Text(
                                                numberOfProduct[index]
                                                        ["quantity"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          SizedBox(width: size.width * 0.14),
                                          Container(
                                              child: GestureDetector(
                                                  onTap: () {
                                                    cartitemremove(index);
                                                  },
                                                  child: Icon(Icons.close,
                                                      color: primary))),
                                        ]),
                                        SizedBox(height: 10),
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

  int getTotalPrice() {
    var sum = 0;
    numberOfProduct.forEach((e) => sum += e["price"] * e["quantity"]);
    return sum;
  }
}
