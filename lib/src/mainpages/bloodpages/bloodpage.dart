import 'package:blooddonor/src/mainpages/bloodpages/blooddonor.dart';
import 'package:blooddonor/src/registerpages/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/user.dart';
import 'blood.dart';

class BloodsPage extends StatefulWidget {
  User u;
  String m;
  String search;
  String bg;
  BloodsPage(this.m,this.search,this.bg);
  //AllTutionPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return BloodsPageState(m,search,bg);
  }
}

class BloodsPageState extends State<BloodsPage> {
  User u;
  String m;
  BloodsPageState(this.m,this.search,this.bg);
 // AllTutionPageState(this.u);
  String text="";
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  String search;
  String bg;
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
                content: new Text('Do you want to exit BloodHunt'),
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

        if(bg!="" && search!=""){
         List<User> searchusers = List(); 
       for(int i=0;i<users.length;i++){
      //  print(users[i].bloodgroup);
      //  print("hello");
         if (users[i].bloodgroup.toLowerCase()==bg.toLowerCase() || 
         users[i].username.toLowerCase().contains(search.toLowerCase())||
          users[i].address.toLowerCase().contains(search.toLowerCase())){
              searchusers.add(users[i]);
         }
       }
       users=searchusers;
     } 
  
      else if(bg!=""){
        List<User> searchusers = List(); 
       for(int i=0;i<users.length;i++){
      //  print(users[i].bloodgroup);
      //  print(bg);
      //  print("hello");
         if (users[i].bloodgroup.toLowerCase()==bg.toLowerCase()){
              searchusers.add(users[i]);
         }
       }
       users=searchusers;
      }
       else {
        users = [];
      }
      }
   
    
    });
 //print(users);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(child:new Text("Blood HUNT", style: TextStyle(fontFamily: "Arcon",fontWeight: FontWeight.bold),), 
        ) ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/drop.jpg"),
            fit: BoxFit.fill,
            ),
            ),
        child: FutureBuilder(
            future: _getUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                            "There is currently no donor available."),
                      ),
                    );
                  } else {
                    return Bloods(snapshot.data);
                  }
                },)),
          
          // floatingActionButton: FloatingActionButton.extended(
          //   onPressed: () {
          //     var router = new MaterialPageRoute(
          //         builder: (BuildContext context) => new Blooddonorpage(m));
          //     Navigator.of(context).push(router);
          //   },
          //   label: Text(
          //     'Add Donor',
          //   ),
          //   icon: Icon(Icons.add),
          //   backgroundColor: Color.fromRGBO(220, 20, 60, 0.8),
          // ),
        );
  }
}
