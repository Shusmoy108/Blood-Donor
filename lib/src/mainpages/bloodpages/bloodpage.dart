import 'package:blooddonor/src/mainpages/bloodpages/blooddonor.dart';
import 'package:blooddonor/src/registerpages/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/user.dart';
import 'blood.dart';

class BloodsPage extends StatefulWidget {
  User u;
  String m;
  BloodsPage(this.m);
  //AllTutionPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return BloodsPageState(m);
  }
}

class BloodsPageState extends State<BloodsPage> {
  User u;
  String m;
  BloodsPageState(this.m);
 // AllTutionPageState(this.u);
  String text="";
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
  void initState() {
    setState(() {
      super.initState();
      databaseReference = database.reference().child("users");
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit Tuition Hub'),
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

  Future<List<User>> _getUsers() async {
    List<User> users = List();

    await databaseReference.once().then((DataSnapshot snapshot) {
      if (snapshot.value.values != null) {
        for (var value in snapshot.value.values) {
          User u=User(value['username'], value['gender'], value['address'], value['bloodgroup'], value['mobile'], value['password'], value['email']);
          users.add(u);
          //}
        }
        int i = 0;
        for (var key in snapshot.value.keys) {
          users[i].uid = key;
          i++;
        }
      } else {
        users = [];
      }
     if(bloodgrp!=""){
         List<User> searchusers = List();
       for(int i=0;i<users.length;i++){
      //  print(users[i].bloodgroup);
      //  print("hello");
         if (users[i].bloodgroup.toLowerCase()==bloodgrp.toLowerCase() || 
         users[i].username.toLowerCase().contains(bloodgrp.toLowerCase())||
          users[i].address.toLowerCase().contains(bloodgrp.toLowerCase())){
              searchusers.add(users[i]);
         }
       }
       users=searchusers;
     } 
    
    });
 //print(users);
    return users;
  }
String bloodgrp="";
  
  List<String> bloodes = [
    'A+',
    'B+',
    'AB+',
    'O+',
    'A-',
    'B-',
    'O-',
    'AB-',
    
  ];
 Widget bloodfield() {
    return new ListTile(
      leading: new Text("Blood Group",
          style: new TextStyle(color: Colors.black, fontSize: 16)),
      title: DropdownButton(
        hint: Text('Please choose a Blood Group'), // Not necessary for Option 1
        value: bloodgrp,
        onChanged: (newValue) {
          setState(() {
            bloodgrp = newValue;
          });
        },
        items: bloodes.map((cls) {
          return DropdownMenuItem(
            child: new Text(cls),
            value: cls,
          );
        }).toList(),
      ),
    );
  }
  
  Widget appBarTitle=new Text("Blood Donor");
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
             centerTitle: true,
        title:appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon,onPressed:(){
          setState(() {
                     if (this.actionIcon.icon == Icons.search){
                      this.actionIcon = new Icon(Icons.close);
                      this.appBarTitle = new TextField(
                        onChanged: (value){
                          setState(() {
                             bloodgrp=value;
                            // print(bloodgrp);
                          });
                       
                        },
                        style: new TextStyle(
                          color: Colors.white,

                        ),
                        decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search,color: Colors.white),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white)
                        ),
                      );}
                      else {
                        bloodgrp="";
                        _getUsers();
                        this.actionIcon = new Icon(Icons.search);
                        this.appBarTitle = new Text("Blood Donor");
                      }


                    })
                    ;}
                    )
                    ]),
          body: Container(
              color: Color.fromRGBO(234, 239, 241, 1.0),
              //margin: EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: _getUsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == []) {
                    return Container(
                      child: Center(
                        child: Text(
                            "There is currently no donor available."),
                      ),
                    );
                  } else {
                    return Bloods(snapshot.data);
                  }
                },
                
              )),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new Blooddonorpage(m));
              Navigator.of(context).push(router);
            },
            label: Text(
              'Add Donor',
            ),
            icon: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(220, 20, 60, 0.8),
          ),
        );
  }
}
