import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String username;
  String gender;
  String institution;
  String department;
  String uid;
  var area = [];
  var notification = [];
  var subject=[];
  String address;
  String mobile;
  String password;
  String email;
  String rating;
  String number;
  String etuition='No';
  String f='x';
  String bloodgroup;
  int donationnumber=0;
  int donationtime=0;

  User(
      this.username,
      this.gender,
      this.address,
      this.bloodgroup,
      //this.area,
      //this.department,
   //   this.institution,
      this.mobile,
      this.password,
      this.email,
    //  this.rating,
      //this.number,
     // this.subject
     );

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        username = snapshot.value["username"],
        gender = snapshot.value["gender"],
        bloodgroup=snapshot.value['bloodgroup'],
        institution = snapshot.value["institution"],
        department = snapshot.value["department"],
        area = snapshot.value["area"],
        address = snapshot.value["address"],
        mobile = snapshot.value["mobile"],
        password = snapshot.value["password"],
        email = snapshot.value["email"],
        rating = snapshot.value["rating"],
        number = snapshot.value["number"],
        subject = snapshot.value["subject"],
        notification = snapshot.value["notification"];
  toJson() {
    return {
      "username": username,
      "password": password,
      "gender": gender,
      "bloodgroup": bloodgroup,
      "area": area,
      "address": address,
      "mobile": mobile,
      "email": email,
      "donationnumber":donationnumber,
      "donationtime":donationtime,

     
     
      
    };
  }
}
