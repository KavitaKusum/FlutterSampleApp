import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabkabazaar/views/product/product.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../cart/cart.dart';
import '../../themes/color.dart';
import 'dart:convert';

import '../../drawer/drawer.dart';

List<dynamic> category = [];
var cartitem;

class main4 extends StatefulWidget {
  @override
  _main4State createState() => _main4State();
}

class _main4State extends State<main4> {
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
          backgroundColor: primary,
        ),
        drawer: drawer(),
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
          BannerCard(),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 5, bottom: 0),
            child: Text(
              "Shop by category",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
          CategoryCard(),
        ],
      ),
    );
  }
}

class BannerCard extends StatefulWidget {
  @override
  _BannerCardState createState() => _BannerCardState();
}

class _BannerCardState extends State<BannerCard> {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List banners = [
    "assets/images/banner1.jpg",
    "assets/images/banner2.jpeg",
    "assets/images/banner3.jpeg",
    "assets/images/banner4.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 8,
            right: 8,
          ),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1.0,
                height: 170.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: banners
                  .map((item) => Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    item,
                                  ),
                                  fit: BoxFit.fill),
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ))
                  .toList()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(banners, (index, url) {
            return Container(
              width: 6.0,
              height: 6.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? primary : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class CategoryCard extends StatefulWidget {
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            : ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    child: Card(
                        elevation: 2.0,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              contentPadding: const EdgeInsets.all(5.0),
                              leading: Image.asset(
                                category[index]["image"],
                                fit: BoxFit.cover,
                                width: 130.0,
                              ),

                              title: Text(
                                category[index]["name"],
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(category[index]["description"],
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.normal)),
                                  ]),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Products(
                                            category_id: category[index]
                                                ["id"]))).then(onBack);
                              },
                            )
                          ],
                        )),
                  );
                },
              ));
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
