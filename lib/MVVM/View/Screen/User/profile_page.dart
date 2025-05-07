import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/changepassword.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/edit_profile.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/BottomNavigationbar/BottomNvigationBar.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';
import 'package:swiftclean_project/MVVM/utils/widget/containner/custom_image_banner2.dart';
import 'package:swiftclean_project/MVVM/utils/widget/containner/custom_image_banner.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkMode = false;
  bool _isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(206, 203, 212, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: customBackbutton1(
              onpress: () {
              Navigator.pop(context);
            }),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 60, left: 180),
            child: Text(
              "Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 110, left: 60),
                child: Text(
                  "User Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 105),
                  child: Image(
                    image: AssetImage("assets/icons/edit.png"),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 130, left: 60),
            child: Text(
              "Joined 23 Sep,2024",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 165),
            child: Container(
              width: 420,
              height: 700,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Color.fromARGB(255, 250, 249, 249),
              ),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40, left: 50),
                    child: CustomImageBanner(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40, left: 240),
                    child: CustomImageBanner2(),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 260),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 232, 232, 232),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              const Image(image: AssetImage("assets/icons/darkmod.png")),
                              const SizedBox(width: 10),
                              const Text("Dark Mode"),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CupertinoSwitch(
                                  value: _isDarkMode,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isDarkMode = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 130),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 232, 232, 232),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  SizedBox(width: 15),
                                  Icon(Icons.notifications),
                                  SizedBox(width: 10),
                                  Text("Notification"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CupertinoSwitch(
                                  value: _isNotificationOn,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isNotificationOn = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                 builder: (BuildContext context) {
                                 return Dialog(
                                 shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(20),
                               ),
                               child: SizedBox(
                                height: 276,
                                width: 347,
                                child: Column(
                                  children: [
                                    SizedBox(height: 40,),
                                    Container(
                                      child: Icon(Icons.question_mark,
                                      size: 35,
                                      color: Colors.white,),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: gradientgreen2.c
                                      ),
                                    ),
                                    SizedBox(height: 6,),
                                        Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                        "Are you sure to delete your account ?",
                                        style: TextStyle(
                                          fontSize:20,
                                          fontWeight: FontWeight.bold,
                                          color:Color.fromRGBO(125, 117, 128, 1)  
                                        ),
                                        textAlign: TextAlign.center,
                                        ),
                                     ),
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                         Container(
                                          width: 146,
                                          height: 56,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: const Color.fromARGB(255, 219, 219, 219)
                                          ),
                                           child: TextButton(
                                            onPressed: (){}, 
                                            child: Text("Yes",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color:Colors.black 
                                            ),)),
                                         ),
                                         Container(
                                          width: 146,
                                          height: 56,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: gradientgreen2.c
                                          ),
                                           child: TextButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            }, 
                                            child: Text("NO",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color:const Color.fromARGB(255, 255, 255, 255) 
                                            ),)),
                                         ),
                                       ],
                                     ),
                                  ],
                                ),
                               ),
                             );
                            },
                           );
                          },
                          child: Container(
                            height: 50,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color.fromARGB(255, 232, 232, 232),
                              ),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(width: 15),
                                Image(image: AssetImage("assets/icons/delete_user.png")),
                                SizedBox(width: 10),
                                Text("Delete Account"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                         );
                        },
                        child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 232, 232, 232),
                            ),
                          ),
                          child: const Row(
                            children: [
                              SizedBox(width: 15),
                              Image(image: AssetImage("assets/icons/lock.png")),
                              SizedBox(width: 10),
                              Text("Change Password"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
