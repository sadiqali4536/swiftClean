import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiftclean_project/MVVM/View/Authentication/LoginandSigning.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/User_Front_page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/Worker/Worker_Dashboard.dart';
import 'package:swiftclean_project/MVVM/model/services/firebaseauthservices.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/Founctions/helper_functions.dart';
import 'package:swiftclean_project/MVVM/utils/widget/BottomNavigationbar/BottomNvigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initTo();
  }



  void initTo() async {
  await Future.delayed(const Duration(seconds: 2));

  final auth = FirebaseAuth.instance.currentUser;

  if (auth == null) {
    Get.off(() => LoginAndSigning(), transition: Transition.zoom);
    return;
  }

  final role = await getRole(auth.uid); // ⬅️ Await the role here

  if (role == 'user') {
    Get.off(() => Bottomnvigationbar(), transition: Transition.zoom);
  } else if (role == 'worker') {
    final isVerifiedSnapshot = await FirebaseFirestore.instance
        .collection('workers')
        .doc(auth.uid)
        .get();

    final isVerified = isVerifiedSnapshot.data()?['isVerified'] == 1;

    if (isVerified) {
      Get.offAll(() => WorkerDashboard());
    } else {
      Get.off(() => LoginAndSigning(), transition: Transition.zoom);
    }
  } else {
    Get.off(() => LoginAndSigning(), transition: Transition.zoom);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary.c,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Image.asset("assets/icons/logo.png"),
        ),
      ),
    );
  }
}
