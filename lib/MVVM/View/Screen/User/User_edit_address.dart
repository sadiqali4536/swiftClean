import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/address_page.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/formfield/customformfield2.dart';

class userEditAddress extends StatelessWidget {
  const userEditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 10),
            child: customBackbutton1(
              onpress: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>AddressPage())
                );
              }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40,left: 150),
            child: Text("My Address",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
           Padding(
                padding: const EdgeInsets.only(top: 120,left: 20),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: 370,
                    height: 300,
                    child: Customformfield2(
                      maxline: 15,
                      keyboardtype: TextInputType.streetAddress,
                      hight: 100,
                      color: primary.c,
                      hinttext: "Enter your Address",
                      hintstyle: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
                      validator: (String? value) { 
                        if (value == null || value.isEmpty) {
                          return "Enter your Address";
                        }
                        return null; 
                      }, 
                    ),
                  ),
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.only(top: 435, left: 270),
                    child: SizedBox(
                      height: 45,
                      width: 119,
                      child: Custombutton(
                        text: Text(
                          "Update",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onpress: (){})
                        ),
                        ),             
                      ],
                    ),
                 );
               }
             }