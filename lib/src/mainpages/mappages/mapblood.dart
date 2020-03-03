import 'dart:async';
import 'package:blooddonor/src/mainpages/bloodpages/donorpage.dart';
import 'package:blooddonor/src/mainpages/mappages/mapblood.dart';
import 'package:blooddonor/src/mainpages/mappages/mappage.dart';
import 'package:blooddonor/src/mainpages/notificationpage/notifications.dart';
import 'package:blooddonor/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:blooddonor/src/mainpages/factpage/faqpage.dart';
import 'package:blooddonor/src/mainpages/profilepage/profilepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart' as prefix0;
class MapSearch extends StatefulWidget {
  String mobile;
  double lat,lng;
  MapSearch(this.mobile,this.lat,this.lng);
  @override
  State<MapSearch> createState() => MapSearchState(mobile,lat,lng);
}

class MapSearchState extends State<MapSearch> {
  
  User u;
  String mobile;
    double lat,lng;
  MapSearchState(this.mobile,this.lat,this.lng);
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
   static const  kGoogleApiKey = "AIzaSyAKyyxfAHcuiw5-U05cyN1z7CzgSsWSpHM";
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
Completer<GoogleMapController> _controller = Completer();

  
  Widget appBarTitle;
  String text;
  Icon actionIcon;
  String search="";
  void initState() {
    setState(() {
      super.initState();
      text="রক্তদান";
      appBarTitle = new Text(text);
      actionIcon=new Icon(FontAwesomeIcons.tint);
    });
  }
  static final CameraPosition _kLake = CameraPosition(
      bearing: 15,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 75,
      zoom: 12);
 Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit রক্তদান'),
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
  static  CameraPosition _kGooglePlex;
  Future<bool> loadAuthData(emial) async {
    CameraPosition p = CameraPosition(
            bearing: 15,
            target: LatLng(lat, lng),
            tilt: 75,
            zoom: 12);
            _kGooglePlex=p;
       databaseReference = database.reference().child("users");
       await  databaseReference
        .orderByChild("mobile")
        .equalTo(mobile)
        .once()
        .then((onValue) {
      for (var value in onValue.value.values) {
        
            u = User(
              value["username"],
              value["gender"],
              value["address"],
              value["bloodgroup"],
              value["mobile"],
              value["password"],
              value["email"],
              );
              u.donationnumber=value['donationnumber'];
              u.donationtime=value['donationtime'];
              u.donor=value['donor'];
          for (var key in onValue.value.keys) {
            u.uid = key;
          }
         
         //HomePage(email),
         
         
        // BloodstoriesPage(u)
      
        }});
    return true;
  }
  String bloodgrp="A+";
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
    return new Container(
      //width: MediaQuery.of(context).size.height*.3,
      child:new Row(
        children: <Widget>[
          new Text("",
          //style: new TextStyle(color: Colors.black, fontSize: 16)
          ),
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child:FutureBuilder(
        future: loadAuthData(mobile),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return Scaffold(
      appBar:AppBar(
        centerTitle: true,
         title:appBarTitle,
         actions: <Widget>[
           bloodfield(),
          new IconButton(icon: actionIcon,onPressed:(){
          setState(() {
                     if ( this.actionIcon.icon == Icons.search){
                    }
                      else {
                        search="";
                        this.actionIcon=new Icon(FontAwesomeIcons.tint);
                        String text="রক্তদান";
                        this.appBarTitle = new Text(text);
                      }


                    })
                    ;}
                    )
                    ]
      ) ,

    drawer: Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child:  Center(child:Text("রক্তদান",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
        decoration: BoxDecoration(
          color: Colors.red,
        ),
      ),
       ListTile(
        title: Text('Home'),
        onTap: () {
          Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                        builder: (context) =>MapSample(mobile),
                      ));
          
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: Text('Profile'),
        onTap: () {
          Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                        builder: (context) =>Profile(u),
                      ));
          
          // Update the state of the app.
          // ...
        },
      ),
       ListTile(
        title: Text('Donation History'),
        onTap: () {
            Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                        builder: (context) =>NotificationPage(u),
                      ));
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: Text('FAQ'),
        onTap: () {
           Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                        builder: (context) => FAQPage(u),
                      ));
        
        },
      ),
    ],
  ),
),
      body: GoogleMap(
        
        markers: Set.from(markers),
        mapType: MapType.normal,
        
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        
      ),
      // floatingActionButton:ButtonBar(children: <Widget>[
      //    FloatingActionButton.extended(
      //   onPressed: (){
      //     _goToTheLake();
      //     },
      //   label: Text('Search Blood'),
      //   icon: Icon(Icons.search),
      // ),
      //  FloatingActionButton.extended(
      //   onPressed: (){
      //     _goToTheLake();
      //     },
      //   label: Text('Show Blood'),
      //   icon: Icon(Icons.search),
      // ),
      // ],)
     floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
FloatingActionButton(
        onPressed: ()async {
            // show input autocomplete with selected mode
            // then get the Prediction selected
            final center= LatLng(lat, lng);
            Prediction p = await PlacesAutocomplete.show(
                    context: context, apiKey: kGoogleApiKey,
                    strictbounds: center==null?false:true,
                    mode: Mode.overlay,
                      onError: onError,
                    location: center==null?null:Location(lat,lng),
                    radius: center==null?null:10000000,
                    language: "en",
                    //components: [new Component(Component.country, "en")]
                    );
                displayPrediction(p);
          },
        child: Icon(Icons.search),
        heroTag: "",
        //icon: Icon(Icons.search),
      ),
      Padding(padding: EdgeInsets.only(bottom: 10),),
      FloatingActionButton(
        onPressed: () {
            // show input autocomplete with selected mode
            // then get the Prediction selected
            if(markers.length>0){
              setState(() {
                markers=[];
              });
            }
            else{
 setState(() {
              markers=getdata();
            });
            }
           
           //markers= getdata();
          },
          child: Icon(Icons.visibility),
        //icon: Icon(Icons.visibility),
      ),
      ],)
    );}
     else {
              return Container();
            }
          } else {
            return Container();
          }
        },
    
    ));
  }
  void onError(PlacesAutocompleteResponse response) {
    // homeScaffoldKey.currentState.showSnackBar(
    //   SnackBar(content: Text(response.errorMessage)),
    // );
    print(response.errorMessage);
    print("object");
  }
 Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      print(p);
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat); 
      print(lng);
       Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                        builder: (context) =>MapSearch(mobile, lat, lng),
                      ));

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

    Iterable markers=[]; 
    Iterable getdata() {
      Iterable _markers = Iterable.generate(10, (index) {
        
        LatLng latLngMarker = LatLng(lat+.01*index,lng+.01*index );
        return Marker(markerId: MarkerId("marker$index"),position: latLngMarker,infoWindow: InfoWindow(
          title: "Shusmoy",
          snippet: bloodgrp
          
        ), 
        visible: true,
       onTap: (){
 Navigator.of(context).push(
                       MaterialPageRoute(
                        builder: (context) =>DonorPage(u),
                      ));
        },
        icon: BitmapDescriptor.defaultMarker);
  }
  
  );
 return _markers;
 
}
void pok(){
print("tap");
}
 
   
}
// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
// var location = new Location();
// ///var userLocation;

// class MapSampleState extends State<MapSample> {
//   // Completer<GoogleMapController> _controller = Completer();

//   // static final CameraPosition _kGooglePlex = CameraPosition(
//   //   target: LatLng(37.42796133580664, -122.085749655962),
//   //   zoom: 14.4746,
//   // );
//   Iterable markers = [];
// var location = new Location();
// static var userLocation;
// //   @override
// //   void initState() async{
// //     try {
// //   userLocation = await location.getLocation();
// // } on PlatformException catch (e) {
// //   if (e.code == 'PERMISSION_DENIED') {
// //     userLocation = 'Permission denied';
// //     print(userLocation);
// //   } 
// //   userLocation = null;
// // }
// //    //userLocation =  await location.getLocation();
// //   }

// Future<CameraPosition> map() async{
//     try {
//   userLocation = await location.getLocation();
// } on PlatformException catch (e) {
//   if (e.code == 'PERMISSION_DENIED') {
//     userLocation = 'Permission denied';
//     print(userLocation);
//   } 
//   userLocation = null;
// }
// CameraPosition use = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(userLocation.latitude, userLocation.longitude),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
// print(userLocation.longitude);
// print(userLocation.latitude);
// return use;
//    //userLocation =  await location.getLocation();
//   }
//  CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.42796133580664, -122.085749655962),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
// // 1
// Completer<GoogleMapController> _controller = Completer();
// // 2
// CameraPosition _myLocation =
//   CameraPosition(target: LatLng(37.42796133580664, -122.085749655962),);
// getdata(){
//   Iterable _markers = Iterable.generate(10, (index) {
         
//           LatLng latLngMarker = LatLng(37.42+index*10,-122.0857+index*10 );

//           return Marker(markerId: MarkerId("marker$index"),position: latLngMarker);
//   });
//   markers=_markers;
// }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//   // 1
//   body: GoogleMap(
//     // 2
//     markers: Set.from(markers),
//     initialCameraPosition: _myLocation,
//     // 3
//     mapType: MapType.normal,
//     // 4
//     onMapCreated: (GoogleMapController controller) {
//       _controller.complete(controller);
//     },
//   ),
//   floatingActionButton: IconButton(
//     onPressed: (){
//       print("object");
//       getdata();
//       //_goToTheLake();
//     },
    
//     icon: Icon(Icons.location_on),
//   ),
// );

//   }

//   Future<void> _goToTheLake(CameraPosition p) async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
