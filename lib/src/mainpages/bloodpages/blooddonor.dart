import 'package:blooddonor/src/mainpages/Bloodpages/bloodpage.dart';
import 'package:blooddonor/src/mainpages/homepages/mainpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

class Blooddonorpage extends StatefulWidget {
  String m;
Blooddonorpage(this.m);
  @override
  _BlooddonorState createState() => new _BlooddonorState(m);
}

class _BlooddonorState extends State<Blooddonorpage> {
  User user;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  int genderValue;
  String gender, _error = "",m;
  String bloodgrp;
_BlooddonorState(this.m);
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Blood Donor"),
      ),
      body: new Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              errorField(),
               usernameField(),
                 mobileField(),
              bloodfield(),
              emailField(),
             
              genderField(),
            
            //  passwordField(),
              addressField(),
              Container(
                margin: EdgeInsets.only(top: 25),
              ),
              signbutton()
            ],
          ),
        ),
      ),
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

  Widget institutionField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Institution Name"),
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
        onSaved: (val) => user.department = val,
        validator: (String value) {
          if (value == "") {
            return "Department is required";
          }
        });
  }

  Widget mobileField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Mobile"),
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
        decoration: InputDecoration(labelText: "Address"),
        onSaved: (val) => user.address = val,
        validator: (String value) {
          if (value == "") {
            return "Address is required";
          }
        });
  }

Widget bloodfield() {
    return new ListTile(
      leading: new Text("Blood Group",
          style: new TextStyle(color: Colors.black, fontSize: 16)),
      title: DropdownButton(
        hint: Text('Please choose a Blood Group'), // Not necessary for Option 1
        value: bloodgrp,
        onChanged: (newValue) {
          setState(() {
            bloodgrp = newValue;
          });
        },
        items: bloodes.map((cls) {
          return DropdownMenuItem(
            child: new Text(cls),
            value: cls,
          );
        }).toList(),
      ),
    );
  }
  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text("Sign Up"),
      onPressed: () {
        if (formKey.currentState.validate()) {
           databaseReference.push().set(user.toJson());
             
        }
      },
    );
  }
  
  Widget signbutton() {
    return InkWell(
      onTap: () {
      if (formKey.currentState.validate()) {
            formKey.currentState.save();
            user.gender=gender;
            user.bloodgroup=bloodgrp;
            user.password="123456";
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
              databaseReference.push().set(user.toJson());
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new MainPage(m));
              Navigator.of(context).push(router);
            } else {
              setState(() {
                _error = "Mobile number is already exist";
              });
            }
          }).catchError((onError) {
            setState(() {
              _error = "";
            });
            formKey.currentState.reset();
            //save form data to the database
         
          });



          //  databaseReference.push().set(user.toJson());
          //    formKey.currentState.reset();
          //      var router = new MaterialPageRoute(
          //         builder: (BuildContext context) => new BloodsPage());

          //     Navigator.of(context).pushReplacement(router);
        }
      },
      child: Container(
        width: 400,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(220, 20, 60, 0.8),
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
              'Create Donor',
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
