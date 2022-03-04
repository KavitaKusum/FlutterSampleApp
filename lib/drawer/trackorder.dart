import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTab extends StatefulWidget {
  @override
  FirstTabState createState() => FirstTabState();
}

class FirstTabState extends State<FirstTab> {
 

  @override
  void initState() {
    super.initState();
     currentuserid();
  }


var userid;
   currentuserid()async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   setState((){
     userid = preferences.getString("Id");
   });

 fetchallorders();
 }

  

  var allorders=[];
  Future fetchallorders() async {
    /*http.Response response =
        await http.get("http://url.com/API/Post.asmx/GetOrderList?UID=$userid");
    allorders = json.decode(response.body);

    setState(() {
      allorders = json.decode(response.body);
     
    });*/
  }


  @override
  Widget build(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  Size size = MediaQuery.of(context).size;
    return
      Container(height: MediaQuery.of(context).size.height,
        child: Container(width: MediaQuery.of(context).size.width,
        child: DefaultTabController(
        length: 6,
        child: Scaffold(

         appBar: AppBar(
        title: Text("Track Orders"),backgroundColor: primary,

      ),
          
      body:SingleChildScrollView(
        
        child:Container(

       child:allorders.length<1?Column(children
      
      : [
        SizedBox(height:size.height*0.4),
         
         Center(child: Text("Your Order is on the way.",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)))
       ]): GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount:allorders.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (orientation == Orientation.portrait) ? 2 : 3),
              itemBuilder: (BuildContext context, int index) {
               var orderid = allorders[index]["ID"];
                return Card(
                  elevation:6,
                    child: GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Row(
                           children:[
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                             " Order No :  ",
                              style: TextStyle(color: Colors.black),
                            )),
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              allorders[index]["OrderNo"],
                              style:brighttext
                            )),
                           ]
                         ),
                          Row(
                           children:[
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                             " Order Date :  ",
                              style: TextStyle(color: Colors.black),
                            )),
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              allorders[index]["OrderDt"],
                            style:brighttext
                            )),
                           ]
                         ), Row(
                           children:[
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                             " Total :  ",
                              style: TextStyle(color: Colors.black),
                            )),
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              allorders[index]["Total"].toString(),
                             style:brighttext
                            )),
                           ]
                         ),
                          Row(
                           children:[
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                             " PayMode :  ",
                              style: TextStyle(color: Colors.black),
                            )),
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              allorders[index]["PayMode"],
                             style:brighttext
                            )),
                           ]
                         ), Row(
                           children:[
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                             " Shipping :  ",
                              style: TextStyle(color: Colors.black),
                            )),
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              allorders[index]["Shipping"].toString(),
                             style:brighttext
                            )),
                           ]
                         ),
                         Row(
                           children:[
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                             " Status :  ",
                              style: TextStyle(color: Colors.black),
                            )),
                             Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              allorders[index]["Status"],
                              style:brighttext,
                            )),
                            SizedBox(width:10),
                             Container(
                             
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              "    Detail",
                              style:TextStyle(color:primary,fontWeight:FontWeight.bold)
                            )),
                           ]
                         )
                      ]
                    ),
                  ),
                ));
              },
            ),

      )
         
         ) ),),
    ),
      );
  }
}
