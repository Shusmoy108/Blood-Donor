import 'package:blooddonor/src/mainpages/bloodpages/bloodpage.dart';
import 'package:blooddonor/src/mainpages/homepages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  String email;
  String password;

  final loginFormKey = GlobalKey<FormState>();
  bool _autovalidateLoginform = false;
  bool _shouldObscureText = true;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  String _email, _password, _error = "";


  @override
  void initState() {
    setState(() {
      super.initState();
      databaseReference = database.reference().child("users");
    });
  }

  void toggleObscureFlag() {
    setState(() {
      _shouldObscureText = !_shouldObscureText;
    });
  }

  saveAuthData(bool value, User u) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('auth', value);
    sp.setString("mobile", email);
  }

  void login() {
    //  var router = new MaterialPageRoute(
    //           builder: (BuildContext context) => new BloodsPage()
              
    //           );
    //       Navigator.of(context).pushReplacement(router);
    databaseReference
        .orderByChild("mobile")
        .equalTo(email)
        .once()
        .then((onValue) {
      for (var value in onValue.value.values) {
        if (value['password'] == password) {
          setState(() {
            _error = "";
          });

          User u;
          u = User(
              value["username"],
              value["gender"],
              value["address"],
                 value["bloodgroup"],
              // value["area"],
              // value["department"],
              // value["institution"],
              value["mobile"],
              value["password"],
              value["email"],
           
              // value["rating"],
              // value["number"],
              // value["subject"]
              );
              //u.etuition=value["etuition"];
          //print(value);
          // String x = value["number"];
          // u.number = int.parse(x);
          // // u.rating = value["rating"];
         // print(u.number);
         // print(u.rating);
          for (var key in onValue.value.keys) {
            u.uid = key;
          }
          saveAuthData(true, u);
          var router = new MaterialPageRoute(
              builder: (BuildContext context) => new MainPage(email)
              
              );
          Navigator.of(context).pushReplacement(router);
        } else {
          print("fdds");
          setState(() {
            _error = "Incorrect Email or Password";
          });
        }
      }
    }).catchError((onError) {
      print(onError);
      setState(() {
        _error = "Incorrect Email or Password";
      });
    });
    // if (email == 'ab@xy.com' && password == '12345') {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (BuildContext context) {
    //         return MainPage();
    //       },
    //     ),
    //   );
    // }
  }

  Widget errorField() {
    return new Text(
      _error,
      style: new TextStyle(fontSize: 20, color: Colors.greenAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/blood.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      child: Center(
        child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
               
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    //  animatedCcup(),
                      SizedBox(
                        height: 10.0,
                      ),
                      errorField(),
                      emailField(),
                      passwordField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      loginbutton(),
                      forgetPassowrd(),
                      noAccount(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        
      ),
    ));
  }

  Widget animatedCcup() {
    return Container(
      child: Center(
        child: Container(
          // width: 500,
          // height: 100,
          child: Image(
            image: AssetImage(
              'images/blood.jpg',
            ),
          ),
        ),
      ),
    );
  }

 Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Mobile Number *',
        icon: Icon(
          Icons.call,
          color: Colors.black87,
        ),
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      autovalidate: _autovalidateLoginform,
      validator: (String value) {
        if (isNumeric(value)&& value.length==11)
          return null;
        else
          return 'Mobile number is invalid';
      },
      onSaved: (String value) {
        email = value;
      },
    );
  }
 bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password *',
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
        icon: Icon(
          Icons.lock,
          color: Colors.black87,
        ),
        suffix: GestureDetector(
          onTap: toggleObscureFlag,
          child: _shouldObscureText
              ? Icon(FontAwesomeIcons.solidEye)
              : Icon(FontAwesomeIcons.solidEyeSlash),
        ),
      ),
      obscureText: _shouldObscureText,
      validator: (String value) {},
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget loginbutton() {
    return InkWell(
      onTap: () {
        if (loginFormKey.currentState.validate()) {
          loginFormKey.currentState.save();
          login();
        } else {
          setState(() {
            _autovalidateLoginform = true;
          });
        }
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
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
              'Login',
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

  Widget submitButton() {
    return RaisedButton(
      //icon: Icon(Icons.navigate_next),
      child: Text('Login'),
      color: Colors.blue,

      textColor: Colors.white,
      onPressed: () {
        if (loginFormKey.currentState.validate()) {
          loginFormKey.currentState.save();
          login();
        } else {
          setState(() {
            _autovalidateLoginform = true;
          });
        }
      },
    );
  }

  Widget forgetPassowrd() {
    return Container(
      child: FlatButton(
        onPressed: () {},
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.black87,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }

  Widget noAccount() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
          ),
          SizedBox(
            width: 10.0,
          ),
          FlatButton(
            onPressed: () {
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new SignUp());

              Navigator.of(context).push(router);
            },
            child: Text(
              'Sign Up',
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
