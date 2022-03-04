import 'dart:io';

import 'package:sabkabazaar/views/home/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'bottomnavbar.dart';
import '../../themes/color.dart';

class signin extends StatefulWidget {
  @override
  _siginState createState() => _siginState();
}

class _siginState extends State<signin> {
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool issignin = false;
  var number, password;

  bool loading = false;

  signin() async {
    setState(() {
      number = numberEditingController.text;
      password = passwordEditingController.text;
      loading = true;
    });
    var data;
    final path = (await getApplicationDocumentsDirectory()).path;
    final loginFile = File('$path/login.json');
    if (await loginFile.exists()) {
      try {
        final _jsonString = await loginFile.readAsString();
        data = await json.decode(_jsonString);
      } catch (e) {
        print('Tried reading _file error: $e');
      }
    }
    if (data != null) {
      if (number == data["number"] && password == data["password"]) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('cartitem', data["cartItem"]);
        preferences.setString('Id', data["Id"]);
        preferences.setString('name', data["name"]);
        preferences.setString('number', data["number"]);
        preferences.setString('mail', data["mail"]);
        preferences.setString('pincode', data["pincode"]);
        preferences.setString('address', data["address"]);
        preferences.setString('city', data["city"]);

        setState(() {
          loading = false;
        });

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => main2()));
      } else {
        setState(() {
          loading = false;
        });
        Fluttertoast.showToast(
          msg: "Please provide correct number or Password",
          fontSize: 15,
          backgroundColor: Colors.black,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
        );
      }
    } else {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(
        msg: "Please signup first",
        fontSize: 15,
        backgroundColor: Colors.black,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Stack(children: [
          Container(
            alignment: Alignment.topCenter,
            height: 300,
            color: primary,
            child: Container(
              height: 180,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 30),
              child: Image(
                image: AssetImage("assets/images/sabka_bazaar.jpeg"),
              ),
            ),
          ),
          Container(
            height: 600,
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: Card(
                color: Colors.white,
                elevation: 6.0,
                margin: EdgeInsets.only(right: 15.0, left: 15.0),
                child: Container(
                  height: 400,
                  width: 300,
                  child: Wrap(
                    children: <Widget>[
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Text(
                            'Login',
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.black),
                          ),
                        ),
                      ),
                      Form(
                          child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.phone_android_outlined),
                            title: TextFormField(
                              validator: (val) {
                                return val.length > 3 ? null : "Invalid number";
                              },
                              controller: numberEditingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Please enter correct number',
                                labelText: 'Enter your number',
                              ),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.lock),
                            title: TextFormField(
                              obscureText: true,
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Enter Password 6+ characters";
                              },
                              controller: passwordEditingController,
                              decoration: InputDecoration(
                                hintText: 'Please enter password',
                                labelText: 'Enter Your Password',
                              ),
                            ),
                          ),
                        ],
                      )),
                      Container(
                        alignment: Alignment.center,
                        child: ButtonTheme(
                            minWidth: 200.0,
                            height: 40.0,
                            child: ElevatedButton(
                              child: Text('SIGN   IN',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                              onPressed: () {
                                signin();
                              },
                            )),
                      ),
                      loading
                          ? Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.green),
                            )
                          : Text(""),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 30),
                          child: Container(
                              margin: EdgeInsets.only(bottom: 40.0, top: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => signup()));
                                },
                                child: Text.rich(
                                  TextSpan(
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: 'New User? ',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black)),
                                      TextSpan(
                                          text: 'REGISTER',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              )))
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ],
    )));
  }
}
