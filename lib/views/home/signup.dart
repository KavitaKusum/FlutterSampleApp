import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sabkabazaar/views/home/signin.dart';
import '../../themes/color.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController mailEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController pinEditingController = TextEditingController();
  bool loading = false;
  List data;

  final index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Stack(children: [
          Container(
            alignment: Alignment.topCenter,
            color: primary,
            child: Container(
              height: 180,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 25, bottom: 10),
              child: Image(
                image: AssetImage("assets/images/sabka_bazaar.jpeg"),
              ),
            ),
          ),
          Center(
            child: Card(
              color: Colors.white,
              elevation: 6.0,
              margin: EdgeInsets.only(top: 120, right: 30.0, left: 30.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 25.0, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CountryCodePicker(
                        onChanged: print,
                        initialSelection: 'IN',
                        favorite: ['+91', 'IN'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                      title: Form(
                        child: TextFormField(
                          validator: (mobileVal) {
                            return mobileVal.length == 4
                                ? null
                                : "Please enter correct number";
                          },
                          controller: numberEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: 'Mobile number',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Text("Password",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                      title: Form(
                        child: TextFormField(
                          validator: (val) {
                            return val.length > 4
                                ? null
                                : "Please enter more than 4 characters";
                          },
                          controller: passwordEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Text("Name",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                      title: Form(
                        child: TextFormField(
                          controller: nameEditingController,
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Text("Mail",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                      title: Form(
                        child: TextFormField(
                          controller: mailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter mail id',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Text("Address",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                      title: Form(
                        child: TextFormField(
                          controller: addressEditingController,
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter address',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Text("City",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                      title: Form(
                        child: TextFormField(
                          controller: cityEditingController,
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter city',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Text("Pin code",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black)),
                      title: Form(
                        child: TextFormField(
                          controller: pinEditingController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter Pin',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: ButtonTheme(
                        minWidth: 200,
                        height: 40.0,
                        child: ElevatedButton(
                          child: Text('SIGN IN',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          onPressed: () {
                            setLoginData();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signin()));
                          },
                        )),
                  ),
                ],
              ),
            ),
          )
        ]),
      ],
    )));
  }

  Future<File> setLoginData() async {
    Map<String, dynamic> _newJson = {
      "number": numberEditingController.text,
      "password": passwordEditingController.text,
      "Id": "$index++",
      "name": nameEditingController.text,
      "mail": mailEditingController.text,
      "cartItem": "0",
      "pincode": pinEditingController.text,
      "address": addressEditingController.text,
      "city": cityEditingController.text,
    };
    final _jsonString = jsonEncode(_newJson);
    final path = (await getApplicationDocumentsDirectory()).path;
    final loginFile = File('$path/login.json');
    return (await loginFile).writeAsString(_jsonString);
  }
}
