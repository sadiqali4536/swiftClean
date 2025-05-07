import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/User_Front_page.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';

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
    await Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => const UserFrontPage(), transition: Transition.zoom);
    });
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
