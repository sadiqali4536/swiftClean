import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swiftclean_project/MVVM/View/Screen/Worker/Edit_address.dart';
import 'package:swiftclean_project/MVVM/View/Screen/Worker/check_out_page.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/widget/backbutton/custombackbutton.dart';
import 'package:swiftclean_project/main.dart';

class WorkerDashboard extends StatefulWidget {
  const WorkerDashboard({super.key});

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard> {
  File? _Image;
  final ImagePicker picker=ImagePicker();

  Future<void>pickimage(ImageSource Source)async{
    final PickedFile = await picker.pickImage(source: Source);

    if(PickedFile != null){
      setState(() {
        _Image=File(PickedFile.path);
      });
    }
  }

  void _showImagePicker(){
    showModalBottomSheet(
      context: context,
       builder: (BuildContext Context){
        return SafeArea(
          child:SizedBox(
            height: 170,
            child: Stack(
              children: [
                Positioned(
                  bottom: 110,
                  left: 10,
                  right: 10,
                  child:ListTile(
                    trailing: Icon(Icons.cancel),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
                 Positioned(
                  bottom: 80,
                  left: 10,
                  right: 10,
                  child:ListTile(
                    leading:  Icon(Icons.photo_library),
                    title: Text("Choose from Gallery"),
                    onTap: () {
                      Navigator.pop(context);
                      pickimage(ImageSource.gallery);
                    },
                  )),
                  Positioned(
                    bottom: 40,
                    left: 10,
                    right: 10,
                  child:ListTile(
                    leading:  Icon(Icons.camera_alt_outlined),
                    title: Text("Take a Photo"),
                    onTap: () {
                      Navigator.pop(context);
                      pickimage(ImageSource.camera);
                    },
                  )),
                  if(_Image !=  null)
                  Positioned(
                    bottom: 5,
                    left: 10,
                    right: 10,
                    child: ListTile(
                      leading: Icon(Icons.delete,
                      color: Colors.red),
                      title: Text("Remove Profile Picture"),
                      onTap: (){
                        setState(() {
                          _Image = null;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ) 
              ],
            ),
          ));
       });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 10),
            child: customBackbutton1(
              onpress: (){}
              ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80,left: 40),
            child: Container(
                height: 83,
                width: 83,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color:const Color.fromARGB(255, 111, 111, 111))),
                  child: GestureDetector(
                    onTap: _showImagePicker,
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.white,
                      backgroundImage: _Image != null? FileImage(_Image!):null,
                      child: _Image == null?
                      Icon(Icons.person,
                      size: 44,
                      color: Colors.black):null,
                    ),
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130,left: 100),
            child: GestureDetector(
              onTap: _showImagePicker,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color:const Color.fromARGB(255, 139, 139, 139),width: 1),
                ),
                child: Icon(Icons.camera_alt,
                color: Colors.black,
                size: 20,),
              ),
            ),
          ),
            
             Padding(
               padding: const EdgeInsets.only(top: 95,left: 140),
               child: Text("Hello Username",
               style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
               ),),
             ),
              Padding(
               padding: const EdgeInsets.only(top: 130,left: 150),
               child: Text("Welcome Back !",
               style: TextStyle(
                fontSize: 16,
                color: Colors.grey
               ),),
             ),
              Padding(
               padding: const EdgeInsets.only(top: 170,left: 40),
               child: Text("Grass Cutting",
               style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500
               ),),
             ),
             Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 220,left: 220),
                  child: Material(
                    elevation: 13,
                     shadowColor: Colors.black.withOpacity(0.4),
                    child: Container(
                      width: 149,
                      height: 136,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color.fromRGBO(223, 220, 220, 1)),
                        color: primary.c
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 66,left: 10),
                        child: Column(
                           children: [
                            Text("0",
                            style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text("Total Payment",
                            style: TextStyle(
                              color: formletters.c
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 220,left: 40),
                  child: Material(
                    elevation: 13,
                    shadowColor: Colors.black.withOpacity(0.4),
                    child: Container(
                      width: 149,
                      height: 136,
                      decoration: BoxDecoration(
                        color:primary.c,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color.fromRGBO(223, 220, 220, 1)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 66,left: 10),
                        child: Column(
                          children: [
                            Text("0",
                            style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text("Total Work",
                            style: TextStyle(
                              color: formletters.c
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 240,left: 100),
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(153, 255, 9, 0.25),
                          borderRadius: BorderRadius.circular(18)
                        ),
                        child: Image.asset("assets/icons/worker.png",
                        color: Color.fromRGBO(53, 120, 1, 1),),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(top: 240,left: 140),
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color:const Color.fromRGBO(153, 255, 9, 0.25),
                          borderRadius: BorderRadius.circular(18)
                        ),
                        child: Image.asset("assets/icons/money.png"),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 400,left: 25),
                  child: Material(
                    elevation: 12,
                    shadowColor: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                    height: 137,
                      width: 359,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color.fromRGBO(223, 220, 220, 1)),
                        color:primary.c
                      ),
                    child: Stack(
                      children: [
                        Positioned(
                        top: 10,
                        left: 320,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>EditAddress()));
                          },
                          child: Image.asset("assets/icons/edit.png"))),
                        Positioned(
                        top:  15,
                        left: 15,
                        child: Text("+91 18457892",
                        style: TextStyle(color: black.c,
                        fontSize: 17),)),
                        Positioned(
                          top: 45,
                          left: 15,
                          child:SizedBox(
                            width: mq.width*0.50,
                            child: Text("15/24, Rose Villa MG Road, Kochi - 682001 Kerala, India",
                            style: TextStyle(fontSize: 17),),
                          ))
                        ],
                    ),
                    ),
                  ),
                ),
              ],
             ),
             Padding(
               padding: const EdgeInsets.only(top: 570,left: 25),
               child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                 child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context)=>CheckOutPage()));
                  },
                   child: Container(
                    height: 53,
                    width: 359,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5,left: 16),
                          child: Image.asset("assets/icons/clock_payment.png",scale: 15,),
                        ),
                        SizedBox(width: 8,),
                        Text("Check out Work Payment",
                        style: TextStyle(fontSize: 14,),),
                        SizedBox(width: 95,),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(221, 227, 227, 227)),
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10)
                    ),
                   
                   ),
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 650,left: 25),
               child: Material(
                elevation: 13,
                shadowColor: Colors.black.withOpacity(0.4),
                 child: GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                       builder: (BuildContext context){
                        return Dialog(
                          shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            height: 270,
                            width: 374,
                            child: Stack(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 140),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      child: Icon(Icons.question_mark,
                                      size: 30,color: Colors.white,),
                                      decoration: BoxDecoration(
                                        color: gradientgreen2.c,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text("Are you sure to delete your account?",
                                  style: TextStyle(fontSize: 20,
                                  color: Color.fromRGBO(125, 117, 128, 1),
                                  fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 190,left: 15),
                                  child: Container(
                                    height: 56,
                                    width: 146,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                     color: const Color.fromARGB(255, 204, 206, 200)
                                    ),
                                    child: TextButton(
                                      onPressed: (){},
                                       child: Text("Yes",
                                       style: TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 20,color: const Color.fromARGB(255, 0, 0, 0)
                                       ),)),
                                  ),
                                ),
                                 Padding(
                                   padding: const EdgeInsets.only(top: 190,left: 170),
                                   child: Container(
                                    height: 56,
                                    width: 146,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                     color: gradientgreen2.c
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                       child: Text("No",
                                       style: TextStyle(
                                        fontSize: 20,color: const Color.fromRGBO(217, 217, 217, 1)
                                       ),)),
                                                                   ),
                                 ),
                              ],
                            ),
                          ),
                        );
                       });
                  },
                   child: Container( 
                    width: 359,
                     height: 53,
                     decoration: BoxDecoration(
                      color: primary.c,
                      border: Border.all(color: Color.fromRGBO(223, 220, 220, 1)),
                      borderRadius: BorderRadius.circular(15)
                     ), 
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset("assets/icons/delete_user.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Delete Account",
                          style: TextStyle(color: black.c),),
                        )
                      ],
                    ),
                   ),
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 750,left: 160),
               child: SizedBox(width: 100,
                 child: GestureDetector(
                  onTap: (){
                    showDialog(
                      context: context,
                       builder: (BuildContext context){
                        return Dialog(
                          shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            height: 270,
                            width: 374,
                            child: Stack(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 140),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      child: Icon(Icons.question_mark,
                                      size: 30,color: Colors.white,),
                                      decoration: BoxDecoration(
                                        color: gradientgreen2.c,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text("Are you sure want to logout",
                                  style: TextStyle(fontSize: 20,
                                  color: Color.fromRGBO(125, 117, 128, 1),
                                  fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 190,left: 15),
                                  child: Container(
                                    height: 56,
                                    width: 146,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                     color: const Color.fromARGB(255, 204, 206, 200)
                                    ),
                                    child: TextButton(
                                      onPressed: (){},
                                       child: Text("Yes",
                                       style: TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 20,color: const Color.fromARGB(255, 0, 0, 0)
                                       ),)),
                                  ),
                                ),
                                 Padding(
                                   padding: const EdgeInsets.only(top: 190,left: 170),
                                   child: Container(
                                    height: 56,
                                    width: 146,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                     color: gradientgreen2.c
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                       child: Text("No",
                                       style: TextStyle(
                                        fontSize: 20,color: const Color.fromRGBO(217, 217, 217, 1)
                                       ),)),
                                                                   ),
                                 ),
                              ],
                            ),
                          ),
                        );
                       });
                  },
                   child: Row(
                    children: [
                      Image.asset("assets/icons/Logout_button.png"),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Logout",
                        style: TextStyle(color: black.c),),
                      )
                      
                      
                    ],
                   ),
                 ),
               ),
             )
        ]
      ),
    );
  }
}