import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import '../cart/cart.dart';
import '../../themes/color.dart';

class ProductDetail extends StatefulWidget {
  final product_id, productImg, name;
  final price, weight;

  ProductDetail(
      {@required this.productImg,
      @required this.name,
      @required this.price,
      @required this.weight,
      @required this.product_id});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool like = false, share = false, similar = false;
  int _indx = 0;
  var cartItems = [];
  bool firstTime=true;
  var initialCartLength=0;

  @override
  void initState() {
    super.initState();
    fetchcartnumber();
    fetchlikeditem();
  }

  List<String> likeid;
  List<String> listimg;
  List<String> listname;
  List<String> listweight;
  List<String> listprice;
  List result = [];
  var userid;
  var number;

  Future<void> addProduct(int itemNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> _newJson = {
      "cartID": cartItems.length+1,
      "img": widget.productImg,
      "name": widget.name,
      "price": widget.price,
      "weight": widget.weight,
      "pid":widget.product_id,
      "quantity": 1,
    };
    cartItems.add(_newJson);
    final _jsonString = jsonEncode(cartItems);
    final path = (await getApplicationDocumentsDirectory()).path;
    final cartFile = File('$path/cart.json');
    (await cartFile).writeAsString(_jsonString);
    setState(() {
      number=cartItems.length;
      preferences.setString("cartitem", cartItems.length.toString());
    });
  }

  fetchcartnumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final path = (await getApplicationDocumentsDirectory()).path;
    final cartFile = File('$path/cart.json');
    if (await cartFile.exists()) {
      try {
        final _jsonString = await cartFile.readAsString();
        cartItems = json.decode(_jsonString);
        setState(() {
          cartItems = json.decode(_jsonString);
          number=cartItems.length;
          if(firstTime){
            initialCartLength=number;
            firstTime=false;
          }
          preferences.setString("cartitem", cartItems.length.toString());
        });
      } catch (e) {
        print('Tried reading _file error: $e');
      }
    } else {
      number = 0;
    }
  }

  removeproduct(var itemnumber) async {
    if(cartItems.length==initialCartLength){
      return;
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (cartItems.isNotEmpty) cartItems.removeLast();
    final _jsonString = jsonEncode(cartItems);
    final path = (await getApplicationDocumentsDirectory()).path;
    final cartFile = File('$path/cart.json');
    (await cartFile).writeAsString(_jsonString);
    setState(() {
      number = cartItems.length;
      preferences.setString("cartitem", number.toString());
    });
  }

 fetchlikeditem() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    likeid = preferences.getStringList('likeid');
    listimg = preferences.getStringList('listimg');
    listname = preferences.getStringList('listname');
    listweight = preferences.getStringList('listweight');

    listprice = preferences.getStringList('listprice');
    userid = preferences.getString("Id");

    setState(() {
      if (likeid != null) {
        likeid = preferences.getStringList('likeid');
        listimg = preferences.getStringList('listimg');
        listname = preferences.getStringList('listname');
        listweight = preferences.getStringList('listweight');
        listprice = preferences.getStringList('listprice');
        userid = preferences.getString("Id");
      }

      if (likeid == null) {
        likeid = [];
        listimg = [];
        listname = [];
        listweight = [];

        listprice = [];
      }
    });
  }

  Share() {
    return GestureDetector(
      onTap: () {
        setState(() {
          share = !share;
        });
      },
      child: Row(
        children: [
          Icon(
            Icons.share,
            color: Colors.grey,
          ),
          Text(
            "Share",
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  SimilarPrdct() {
    return GestureDetector(
      onTap: () {
        setState(() {
          similar = !similar;
        });
      },
      child: Row(
        children: [
          Icon(
            Icons.art_track_sharp,
            color: Colors.grey,
          ),
          Text(
            "Similar ProductDetail",
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Container(
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => cart())).then(onBack);
                      },
                      child: Icon(Icons.shopping_cart)),
                  CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.red,
                      child: Text(number.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)))
                ],
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: SizedBox(
                        height: 300,
                        width: 250,
                        child: Image(
                          image: AssetImage(widget.productImg),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              setState(() {
                                like = true;
                              });
                              likeid.add(widget.product_id.toString());

                              listimg.add(widget.productImg.toString());
                              listname.add(widget.name.toString());
                              listweight.add(widget.weight.toString());
                              listprice.add(widget.price.toString());

                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setStringList('likeid', likeid);
                              preferences.setStringList('listimg', listimg);
                              preferences.setStringList('listname', listname);
                              preferences.setStringList(
                                  'listweight', listweight);
                              preferences.setStringList('listprice', listprice);
                            },
                            child: Icon(Icons.favorite_outlined,
                                size: 30, color: like ? primary : Colors.grey)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            widget.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Text(
                          "M.R.P :  ₹ ${widget.price}",
                        )),
                        Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(left: 10),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20),
                        child: Text(widget.weight.toString()+" Kg",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 3, color: Colors.grey[300]),
                          bottom:
                              BorderSide(width: 3, color: Colors.grey[300])),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 20),
                              child: Text("Quantity"),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_indx == 0) {
                                        } else
                                          _indx--;
                                      });
                                      removeproduct(_indx.toString());
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(right: 7),
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: primary,
                                        )),
                                  ),
                                  Text("$_indx"),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _indx++;
                                      });
                                      addProduct(_indx);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(left: 7),
                                        child: Icon(
                                          Icons.add_circle,
                                          color: primary,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 40.0,
              child: ElevatedButton(
                child: Text('Go to Cart',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => cart())).then(onBack);
                },
              )),
        ],
      ),
    );
  }
  FutureOr onBack(dynamic value) {
    refreshCartItem();
  }
  Future<void> refreshCartItem() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      number = int.parse(preferences.getString("cartitem"));
    });
  }
}
