import 'package:flutter/material.dart';


class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> with TickerProviderStateMixin {
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/FAQ.jpg"),
            fit: BoxFit.fill,
          ),
        ),
     
    ));
  }

  
}
