import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/color.dart';

class profile extends StatefulWidget {
  final id;

  profile({@required this.id});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  var name, email, mobile, address, city, pincode, userid;

  @override
  void initState() {
    getuserdetails();
    super.initState();
  }

  getuserdetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      mobile = preferences.getString("number");
      name = preferences.getString('name');
      email = preferences.getString('mail');
      pincode = preferences.getString('pincode');
      address = preferences.getString('address');
      city = preferences.getString('city');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: size.height * 0.2,
          color: primary,
          child: Container(
            height: size.height * 0.25,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 30),
            child: Image(
              image: AssetImage("assets/images/sabka_bazaar.jpeg"),
            ),
          ),
        ),
        Container(
            width: size.width * 1,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: primary,
                          radius: 25,
                          child: Icon(Icons.person, color: Colors.white)),
                    ),
                    SizedBox(width: size.width * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(name.toString(),
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: primary,
                          radius: 25,
                          child: Icon(Icons.hotel, color: Colors.white)),
                    ),
                    SizedBox(width: size.width * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(address.toString(),
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: primary,
                          radius: 25,
                          child:
                              Icon(Icons.location_city, color: Colors.white)),
                    ),
                    SizedBox(width: size.width * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(city.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            
                          )),
                    )
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: primary,
                          radius: 25,
                          child: Icon(Icons.phone, color: Colors.white)),
                    ),
                    SizedBox(width: size.width * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(mobile.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            
                          )),
                    )
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: primary,
                          radius: 25,
                          child: Icon(Icons.circle, color: Colors.white)),
                    ),
                    SizedBox(width: size.width * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(pincode.toString(),
                          style: TextStyle(
                            fontSize: 15,

                          )),
                    )
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: primary,
                          radius: 25,
                          child:
                              Icon(Icons.email_rounded, color: Colors.white)),
                    ),
                    SizedBox(width: size.width * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(email.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            
                          )),
                    )
                  ],
                ),
              ],
            ))
      ],
    )));
  }
}
