import 'package:blooddonor/src/mainpages/bloodpages/blooddonor.dart';
import 'package:blooddonor/src/mainpages/bloodpages/bloodpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/user.dart';
import 'blood.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  User u;
  String m;
  HomePage(this.m);
  //AllTutionPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return HomePageState(m);
  }
}

class HomePageState extends State<HomePage> {
  User u;
  String m;
  HomePageState(this.m);
 // AllTutionPageState(this.u);
  String text="";
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  int donor=41;
  int user=53;
  @override
  void initState() {
    setState(() {
      super.initState();
        search="";
        blds="A+";
      databaseReference = database.reference().child("users");
      databaseReference.once().then((DataSnapshot snapshot) {
      if (snapshot.value.values != null) {
        user=snapshot.value.values.length;
        donor=0;
        for (var value in snapshot.value.values) {
        
         if(value["donor"]=="Yes"){
           donor++;
         }
        }
     
      }
      });
    });
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
  String search="";
  String blds="A+";
Widget bloodfield() {
    return new Container(
      //color: Colors.white,
      width:150,
      height: 60,
       decoration: BoxDecoration(
          color: Color.fromRGBO(220, 20, 60, 0.8),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
      child: new Row(
        children: <Widget>[
          SizedBox(width: 10,),
          new Text("Blood Group",
          style: new TextStyle(color: Colors.black, fontSize: 15,fontFamily:"Lobster" )),
          SizedBox(width: 10.0,   ),
          new DropdownButton(
        //hint: Text('Please choose a Blood Group'), // Not necessary for Option 1
          value: blds,
          onChanged: (newValue) {
            setState(() {
              blds = newValue;
            });
          },
          items: bloodes.map((blood) {
            return DropdownMenuItem(
              child: new Text(blood,style: TextStyle(fontFamily: "Lobster",fontSize: 15),),
              value: blood,
            );
          }).toList(),
        ),
        ],
      ) 
    );
  }
  Widget emailField() {
    return new Container(
      width:150,
      height: 60,
      child: TextField(
                onChanged: (value) {
                  setState(() {
                   search=value; 
                  });
                 // filterSearchResults(value);
                },
                //controller: editingController,
                decoration: InputDecoration(
                    labelText: "Location",
                    hintText: "Location",
                   // prefixIcon: Icon(Icons.search),
                    //prefixIcon: new Icon(FontAwesomeIcons.tint,color: Colors.red,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)))),
              ),
      
    );
  }
Widget searchbutton() {
    return InkWell(
      onTap: () {
           var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new   BloodsPage(m, search, blds));
              Navigator.of(context).push(router);
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromRGBO(220, 20, 60, 0.8),
          borderRadius: BorderRadius.circular(80.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,size: 60,
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }
  Widget searchfields(context){
  if(MediaQuery.of(context).size.width>350){
     return Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         bloodfield(),
         SizedBox(width: 20.0,),
         emailField(),
         ]);
         }
  else{
     return Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         bloodfield(),
         SizedBox(height: 20.0,),
         emailField(),
         ]);
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
        title: Center(child:new Text("BloodHunt", style: TextStyle(fontFamily: "Arcon",fontWeight: FontWeight.bold),), 
        ) 
      ),
          body: Container(
           
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/home.jpg"),
            fit: BoxFit.fill,
             ),
             ),
              //color: Color.fromRGBO(234, 239, 241, 1.0),
              //margin: EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  //SizedBox(height: 10.0,),
                  Container(
                    //height: 400,
                   
                    margin: EdgeInsets.all(10.0),
           
                    child: Column(
                      children: <Widget>[
                        //SizedBox(height: 20.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Blood",style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                            new Icon(FontAwesomeIcons.tint,color: Colors.red,size: 30,)
                            ],),
                        SizedBox(height: 20.0,),
                     searchfields(context),
                       
                        SizedBox(height: 20.0,),
                        searchbutton()],
                        ) ),
                        //SizedBox(height: 60.0,),
                       Container(
                        
                         //height:400,
                         decoration: BoxDecoration(
                           color: Colors.white70,
                           
                           borderRadius: BorderRadius.all(Radius.circular(25.0)),),
                           margin: EdgeInsets.all(10.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                    Text("Users",style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                                    SizedBox(height: 10.0,),
                                      Text(user.toString(),style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                                 ],
                               ),
                              SizedBox(width: 60.0,),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                    Text("Donors",style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                                      SizedBox(height: 10.0,),
                                      Text(donor.toString(),style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                                 ],
                               )
                             ],
                           ),
                           )
                        ],)
                        ),
          
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
