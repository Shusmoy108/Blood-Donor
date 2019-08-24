import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/user.dart';
import 'package:url_launcher/url_launcher.dart';
class Bloods extends StatelessWidget {

  User u;
  List<User> users;
  bool ty = false;
  Bloods(this.users);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  Widget button(index, context) {
    return InkWell(
      onTap: () {
        String m = users[index].mobile;
        _launchURL(m);
      },
      child: Container(
        width: 80,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Call',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }

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
 void _launchURL(m) async {
    String url = "tel:" + m;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildProductItem(BuildContext context, int index) {
   return Card(
     child:ListTile(
     title:  stylishText(users[index].username, 20.0),
     leading: stylishText(users[index].bloodgroup, 25.0),
     subtitle: stylishText(users[index].address, 15.0),
     trailing: button(index, context),
   ) ,
   ) ;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: buildProductItem,
      itemCount: users.length,
    );
  }
}
