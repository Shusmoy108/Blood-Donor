import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/user.dart';

class DonorPage extends StatefulWidget {
  User u;
  DonorPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return DonorPagestate(u);
  }
}
class DonorPagestate extends State<DonorPage> {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference databaseReference;
    User u;
    String date;
    DonorPagestate(this.u);
    @override
    void initState() {
    setState(() {
      if (u.donationtime==0){
        date="Not donated blood yet";

      }
      else{
        DateTime d= new DateTime.fromMillisecondsSinceEpoch(u.donationtime);
        date= d.day.toString()+"/"+d.month.toString()+"/"+d.year.toString();
      }
    });
    }

      void _launchURL(m) async {
    String url = "tel:" + m;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(child:new Text("Blood HUNT", style: TextStyle(fontFamily: "Arcon",fontWeight: FontWeight.bold),), 
        ) ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(123, 214, 255, 1.0),
                      Color.fromRGBO(115, 156, 255, 1.0)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                heightFactor: 1.4,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/pp.gif'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      u.username,
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      u.gender,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.6 - 27,
                left: MediaQuery.of(context).size.width * 0.5 - 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: MaterialButton(
                    onPressed: () {
                         String m = u.mobile;
                         _launchURL(m);
                        
                    },
                    minWidth: 120.0,
                    height: 35.0,
                    color: Colors.greenAccent,
                    textColor: Colors.black87,
                    child: Text(
                      'Call Donor',
                      style: TextStyle(
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Text(
              u.bloodgroup,
              style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.contacts,
                        size: 14.0,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'CONTACT INFORMATION',
                        style: TextStyle(
                          letterSpacing: 1.2,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Mobile:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                    Text(
                      u.mobile,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                    Text(
                      u.email,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                    Container(
                      width: 220,
                      child: Text(
                        u.address,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(0, 0, 0, 0.8),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.rate_review,
                          size: 14.0,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'DONATION DETAILS',
                          style: TextStyle(
                            letterSpacing: 1.2,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
          
                 SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                    "Donation Number: ${u.donationnumber}",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      wordSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                    "Last Donation Date: ${date}",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      wordSpacing: 1.0,
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
