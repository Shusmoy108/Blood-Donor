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
  @override
  State<StatefulWidget> createState() {
    return BloodsPageState(m,search,bg);
  }
}

class BloodsPageState extends State<BloodsPage> {
  User u;
  String m;
  BloodsPageState(this.m,this.search,this.bg);
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


  Future<List<User>> _getUsers() async {
    List<User> users = List();
    await databaseReference.once().then((DataSnapshot snapshot) {
      if (snapshot.value.values != null) {
        for (var value in snapshot.value.values) {
          DateTime d= new DateTime.fromMillisecondsSinceEpoch(value["donationtime"]);
          DateTime dd= new DateTime.now();
          //print(dd.difference(d).inDays);
          if(dd.difference(d).inDays>120 || value["donationtime"]==0){
          User u=User(value['username'], value['gender'], value['address'], value['bloodgroup'], value['mobile'], value['password'], value['email']);
          users.add(u);}
          //}
        }
     
      

        if(bg!="" && search!=""){
         List<User> searchusers = List(); 
       for(int i=0;i<users.length;i++){
         if (users[i].bloodgroup.toLowerCase()==bg.toLowerCase() &&
         //users[i].username.toLowerCase().contains(search.toLowerCase())||
          users[i].address.toLowerCase().contains(search.toLowerCase())){
              searchusers.add(users[i]);
         }
       }
       users=searchusers;
     } 
  
      else if(bg!=""){
        List<User> searchusers = List(); 
       for(int i=0;i<users.length;i++){
    
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
      // appBar: new AppBar(
      //   title: Center(child:new Text("BloodHunt", style: TextStyle(fontFamily: "Arcon",fontWeight: FontWeight.bold),), 
      //   ) ),
      body: Container(
         color: Color.fromRGBO(234, 239, 241, 1.0),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("images/main.png"),
        //     fit: BoxFit.fill,
        //     ),
        //     ),
        child: FutureBuilder(
            future: _getUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  
                    return Container(
                      child: Center(
                        child: Text(
                            "No donor is currently available in this blood group and location", style: TextStyle(fontSize: 25, fontFamily: "Lobster"),),
                      ),
                    );
                  } else {
                    if(snapshot.data.length>0){
                      return Bloods(snapshot.data);
                    }
                    else{
                        return Container(
                      child: Center(
                        child: Text(
                            "No donor is currently available in this blood group and location", style: TextStyle(fontSize: 25, fontFamily: "Lobster"),),
                      ),
                    );
                    }
                  }
                },)),
          
         
        );
  }
}
