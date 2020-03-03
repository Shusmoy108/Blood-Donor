import 'dart:ui';

import 'package:blooddonor/src/mainpages/factpage/faqpage.dart';
import 'package:blooddonor/src/mainpages/mappages/mappage.dart';
import 'package:blooddonor/src/mainpages/profilepage/profilepage.dart';
import 'package:blooddonor/src/models/user.dart';
import 'package:flutter/material.dart';


class NotificationPage extends StatefulWidget {
  User u;
  NotificationPage(this.u);
  @override
  _NotificationPageState createState() => _NotificationPageState(u);
}

class _NotificationPageState extends State<NotificationPage> with TickerProviderStateMixin {
  
User u;
_NotificationPageState(this.u);
  Widget FAQ(String question,String answer){
    return Card(
      child: ListTile(
      
      title: Text(question, style: TextStyle(fontFamily: "Arcon",fontSize: 20),),
      trailing: Text(answer, style: TextStyle(fontFamily: "Arcon",fontSize: 18)),
    ),
    );
  }
 Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit রক্তদান'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child:Scaffold(
      // appBar: new AppBar(
      //   title: Center(child:new Text("BloodHunt", style: TextStyle(fontFamily: "Arcon",fontWeight: FontWeight.bold),), 
      //   ) ),
      appBar:AppBar(
        title: Center(child:Text("রক্তদান")) ,
      ) ,
    drawer: Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child:  Center(child:Text("রক্তদান",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
        decoration: BoxDecoration(
          color: Colors.red,
        ),
      ),
       ListTile(
        title: Text('Home'),
        onTap: () {
          Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                        builder: (context) =>MapSample(u.mobile),
                      ));
          
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: Text('Profile'),
        onTap: () {
          Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                        builder: (context) =>Profile(u),
                      ));
          
          // Update the state of the app.
          // ...
        },
      ),
       ListTile(
        title: Text('Donation History'),
        onTap: () {
           Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                        builder: (context) =>NotificationPage(u),
                      ));
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: Text('FAQ'),
        onTap: () {
           Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                        builder: (context) => FAQPage(u),
                      ));
        
        },
      ),
    ],
  ),
),
      body: Container(
        
         decoration: BoxDecoration(
                    color: Color.fromRGBO(234, 239, 241, 1.0),
          // image: DecorationImage(
          //   image: AssetImage("images/main.png"),
          //   fit: BoxFit.fill,
          // ),
        ),
        child: ListView(
         children: <Widget>[
         FAQ("You have donated in Chittagong Medical College", "11/7/2019"),
           FAQ("You have donated in Sondani Group", "15/2/2019"),
             FAQ("You have donated in Badhon Bloop Camp", "1/6/2018"),
               FAQ("You have donated in Lains Charitable Blood Camp", "4/1/2018"),
                 FAQ("You have donated in Blood donation Camp in GEC", "21/7/2017"),
         ],
        )
     
    )));
  }

  
}
