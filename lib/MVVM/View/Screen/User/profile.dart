import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/address_page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/edit_profile.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/loyalty_points.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/my_bookings.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/profile_page.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/main.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   String _formattedTime(DateTime time) {
    return DateFormat("hh:mm a").format(time);
  }

  String _getDateHeader(DateTime time) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (DateFormat('yyyy-MM-dd').format(time) == DateFormat('yyyy-MM-dd').format(now)) {
      return "Today";
    } else if (DateFormat('yyyy-MM-dd').format(time) == DateFormat('yyyy-MM-dd').format(yesterday)) {
      return "Yesterday";
    } else {
      return DateFormat("dd MMM yyyy").format(time);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body:Column(
        children: [
          Container(
            height: 240,
            width: 450,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Padding(
          padding: const EdgeInsets.only(
            top: 40,right: 270),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(35),
            child: SizedBox(
              height: 70,
              width: 70,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
               child: Icon(Icons.person,size: 60,
               color: gradientgreen2.c), 
              ),
            ),
          ),
         ),
         SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right:240),
            child: Text("User Name",
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 250),
            child: Text("23 sep,2024",
            style: TextStyle(
            fontSize: 15
            ),
            ),
          ),
           SizedBox(height: 15),
           Padding(
          padding: const EdgeInsets.only(right: 220),
          child: Text("0 Total Bookings",
          style: TextStyle(
            fontSize: 15
            ),
            ),
             ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(right: 320),
            child: Text('General',
            style: TextStyle(color: const Color.fromRGBO(133, 118, 138, 1)),),
          ),
          SizedBox(height:15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,MaterialPageRoute(
                  builder:(context)=>ProfilePage())
              );
            },
            child: Container(
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Icon(Icons.person),
                  SizedBox(width: 10,),
                  Text("Profile")
                ],
              ),
              height: 60,
              width: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.white
              ),
            ),
          ),
          SizedBox(height: 2,),
          GestureDetector(
             onTap: () {
              Navigator.push(
                context,MaterialPageRoute(
                  builder:(context)=>AddressPage()));
                  },
            child: Container(
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Icon(Icons.my_location),
                  SizedBox(width: 10,),
                  Text("My Address")
                ],
              ),
              height: 60,
              width: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white
              ),
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,MaterialPageRoute(
                  builder:(context)=>MyBookings())
              );
            },
            child: Container(
              child: Row(
                children: [
                  SizedBox(width: 20,),
                Image.asset("assets/icons/booking.png"),
                  SizedBox(width: 10,),
                  Text("My Bookings")
                ],
              ),
              height: 60,
              width: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 270),
            child: Text('Loyality Points',
            style: TextStyle(color: const Color.fromRGBO(133, 118, 138, 1)),),
          ),
          SizedBox(height:15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,MaterialPageRoute(
                  builder:(context)=>LoyaltyPoints()));
                },
            child: Container(
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 0, 0, 0)
                    ),
                    child: Icon(Icons.star,
                    color: Colors.white,)),
                  SizedBox(width: 10,),
                  Text("Loyality Points"),
                  SizedBox(width: 120,),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6,left: 6),
                      child: Text("0 Points",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      ),),
                    ),
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red
                    ),
                  )
                ],
              ),
              height: 60,
              width: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
            ),
          ),
         SizedBox(height: 20),
Padding(
  padding: const EdgeInsets.only(left: 10),
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
              height: 270,
              width: 347,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    height: 60,
                    width: 60,
                    child: Icon(Icons.question_mark,
                    size: 35,
                    color: Colors.white,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: gradientgreen2.c,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text("Are you sure want to logout",
                  style: TextStyle(
                    fontSize: 20 ,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(125, 117, 128, 1),
                  ),),
                  SizedBox(height: 30,),
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
            )
          );
        },
      );
    },
    child: Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 238, 238, 238),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/Logout_button.png",
            width: 24,
            height: 24,
          ),
          SizedBox(width: 8),
          Text("Logout"),
        ],
      ),
    ),
  ),
  )
   ],
   )
 );
}
}