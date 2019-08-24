import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

import 'registerpages/loginpage.dart';
import 'models/user.dart';

class App extends StatelessWidget {
  User u;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  Future<bool> loadAuthData() async {
    // SharedPreferences sp = await SharedPreferences.getInstance();
    // databaseReference = database.reference().child("users");
    //  sp.clear();
    // sp.setBool('auth', false);
    // final email = sp.getString('email') ?? '';
    // print(email);
    // print(sp.getBool('auth'));
    // print('helooooooooooooooooo\n');
   
    // if(sp.getBool('auth')==null){
    // await databaseReference
    //     .orderByChild("email")
    //     .equalTo(email)
    //     .once()
    //     .then((onValue) {
    //   for (var value in onValue.value.values) {
    //     User u;
    //     u = User(
    //         value["username"],
    //         value["gender"],
    //         value["address"],
    //         value["area"],
    //         value["department"],
    //         value["institution"],
    //         value["mobile"],
    //         value["password"],
    //         value["email"],
    //         value["rating"],
    //         value["number"]);
    //     //print(value);
    //     // String x = value["number"];
    //     // u.number = int.parse(x);
    //     // // u.rating = value["rating"];
      
    //     for (var key in onValue.value.keys) {
    //       u.uid = key;
    //     }
    //   }
    // });
    // }
    //   print(u.number);
    //   print(u.rating);      print(u.username);
    // print('hello');
    // print(sp.getBool('auth'));
    // if(sp.getBool('auth')==null){
    //   sp.setBool('auth', false);
    // }
    // print(sp.getBool('auth'));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Blood Donor',
      debugShowCheckedModeBanner: false,
      home: new LoginPage(),
      // home: FutureBuilder(
      //   future: loadAuthData(),
      //   builder: (context, snapshot) {
         
         
      //       if (snapshot.data) {
      //         return AllTutionPage(u);
      //       } else {
      //         return LoginPage();
      //       }
          
      //   },
      // ),
    );
  }
}
