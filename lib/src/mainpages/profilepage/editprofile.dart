
import 'package:blooddonor/src/mainpages/homepages/mainpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import '../../models/user.dart';
import 'dart:ui';



class EditProfile extends StatefulWidget {
  User u;
  EditProfile(this.u);
  @override
 EditProfileState createState() => new EditProfileState(u);
}

class EditProfileState extends State<EditProfile> {
  User user;
  EditProfileState(this.user);
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  int genderValue;
  String gender, _error = "";
  bool donor;

  @override
  void initState() {
    setState(() {
      super.initState();
      gender=user.gender;
      print(user.donor);
      if(user.donor=="Yes"){
        donor=true;
      }
      else {
        donor=false;
      }
     if(user.gender=='Male'){
       
       genderValue=1;
     }
     else{
       genderValue=0;
     }
  
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
  void edit(){
      databaseReference = database.reference().child("users/${user.uid}");
      databaseReference.update({
      "username": user.username,
      "password": user.password,
      "gender": user.gender,
      "address": user.address,
      "email": user.email,
      "bloodgroup":user.bloodgroup,
      "donor":user.donor
     
      });
  }
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
      initialValue: user.email,
      enabled: false,
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
         initialValue: user.password,
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
         initialValue: user.username,
        onSaved: (val) => user.username = val,
        validator: (String value) {
          if (value == "") {
            return "Username is required";
          }
        });
  }

  Widget institutionField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Institution Name"),
         initialValue: user.institution,
        onSaved: (val) => user.institution = val,
        validator: (String value) {
          if (value == "") {
            return "Institution name is required";
          }
        });
  }

  Widget departmentField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Department"),
         initialValue: user.department,
        onSaved: (val) => user.department = val,
        validator: (String value) {
          if (value == "") {
            return "Department is required";
          }
        });
  }

  Widget mobileField() {
    return new TextFormField(
      readOnly: true,
        decoration: InputDecoration(labelText: "Mobile"),
         initialValue: user.mobile,
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
          activeColor: Colors.pink,
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

  Widget addressField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Detail Address"),
         initialValue: user.address,
        onSaved: (val) => user.address = val,
        validator: (String value) {
          if (value == "") {
            return "Address is required";
          }
        });
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
          value: user.bloodgroup,
          onChanged: (newValue) {
            setState(() {
              user.bloodgroup = newValue;
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
  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text("Edit Profile"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          user.gender = gender;
          if(donor){
            user.donor="Yes";
          }
          else{
            user.donor="No";
          }
          formKey.currentState.save();
          edit();
           var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new MainPage(user.mobile));
           
              Navigator.of(context).pushReplacement(router);
        }
      },
    );
  }

  Widget signbutton() {
    return InkWell(
      onTap: () {
     if (formKey.currentState.validate()) {
          user.gender = gender;
          if(donor){
            user.donor="Yes";
          }
          else{
            user.donor="No";
          }
          formKey.currentState.save();
          edit();
           var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new MainPage(user.mobile));
           
              Navigator.of(context).pushReplacement(router);
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
              'Edit Profile',
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
