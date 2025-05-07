import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/widget/BottomNavigationbar/BottomNvigationBar.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/card/addresscard.dart';

class LoyaltyPoints extends StatelessWidget {
  const LoyaltyPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      body: Stack(
        children: [
          Padding(
          padding: const EdgeInsets.only(top: 35,left: 10),
          child: customBackbutton1(onpress: (){
            Navigator.push(
              context,MaterialPageRoute(
              builder:(context)=>Bottomnvigationbar()));
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50,left: 170),
          child: Text("Loyality Points",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10,top: 100),
          child: SizedBox(
            height: 210,
            width: 392,
            child: Card(
              color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
            children: [ 
              Padding(
                padding: const EdgeInsets.only(top: 50,left: 180),
                child: Text(
                  "Convertible Points !",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60,left: 90),
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.asset("assets/icons/loyality_point.png")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80,left: 180),
                child: Text("0",
                style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold),),
              ), 
            ],
         )
        ),
          ),
        ),
         Padding(
                padding: const EdgeInsets.only(top: 330,left: 20),
                child: Text(
                  "Point History",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 500,left: 100),
                child: Image.asset("assets/icons/no_data_found.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 760,left: 60),
                child: SizedBox(
                  height: 54,
                  width: 303,
                  child: Custombutton(
                    text: Text("Convert to Booking",
                    style: TextStyle(
                      color: Colors.white,
                    fontSize: 20),), 
                    onpress: (){}),
                ),
              )
      ]
      )
      );
  }
}