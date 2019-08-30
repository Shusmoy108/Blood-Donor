import 'package:blooddonor/src/mainpages/bloodpages/homepage.dart';
import 'package:blooddonor/src/mainpages/factpage/faqpage.dart';
import 'package:blooddonor/src/mainpages/profilepage/profilepage.dart';

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
              // value["area"],
              // value["department"],
              // value["institution"],
              value["mobile"],
              value["password"],
              value["email"],
           
              // value["rating"],
              // value["number"],
              // value["subject"]
              );
              u.donationnumber=value['donationnumber'];
              u.donationtime=value['donationtime'];
              u.donor=value['donor'];
              //u.etuition=value["etuition"];
          //print(value);
          // String x = value["number"];
          // u.number = int.parse(x);
          // // u.rating = value["rating"];
         // print(u.number);
         // print(u.rating);
          for (var key in onValue.value.keys) {
            u.uid = key;
          }
         _pages=[
         HomePage(email),
         Profile(u),
        FAQPage()
        ];
       
    
        }});
        
   
    return true;
  }
   @override
  void initState() {
   
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
      );
  }
}
