import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Exterior_Bookingpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Home_Booking_Page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Homepage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Interior_Booking_page.dart';
import 'package:swiftclean_project/MVVM/View/Authentication/SplashScreen.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/pet_cleaning.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/vehicle_booking_page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/Worker/Worker_Dashboard.dart';
import 'package:swiftclean_project/MVVM/utils/widget/BottomNavigationbar/BottomNvigationBar.dart';

late Size mq;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swift Clean',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: 
     // SplashScreen(),
        // Bottomnvigationbar(),
      // ExteriorBookingpage(),
      // InteriorBookingPage(),
      //VehicleBookingPage(),
     //WorkerDashboard(),
     //PetCleaning()
     HomeBookingPage()
    );
  }
}

