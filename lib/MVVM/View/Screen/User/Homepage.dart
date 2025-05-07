
import 'package:animated_notch_bottom_bar/src/notch_bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Add_promotion.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/Founctions/helper_functions.dart';
import 'package:swiftclean_project/MVVM/utils/service_functions/ServiceCardwith%20map.dart';
import 'package:swiftclean_project/MVVM/utils/widget/button/Scrollable/scrollable_horizontal_buttons.dart';
import 'package:swiftclean_project/main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, NotchBottomBarController? controller});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = 0;
  int selectedIndex = 0;
  int listIndex = 0;

  final List<String> imageasset = [
    "assets/image/add_image.png",
    "assets/image/add_image.png",
    "assets/image/add_image.png",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 220), 
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: GestureDetector(
                    onTap: (){
                      HelperFunctions.navigateToScreenPush(context,AddPromotion());
                    },
                    child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CarouselSlider(
                        items: imageasset.map((imagePath) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(imagePath,),
                              ),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 500,
                          aspectRatio: 18 / 10,
                          viewportFraction: 1.15,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 1),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Most Popular Services",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "View All",
                          style: TextStyle(color: gradientgreen1.c),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 1),

               Padding(
                 padding: const EdgeInsets.only(left: 15),
                 child: ScrollableHorizontalButtons(
                  categories: [
                     "    All    ",
                     "Exterior",
                     "Interior",
                     "Vehicle ",
                     "     Pet    ",
                     "  Home  "
                  ],
                  onSelected: (index) {
                  },),
               ),
                SizedBox(width: 360,
                  child: ServiceCard()),

                const SizedBox(height: 20),
              ],
            ),
          ),

          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              gradient: const LinearGradient(
                colors: [
                  gradientgreen1.c,
                  gradientgreen3.c,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 30),
                  child: Text(
                    "Username",
                    style: TextStyle(color: Colors.white, fontSize: 22,
                          fontWeight: FontWeight.bold),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, left: 200),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: mq.height*0.060,left: mq.width*0.87),
            child: Container(
              height: 18,
              width: 18,
              child: Center(
                child: Text("2",
                style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold),),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
              ),
            ),
          ),
          const Padding(
                  padding: EdgeInsets.only(top: 50,left: 30),
                  child: Text(
                    "Good day for Cleaning",
                    style: TextStyle(color: Color.fromRGBO(211, 211, 211, 1), fontSize: 14),
                  ),
                ),

          Positioned(
            top: mq.height*0.17,
            left: 20,
            right: 70,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Image.asset("assets/icons/serch_icon.png",
                     color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),

        GestureDetector(
          onTap: () {

          },
          child: Padding(
            padding: EdgeInsets.only(top: mq.height*0.170,left: mq.width*0.850),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 55,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child:Image.asset("assets/icons/filtter_icon.png",scale: 1.3,)),
              ),
            ),
        ),
        ],
      ),
    );
  }
  }
