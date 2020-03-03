import 'package:blooddonor/src/mainpages/bloodpages/blooddonor.dart';
import 'package:blooddonor/src/mainpages/bloodpages/bloodpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blooddonor/src/models/user.dart';
class AboutPage extends StatefulWidget {
  User u;
  String m;
  AboutPage(this.m);
  //AllTutionPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return AboutPageState(m);
  }
}

class AboutPageState extends State<AboutPage> {
  User u;
  String m;
 AboutPageState(this.m);
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
      width:156,
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
          style: new TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
          SizedBox(width: 10.0,   ),
          new DropdownButton(
          
        //hint: Text('Please choose a Blood Group'), // Not necessary for Option 1
          value: blds,
          style:TextStyle(color:Colors.black,fontSize: 15, fontWeight: FontWeight.bold) ,
          onChanged: (newValue) {
            setState(() {
              blds = newValue;
            });
          },
          items: bloodes.map((blood) {
            return DropdownMenuItem(

              child: new Text(blood,style: TextStyle(color:Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
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
      decoration: BoxDecoration(
        color: Color.fromRGBO(220, 20, 60, 0.8),                   
        borderRadius: BorderRadius.all(Radius.circular(15.0)),),
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
                    hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,size: 60,
              color: Colors.black,
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
     return Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
       Text("Idea Credit"),
        Text("Arif Hasan Chowdhury"),
        Text("Priyam Chowdhury"),
        Text("Lecturer"),
        Text("Southern University Bangladesh"),
         SizedBox(height: 10.0,),
        Text("Designed and Developed By"),
        Text("Shusmoy Chowdhury"),
        Text("Lecturer"),
        Text("Southern University Bangladesh"),
         Text("Email: 1305108.sc@ugrad.cse.buet.ac.bd"),
         ]);
  
  }

   @override
  Widget build(BuildContext context) {
    return Container(
           
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main.png"),
            fit: BoxFit.cover,
             ),
             ),
              //color: Color.fromRGBO(234, 239, 241, 1.0),
              //margin: EdgeInsets.all(10.0),
              child: Scaffold(
      //   appBar: new AppBar(
      //   title: Center(child:new Text("BloodHunt", style: TextStyle(fontFamily: "Arcon",fontWeight: FontWeight.bold),), 
      //   ) 
      // ),
      backgroundColor: Colors.transparent,
          body: Container(
            child: Stack(
              alignment:Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  child: ListView(
                children: <Widget>[
                  //SizedBox(height: 10.0,),
                  Container(
                    //height: 400,
                   color: Colors.white54,
                    margin: EdgeInsets.all(10.0),
           
                    child: Column(
                      children: <Widget>[
                        //SizedBox(height: 20.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("রক্তদান",style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                            new Icon(FontAwesomeIcons.tint,color: Colors.red,size: 30,)
                            ],),
                        SizedBox(height: 20.0,),
                  Text("Sponsored By",style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                                      SizedBox(height: 10.0,),
                                      Text("LandStainer Blood Donation",style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                                        Text("Center",style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                                      Text("Golphahar Circle",style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
                                      Text("Chittagong",style: TextStyle(fontFamily: "Lobster",fontSize: 30),),
              
                         SizedBox(height: 20.0,)],
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
                                    Text("Idea Credit",style: TextStyle(fontFamily: "Lobster",fontSize: 15),),
                                    SizedBox(height: 10.0,),
                                      Text("Arif Hasan Chowdhury",style: TextStyle(fontFamily: "Lobster",fontSize: 10),),
                                      SizedBox(height: 10.0,),
                                      Text("Priyam Chowdhury",style: TextStyle(fontFamily: "Lobster",fontSize: 10),),
                                      SizedBox(height: 10.0,),
                                      Text("Lecturer",style: TextStyle(fontFamily: "Lobster",fontSize: 10),),
                                      SizedBox(height: 10.0,),
                                      Text("Southern University Bangladesh",style: TextStyle(fontFamily: "Lobster",fontSize: 10),),

                                 ],
                               ),
                              SizedBox(width: 20.0,),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                    Text("Designed & Developed By",style: TextStyle(fontFamily: "Lobster",fontSize: 15),),
                                      SizedBox(height: 10.0,),
                                      Text("Shusmoy Chowdhury",style: TextStyle(fontFamily: "Lobster",fontSize: 10),),
                                      SizedBox(height: 10.0,),
                                      Text("Lecturer",style: TextStyle(fontFamily: "Lobster",fontSize: 10),),
                                      SizedBox(height: 10.0,),
                                      Text("Southern University Bangladesh",style: TextStyle(fontFamily: "Lobster",fontSize: 10),),
                                      SizedBox(height: 10.0,),
                                      Text("Email: 1305108.sc@ugrad.cse.buet.ac.bd",style: TextStyle(fontFamily: "Lobster",fontSize: 10),),
                                 ],
                               )
                             ],
                           ),
                           ),
                        ],),
                ),
              
              ],
            ),
          ),
                    
                        ),
          
        
        );
  }

}
