import "package:flutter/material.dart";
import 'package:sabkabazaar/views/home/signin.dart';
import "dart:async";
import 'package:shared_preferences/shared_preferences.dart';

import 'views/home/bottomnavbar.dart';
import 'themes/color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sabka Bazaar",
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 3),
      () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        var email = preferences.getString('email');

        if (email == "loggedin") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => main2(),
              ));
        }

        if (email != "loggedin") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => signin(),
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Text(
          "Sabka Bazaar",
          style: TextStyle(
              color: Colors.white, fontSize: 33, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
