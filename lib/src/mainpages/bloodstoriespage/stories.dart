import 'package:blooddonor/src/mainpages/bloodpages/donorpage.dart';
import 'package:blooddonor/src/mainpages/profilepage/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/story.dart';
import 'package:url_launcher/url_launcher.dart';
class Stories extends StatelessWidget {
  List<Story> stories;
  bool ty = false;
  Stories(this.stories);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  Widget stylishText(text, size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        //fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontFamily: 'Arcon',
      ),
    );
  }
  Widget date(index){
     DateTime d= new DateTime.fromMillisecondsSinceEpoch(stories[index].time);
     String dd= d.day.toString()+"/"+d.month.toString()+"/"+d.year.toString();
     return stylishText(dd, 15.0);
  }
  Widget buildProductItem(BuildContext context, int index) {
   return Card(
     color: Colors.white30,
     child:ListTile(
      title:  stylishText(stories[index].username, 20.0),
      leading: stylishText(stories[index].bloodgroup, 25.0),
      subtitle: stylishText(stories[index].story, 15.0),
      trailing: date(index),
   ) ,
   ) ;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: buildProductItem,
      itemCount: stories.length,
    );
  }
}
