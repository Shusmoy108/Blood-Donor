import 'package:firebase_database/firebase_database.dart';

class Notice {
  String key;
  String noti;
  int time;
  Notice(this.noti, this.time);
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

  Notice.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        noti = snapshot.value["noti"],
        time = snapshot.value["time"];
  toJson() {
    return {
      "noti": noti,
      "time": time,
    };
  }
}
