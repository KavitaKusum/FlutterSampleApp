import 'package:sabkabazaar/drawer/privacy.dart';
import 'package:sabkabazaar/drawer/trackorder.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:sabkabazaar/views/home/signin.dart';
import '../views/cart/cart.dart';
import '../views/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/color.dart';
import "profile.dart";

class drawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  Future<void> share() async {
    await FlutterShare.share(
        title: "Sabka Bazaar",
        text: "app link",
        linkUrl: '',
        chooserTitle: "Share Sabka Bazaar");
  }

  @override
  void initState() {
    getuserdetails();
    super.initState();
  }

  var username, usernumber, id;

  getuserdetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      username = preferences.getString("name");
      usernumber = preferences.getString("number");
      id = preferences.getString("Id");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            child: ListView(children: <Widget>[
      Container(
        color: primary,
        child: ListTile(
          leading: Image.asset(
            'assets/images/sabka_bazaar.jpeg',
            scale: 1.0,
            height: 50.0,
            width: 100.0,
          ),
          trailing: Column(children: [
            Text(
              username,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              usernumber,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
      GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => main4()),
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.black45,
                    size: 28,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "Home",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          )),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => cart()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, top: 10),
          child: ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: Colors.black45,
                  size: 28,
                ),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Cart",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => profile(id: id)),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, top: 10),
          child: ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.black45,
                  size: 28,
                ),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Profile",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirstTab()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, top: 10),
          child: ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.local_shipping,
                  color: Colors.black45,
                  size: 28,
                ),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Track Order",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('email', "logout");

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => signin(),
              ));
        },
        child: Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.black45,
                    size: 28,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            )),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => privacy()),
          );
        },
        child: Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.policy,
                    color: Colors.black45,
                    size: 28,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            )),
      )
    ])));
  }
}
