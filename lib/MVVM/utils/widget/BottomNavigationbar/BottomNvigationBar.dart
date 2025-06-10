// import 'dart:developer';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Cartpage.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Chatpage.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Homepage.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Services_list.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/profile.dart';

// class Bottomnvigationbar extends StatefulWidget {
//   const Bottomnvigationbar({super.key});

//   @override
//   State<Bottomnvigationbar> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<Bottomnvigationbar> {
//   /// Controller to handle PageView and also handles initial page
//   final _pageController = PageController(initialPage: 0);

//   /// Controller to handle bottom nav bar and also handles initial page
//   final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

//   int maxCount = 5;

//   @override
//   void dispose() {
//     _pageController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     /// widget list
//     final List<Widget> bottomBarPages = [
//       Homepage(
//         controller: (_controller),
//       ),
    
//       ServicesList(),
//       CartPage(),
//       WhatsAppChatPage(),
//       Profile(),
//     ];
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
//       ),
//       extendBody: true,
//       bottomNavigationBar: (bottomBarPages.length <= maxCount)
//           ? AnimatedNotchBottomBar(
//               /// Provide NotchBottomBarController
//               notchBottomBarController: _controller,
//               color: const Color.fromARGB(255, 248, 248, 248),
//               showLabel: false,
//               maxLine: 1,
//               shadowElevation: 5,
//               kBottomRadius: 18.0,
//               notchGradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                   colors: [
//                     Color.fromRGBO(88, 142, 12, 1),
//                      Color.fromRGBO(53, 120, 1, 1),
//                   ]),

//               /// restart app if you change removeMargins
//               removeMargins: false,
//               bottomBarWidth: 432,
//               bottomBarHeight: 75,
//               showShadow: true,
//               durationInMilliSeconds: 300,
//               elevation: 5,
//               bottomBarItems: [
//                 const BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.home_filled,
//                     color: Color.fromRGBO(133, 130, 130, 1),
//                   ),
//                   activeItem: Icon(
//                     Icons.home_filled,
//                     color: Color.fromARGB(255, 255, 255, 255),
//                   ),
//                 ),
//                 BottomBarItem(
//                   inActiveItem: Image.asset("assets/icons/list_bottombar.png",
//                        color: Color.fromRGBO(133, 130, 130, 1)),
//                   activeItem: Image.asset("assets/icons/list_bottombar.png",
//                     color:Color.fromRGBO(255, 255, 255, 1),
//                   ),
//                 ),
//                  BottomBarItem(
//                   inActiveItem: Image.asset("assets/icons/cart_bottombar.png"),
//                   activeItem:  Image.asset("assets/icons/cart_bottombar.png",
//                        color: Colors.white,),
//                   ),

//                  BottomBarItem(
//                   inActiveItem:Image.asset("assets/icons/chat_bottomnavigationbar.png",
//                         color: Color.fromRGBO(133, 130, 130, 1),),
//                   activeItem: Image.asset("assets/icons/chat_bottomnavigationbar.png",
//                         color: Colors.white,),
//                   ),
//                  BottomBarItem(
//                   inActiveItem: Image.asset("assets/icons/profile_bottombar.png"),
//                   activeItem: Image.asset("assets/icons/profile_bottombar.png",
//                              color: Colors.white,),                 
//                 ),
//               ],
//               onTap: (index) {
//                 log('current selected index $index');
//                 _pageController.jumpToPage(index);
//               },
//               kIconSize: 24.0,
//             )
//           : null,
//     );
//   }
// }

import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Cartpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Chatpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Homepage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Services_list.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/profile.dart';

class Bottomnvigationbar extends StatefulWidget {
  const Bottomnvigationbar({super.key});

  @override
  State<Bottomnvigationbar> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<Bottomnvigationbar> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;
  late final List<Widget> _bottomBarPages;

  @override
  void initState() {
    super.initState();
    _bottomBarPages = [
      const Homepage(),
      const ServicesList(),
      const CartPage(),
      const ChatPage(),
      const Profile(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Preload bottom bar icons
    final iconPaths = [
      "assets/icons/list_bottombar.png",
      "assets/icons/cart_bottombar.png",
      "assets/icons/chat_bottomnavigationbar.png",
      "assets/icons/profile_bottombar.png",
    ];

    for (final path in iconPaths) {
      precacheImage(AssetImage(path), context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(_bottomBarPages.length, (index) => _bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (_bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: const Color.fromARGB(255, 248, 248, 248),
              showLabel: false,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 18.0,
              notchGradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(88, 142, 12, 1),
                  Color.fromRGBO(53, 120, 1, 1),
                ],
              ),
              removeMargins: false,
              bottomBarWidth: 432,
              bottomBarHeight: 75,
              showShadow: true,
              durationInMilliSeconds: 300,
              elevation: 5,
              kIconSize: 24.0,
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(Icons.home_filled, color: Color.fromRGBO(133, 130, 130, 1)),
                  activeItem: Icon(Icons.home_filled, color: Colors.white),
                ),
                BottomBarItem(
                  inActiveItem: Image.asset("assets/icons/list_bottombar.png",
                      color: const Color.fromRGBO(133, 130, 130, 1)),
                  activeItem: Image.asset("assets/icons/list_bottombar.png", color: Colors.white),
                ),
                BottomBarItem(
                  inActiveItem: Image.asset("assets/icons/cart_bottombar.png"),
                  activeItem: Image.asset("assets/icons/cart_bottombar.png", color: Colors.white),
                ),
                BottomBarItem(
                  inActiveItem: Image.asset("assets/icons/chat_bottomnavigationbar.png",
                      color: const Color.fromRGBO(133, 130, 130, 1)),
                  activeItem:
                      Image.asset("assets/icons/chat_bottomnavigationbar.png", color: Colors.white),
                ),
                BottomBarItem(
                  inActiveItem: Image.asset("assets/icons/profile_bottombar.png"),
                  activeItem:
                      Image.asset("assets/icons/profile_bottombar.png", color: Colors.white),
                ),
              ],
              onTap: (index) {
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}
