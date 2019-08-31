import 'package:firebase_database/firebase_database.dart';

class Story {
  String key;
  String username;
  String gender;
  String bloodgroup;
  String uid;
  String mobile;
  int status=1;
  int time;
  String story;
  Story(
      this.username,
      this.gender,
      this.mobile,
      this.bloodgroup,
      this.story,
      this.time,
    //  this.rating,
      //this.number,
     // this.subject
     );

  Story.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        username = snapshot.value["username"],
        gender = snapshot.value["gender"],
        mobile = snapshot.value["mobile"],
        bloodgroup=snapshot.value['bloodgroup'],
        story = snapshot.value["story"],
        time = snapshot.value["time"];
  toJson() {
    return {
      "username": username,
      "gender": gender,
      "mobile": mobile,
      "bloodgroup": bloodgroup,
      "story": story,
      "time":time, 
    };
  }
}
