import 'dart:ui';

import 'package:flutter/material.dart';


class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> with TickerProviderStateMixin {
  

  Widget FAQ(String question,String answer){
    return Card(
      child: ListTile(
      
      title: Text(question, style: TextStyle(fontFamily: "Lobster",fontSize: 20),),
      subtitle: Text(answer, style: TextStyle(fontFamily: "Lobster",fontSize: 18)),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(child:new Text("Blood HUNT", style: TextStyle(fontFamily: "Arcon",fontWeight: FontWeight.bold),), 
        ) ),
      body: Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/drop.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
         children: <Widget>[
         FAQ("How does the blood donation process work?", "Donating blood is a simple thing to do, but can make a big difference in the lives of others. The donation process from the time you arrive until the time you leave takes about an hour. The donation itself is only about 8-10 minutes on average. The steps in the process are:\n\n1.Registration\n\nYou will complete donor registration, which includes information such as your name, address, phone number, and donor identification number (if you have one).\nYou will be asked to show a donor card, driver\’s license or two other forms of ID.\n\n2.Health History and Mini Physical\n\nYou will answer some questions during a private and confidential interview about your health history and the places you have traveled.\nYou will have your temperature, hemoglobin, blood pressure and pulse checked.\n\n3.Donation\n\nWe will cleanse an area on your arm and insert a brand–new, sterile needle for the blood draw. This feels like a quick pinch and is over in seconds.\nYou will have some time to relax while the bag is filling. (For a whole blood donation, it is about 8-10 minutes. If you are donating platelets, red cells or plasma by apheresis the collection can take up to 2 hours.)\nWhen approximately a pint of blood has been collected, the donation is complete and a staff person will place a bandage on your arm. \n\n4.Refreshments\n\nYou will spend a few minutes enjoying refreshments to allow your body time to adjust to the slight decrease in fluid volume.\nAfter 10-15 minutes you can then leave the donation site and continue with your normal daily activities.\nEnjoy the feeling of accomplishment knowing that you have helped to save lives.\nYour gift of blood may help up to three people. Donated red blood cells do not last forever. They have a shelf-life of up to 42 days. A healthy donor may donate every 56 days."),
            FAQ("Who can donate blood?","In most states, donors must be age 17 or older. Some states allow donation by 16-year-olds with a signed parental consent form. Donors must weigh at least 110 pounds and be in good health. Additional eligibility criteria apply."),
          FAQ("How often can I donate blood?","You must wait at least eight weeks (56 days) between donations of whole blood and 16 weeks (112 days) between Power Red donations. Platelet apheresis donors may give every 7 days up to 24 times per year. Regulations are different for those giving blood for themselves (autologous donors)."),
          FAQ("How long will it take to replenish the pint of blood I donate?","The plasma from your donation is replaced within about 24 hours. Red cells need about four to six weeks for complete replacement. That’s why at least eight weeks are required between whole blood donations."),
          FAQ("How long does a blood donation take?","The entire process takes about one hour and 15 minutes; the actual donation of a pint of whole blood unit takes eight to 10 minutes. However, the time varies slightly with each person depending on several factors including the donor’s health history and attendance at the blood drive."),
          FAQ("Will it hurt when you insert the needle?","Only for a moment. Pinch the fleshy, soft underside of your arm. That pinch is similar to what you will feel when the needle is inserted."),
          FAQ("Can I bring my children to the donation site?", "Children who do not require supervision and are not disruptive are welcome to sit in the waiting or refreshment area. If they require supervision, then another adult must be present."),
          FAQ("What is apheresis?", "Apheresis is the process by which platelets and other specific blood components (red cells or plasma) are collected from a donor. The word “apheresis” is derived from the Greek word aphaeresis meaning “to take away.” This process is accomplished by using a machine called a cell separator. Blood is drawn from the donor and the platelets, or another blood component, are collected by the cell separator and the remaining components of the blood are returned to the donor during the donation. Each apheresis donation procedure takes about one-and-one-half to two hours. Donors can watch movies or relax during the donation."),
          FAQ("What are platelets and how are they used?", "Platelets are tiny, colorless, disc-shaped particles circulating in the blood, and they are essential for normal blood clotting. Platelets are critically important to the survival of many patients with clotting problems (aplastic anemia, leukemia) or cancer, and patients who will undergo organ transplants or major surgeries like heart bypass grafts. Platelets can only be stored for five days after being collected. Maintaining an adequate supply of this lifesaving, perishable product is an ongoing challenge."),
          FAQ("How often can I give platelets?", "Every 7 days up to 24 apheresis donations can be made in a year. Some apheresis donations can generate two or three adult-sized platelet transfusion doses from one donation"),
         ],
        )
     
    ));
  }

  
}
