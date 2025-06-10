// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:swift_clean/MVVM/View/Screen/User/LoginandSigning.dart';
// import 'package:swift_clean/MVVM/View/Screen/User/SplashScreen.dart';

// class Authgate extends StatelessWidget {
//   const Authgate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(), 
//       builder: (context, Snapshot) { 
//         if (Snapshot.hasData){
//           return SplashScreen();
//         }else{
//           return LoginAndSigning();
//         }
//        },

//     );
//   }
// }