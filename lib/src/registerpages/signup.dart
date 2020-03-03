import 'package:blooddonor/src/mainpages/homepages/mainpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'dart:ui';
import 'package:blooddonor/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart' as prefix0;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  User user;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  int genderValue;
  String gender, _error = "";
  String bloodgrp;
  
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

  @override
  void initState() {
    setState(() {
      super.initState();
      genderValue = 0;
      gender = "Male";
      bloodgrp="A+";
      user = User("", "","", "", "", "","");
      user.notification = [];
      databaseReference = database.reference().child("users");
    });

    //databaseReference.onChildAdded.listen(_onEntryAdded);
    //databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  void handleGender(int value) {
    setState(() {
      if (value == 0) {
        gender = "Female";
        genderValue = 0;
      } else {
        gender = "Male";
        genderValue = 1;
      }
    });
  }
bool donor=false;
  Widget checkbox(){
    return new Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: donor,
            onChanged: (bool value) {
                setState(() {
                    donor = value;
                });
            },
            
        ),
        Text("I am a Donor",style:TextStyle(fontFamily: "Arcon",fontSize: 20)),
        ],
      ),
    );

  }
    static const  kGoogleApiKey = "AIzaSyAKyyxfAHcuiw5-U05cyN1z7CzgSsWSpHM";
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  
var location = new prefix0.Location();
double lat,lng;
static var userLocation;
  @override
  void map() async{
//     try {
//   userLocation = await location.getLocation();
// } on PlatformException catch (e) {
//   if (e.code == 'PERMISSION_DENIED') {
//     userLocation = 'Permission denied';
//     print(userLocation);
//   } 
//   userLocation = null;
// }
user.lat="0";
user.long= "0";
 databaseReference.push().set(user.toJson());
            var router = new MaterialPageRoute(
                builder: (BuildContext context) => new MainPage(user.mobile));
            Navigator.of(context).pushReplacement(router);
              formKey.currentState.reset();
print(userLocation.longitude);
print(userLocation.latitude);
   //userLocation =  await location.getLocation();
  }

 @override
  Widget build(BuildContext context) {
    return  Container(
         decoration: BoxDecoration(
            color: Colors.white,
          image: DecorationImage(
            image: AssetImage("images/main.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:Scaffold(
          backgroundColor: Colors.white54,
      body: Container(
          //color: Colors.white54,
        child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: ListView(
                   // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    //  animatedCcup(),
                      SizedBox(
                        height: 10.0,
                      ),
                          usernameField(),
                 mobileField(),
              bloodfield(),
              emailField(),
             
              genderField(),
            
              passwordField(),
               SizedBox(
                        height: 10.0,
                      ),
              addressField(),
              checkbox(),
                 SizedBox(
                        height: 10.0,
                      ),
              signbutton()
                  
                    
                    ],
                  ),
                ),
              ),
            ],
          ),
        
      ),)
    );
  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  Widget errorField() {
    return new Text(
      _error,
      style: new TextStyle(fontSize: 20, color: Colors.redAccent),
    );
  }

  Widget emailField() {
    return new TextFormField(
      decoration: InputDecoration(labelText: "Email"),
      onSaved: (val) => user.email = val,
      validator: (String value) {
        if (!value.contains("@")) {
          return "Email must be valid";
        }
      },
    );
  }

  Widget passwordField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Password"),
        onSaved: (val) => user.password = val,
        validator: (String value) {
          if (value.length <= 4) {
            return "Password length must be greater than 4";
          }
        });
  }

  Widget usernameField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Username"),
        onSaved: (val) => user.username = val,
        validator: (String value) {
          if (value == "") {
            return "Username is required";
          }
        });
  }

  
  Widget mobileField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Mobile"),
           keyboardType: TextInputType.number,
        onSaved: (val) => user.mobile = val,
        validator: (String value) {
          if (!isNumeric(value) && value.length == 11) {
            return "Mobile must be a valid";
          }
        });
  }

  Widget genderField() {
    return new Container(
        child: new Row(
      children: <Widget>[
        new Text("Gender",
            style: new TextStyle(color: Colors.black, fontSize: 16)),
        new Radio<int>(
          activeColor: Colors.green,
          value: 0,
          groupValue: genderValue,
          onChanged: handleGender,
        ),
        new Text("Female", style: new TextStyle(color: Colors.black)),
        new Radio<int>(
          activeColor: Colors.green,
          value: 1,
          groupValue: genderValue,
          onChanged: handleGender,
        ),
        new Text("Male", style: new TextStyle(color: Colors.black)),
      ],
    ));
  }
Future<LatLng> getUserLocation() async {
 //var currentLocation = <String, double>{};
 final uLocation = userLocation = await location.getLocation();
try {
  //currentLocation = await uLocation.getLocation();
  final lat = uLocation.latitude;
  final lng = uLocation.longitude;
  final center = LatLng(lat, lng);
  return center;
} on Exception {
  //currentLocation = null;
  return null;
}
}
  Widget addressField() {
     return new TextFormField(
        decoration: InputDecoration(labelText: "Address"),
           keyboardType: TextInputType.number,
        onSaved: (val) => user.address = val,
        validator: (String value) {
          if (value.length> 11) {
            return "Address must be a given";
          }
        });
  //   return InkWell(
  //     onTap:  ()async {
  //           // show input autocomplete with selected mode
  //           // then get the Prediction selected
            
  //          final center = await getUserLocation();
  // Prediction p = await PlacesAutocomplete.show(
  //     context: context,
  //     strictbounds: center == null ? false : true,
  //     apiKey: kGoogleApiKey,
  //     //onError: onError,
  //     mode: Mode.overlay,
  //     language: "en",
  //     location: center == null
  //         ? null
  //         : Location(center.latitude, center.longitude),
  //     radius: center == null ? null : 100000000);
  //               displayPrediction(p);
  //         },
  //     child: Container(
  //       width: 400,
  //       height: 40,
  //       decoration: BoxDecoration(
  //         ///color: Color.fromRGBO(220, 20, 60, 0.8),
  //         color: Colors.green,
  //         borderRadius: BorderRadius.circular(30.0),
  //         boxShadow: [
  //           //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
  //         ],
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             addressT,
  //             style: TextStyle(
  //                 color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
  //           ),
  //           SizedBox(
  //             width: 0.0,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );;
  }
String addressT="Set Address";  
Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      print(p);
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      addressT= p.description;
      print(addressT);
      lat = detail.result.geometry.location.lat;
      lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat); 
      print(lng);
      //  Navigator.of(context).pushReplacement(
      //                  MaterialPageRoute(
      //                   builder: (context) =>MapSearch(mobile, lat, lng),
      //                 ));

    //    CameraPosition pi = CameraPosition(
    //         bearing: 15,
    //         target: LatLng(lat, lng),
    //         tilt: 75,
    //         zoom: 25);
    //         //getdata();
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(pi));
     }
  }

Widget bloodfield() {
    return new Container(
      //width: MediaQuery.of(context).size.height*.3,
      child:new Row(
        children: <Widget>[
          new Text("Blood Group",
          style: new TextStyle(color: Colors.black, fontSize: 16)),
          SizedBox(width: 10.0,   ),
          new DropdownButton(
        //hint: Text('Please choose a Blood Group'), // Not necessary for Option 1
          value: bloodgrp,
          onChanged: (newValue) {
            setState(() {
              bloodgrp = newValue;
            });
          },
          items: bloodes.map((blood) {
            return DropdownMenuItem(
              child: new Text(blood),
              value: blood,
            );
          }).toList(),
        ),
        ],
      ) 
    );
  }
  
  saveAuthData(bool value, User u) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('auth', value);
    sp.setString("mobile", u.mobile);
  }


  Widget signbutton() {
    return InkWell(
      onTap: () {
      if (formKey.currentState.validate()) {
            formKey.currentState.save();
            user.gender=gender;
            user.bloodgroup=bloodgrp;
            if(donor){
              user.donor="Yes";
            }
            else{
              user.donor="No";
            }
            databaseReference
              .orderByChild("mobile")
              .equalTo(user.mobile)
              .once()
              .then((onValue) {
            if (onValue.value == null) {
              setState(() {
                _error = "";
              });
                formKey.currentState.reset();
            //save form data to the database
            saveAuthData(true, user);
            map();
           

             
            } else {
              setState(() {
                _error = "Mobile number is already exist";
              });
            }
          }).catchError((onError) {
            setState(() {
              _error = "";
            });
          
          });



          
        }
      },
      child: Container(
        width: 400,
        height: 40,
        decoration: BoxDecoration(
          ///color: Color.fromRGBO(220, 20, 60, 0.8),
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
              'Sign Up',
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
}
