import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/story.dart';
import '../../models/user.dart';
import 'stories.dart';

class BloodstoriesPage extends StatefulWidget {
  User u;

  BloodstoriesPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return BloodstoriesPageState(u);
  }
}

class BloodstoriesPageState extends State<BloodstoriesPage> {
  User u;
 BloodstoriesPageState(this.u);
  String text="";
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  String search="";
  Widget appBarTitle;
  Icon actionIcon = new Icon(Icons.search);
  @override
  void initState() {
    setState(() {
      super.initState();
      databaseReference = database.reference().child("stories");

    });
  }


  Future<List<Story>> _getStories() async {
    List<Story> stories = List();
    await databaseReference.once().then((DataSnapshot snapshot) {
      if (snapshot.value.values != null) {
        for (var value in snapshot.value.values) {
          Story s= new Story(value["username"], value["gender"], value["mobile"], value["bloodgroup"], value["story"], value["time"]); 
          stories.add(s);
        }
      }
    
    });

 
    
    return stories;
  }
  String story="";
  Future<bool> addstory() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Blood Stories'),
                content: new Container(
      width:300,
      child: TextField(
        maxLines: 10,
                onChanged: (value) {
                  setState(() {
                   story=value; 
                  });
                 // filterSearchResults(value);
                },
                style: new TextStyle(
                  fontFamily: "Arcon",
                  fontSize: 10,
                 // height: 6
                ),
                //controller: editingController,
                decoration: InputDecoration(
                    labelText: "Story",
                    hintText: "Share your story and inspire others for blood donation. Your story can inspire a thousand to give blood and safe life.",
                   // prefixIcon: Icon(Icons.search),
                    //prefixIcon: new Icon(FontAwesomeIcons.tint,color: Colors.red,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)))),
              ),
      
    ),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('Close'),
                  ),
                  new FlatButton(
                    onPressed: () =>{ 
                      addStory(),
                      _getStories(),
                      Navigator.of(context).pop(true)
                      },
                    child: new Text('Share'),
                  ),
                ],
              ),
        ) ??
        false;
  }
  void addStory(){
    if(story!=""){
  int time= new DateTime.now().millisecondsSinceEpoch;
    Story s= new Story(u.username, u.gender, u.mobile,u. bloodgroup, story, time);
    databaseReference.push().set(s.toJson());
    }
  
  }
  void addTution() {
    // var router = new MaterialPageRoute(
    //     builder: (BuildContext context) => new AddTution(u));
    // Navigator.of(context).push(router);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   title: Center(child:new Text("BloodHunt", style: TextStyle(fontFamily: "Arcon",fontWeight: FontWeight.bold),), 
      //   ) 
      // ),
          body: Container(
             decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main.png"),
            fit: BoxFit.fill,
             ),
             ),
             // color: Color.fromRGBO(234, 239, 241, 1.0),
              //margin: EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: _getStories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                            "Please check your internet connection"),
                      ),
                    );
                  } else {
                    return Stories(snapshot.data);
                  }
                },
                
              )
              ),
         floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              addstory();
              // var router = new MaterialPageRoute(
              //     //builder: (BuildContext context) => //new Blooddonorpage(m)
              //     );
              // Navigator.of(context).push(router);
            },
            label: Text(
              'Share Your Blood Donation Story',
            ),
            icon: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(220, 20, 60, 0.8),
          ),
        );
  
  }
}

