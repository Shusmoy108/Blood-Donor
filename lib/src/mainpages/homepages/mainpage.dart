import 'package:blooddonor/src/mainpages/aboutpages/aboutpage.dart';
import 'package:blooddonor/src/mainpages/bloodpages/homepage.dart';
import 'package:blooddonor/src/mainpages/bloodstoriespage/bloodstoriespage.dart';
import 'package:blooddonor/src/mainpages/factpage/faqpage.dart';
import 'package:blooddonor/src/mainpages/profilepage/profilepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloodpages/bloodpage.dart';
import '../../models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
class MainPage extends StatefulWidget {
  String email;
  MainPage(this.email);
   @override
  State<StatefulWidget> createState() {
    return _MainPageState(email);;
  }
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  User u;
  String email;
  _MainPageState(this.email);
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  var _pages = [];
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
  Future<bool> loadAuthData(emial) async {
  
       databaseReference = database.reference().child("users");
       await  databaseReference
        .orderByChild("mobile")
        .equalTo(email)
        .once()
        .then((onValue) {
      for (var value in onValue.value.values) {
        
            u = User(
              value["username"],
              value["gender"],
              value["address"],
              value["bloodgroup"],
              value["mobile"],
              value["password"],
              value["email"],
              );
              u.donationnumber=value['donationnumber'];
              u.donationtime=value['donationtime'];
              u.donor=value['donor'];
          for (var key in onValue.value.keys) {
            u.uid = key;
          }
         _pages=[
         HomePage(email),
         Profile(u),
         FAQPage(u),
         AboutPage(email),
        // BloodstoriesPage(u)
        ];
        }});
    return true;
  }
   @override
  void initState() {
   
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child:FutureBuilder(
        future: loadAuthData(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return Scaffold(
        body: Container(
        child:_pages[_selectedIndex]
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Color.fromRGBO(220, 20, 60, 1.0),
          items: <BottomNavigationBarItem>[
           BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'Home',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            title: Text(
              'Profile',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.query_builder,
            ),
            title: Text(
              'FAQ',
            ),
          ),
          //  BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.description,
          //   ),
          //   title: Text(
          //     'About',
          //   ),
          // ),
          //  BottomNavigationBarItem(
          //   icon: Icon(
          //     FontAwesomeIcons.penNib,
          //   ),
          //   title: Text(
          //     'Blood Stories',
          //   ),
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          this.setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ) ,) ;
  }
}
