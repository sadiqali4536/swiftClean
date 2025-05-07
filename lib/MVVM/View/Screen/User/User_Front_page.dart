import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swiftclean_project/MVVM/View/Authentication/LoginandSigning.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/Founctions/helper_functions.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';
import 'package:swiftclean_project/main.dart';

class UserFrontPage extends StatefulWidget {
  const UserFrontPage({super.key});

  State<UserFrontPage> createState() => _UserFrontPageState();
}

class _UserFrontPageState extends State<UserFrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 310),
              child: Image.asset("assets/image/user_frontpage.png",
                height: 800,
                width: 800,
                fit: BoxFit.cover,
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 710,right: 230),
              child: Align(
              child: Image.asset("assets/icons/logo2.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: Container(
                height: 650,
                width: 420,
                decoration: BoxDecoration(
                  color: primary.c,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: mq.height*0.03,left: mq.width*0.06),
                      child: SizedBox(
                        height: 80,
                        width: 140,
                      child: Image.asset("assets/image/home_clean.jpg")),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: mq.height*0.13, left:mq.width*0.09),
                      child: Text("Home Cleaning",
                          style: TextStyle(
                            fontSize: 16,
                          ),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: mq.height*0.05,left: mq.width*0.617),
                      child: SizedBox(
                        height: 65,
                        width: 104,
                      child: Image.asset("assets/image/outdoor_clean.png")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: mq.height*0.13,left: mq.width*0.580),
                      child: Text("Outdoor Cleaning",
                          style: TextStyle(
                            fontSize: 16),
                            )),
                             Padding(
                      padding: EdgeInsets.only(top: mq.height*0.19,left: mq.width*0.04),
                      child: SizedBox(
                        height: 85,
                        width: 140,
                      child: Image.asset("assets/image/car_clean.png")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: mq.height*0.28,left: mq.width*0.10),
                      child: Text("Car Cleaning",
                          style: TextStyle(
                            fontSize: 16),
                            )),
                             Padding(
                      padding: EdgeInsets.only(top: mq.height*0.20,left: mq.width*0.66),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                      child: Image.asset("assets/image/pet_clean.jpg")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: mq.height*0.28,left: mq.width*0.63),
                      child: Text("Pet Cleaning",
                          style: TextStyle(
                            fontSize: 16),
                            )),
                     Padding(
                       padding: EdgeInsets.only(top: mq.height*0.32,left: mq.width*0.06),
                       child: SizedBox(
                        height: 53,
                        width: 360,
                         child: Custombutton(
                          text: Text("Get Started",
                          style: TextStyle(
                            fontSize: 20,
                            color: primary.c
                          ),),
                         onpress: () {
                           HelperFunctions.navigateToScreenPush(context, LoginAndSigning());
                         }
                       ),
                     ),
                     ),
                  ],
                ),
                )
                ),
          ],
        ),
      ),
    );
  }
}