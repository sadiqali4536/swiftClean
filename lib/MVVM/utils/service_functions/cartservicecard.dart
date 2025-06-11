import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Exterior_Bookingpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Home_Booking_Page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Interior_Booking_page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/pet_Bookingpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/vehicle_booking_page.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/image_strings.dart';

class Cartservicecard extends StatelessWidget {
  Cartservicecard({super.key});

  String formatPrice(dynamic price) {
    if (price == null) return "0";
    if (price is int) return price.toString();
    if (price is double) return price.toInt().toString();
    if (price is String) {
      try {
        final parsed = double.parse(price);
        return parsed.toInt().toString();
      } catch (_) {
        return "0";
      }
    }
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: gradientgreen1.c,
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          final services = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: services.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final item = services[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  final category = item["category"];
                  if (category == 'Exterior') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ExteriorBookingpage()));
                  } else if (category == 'Interior') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => InteriorBookingPage()));
                  } else if (category == 'Vehicle') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => VehicleBookingPage()));
                  } else if (category == 'Pet') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PetCleaning()));
                  } else if (category == "Home") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HomeBookingPage()));
                  }
                },
                child: Card(
                  color: primary.c,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item['image'] ?? '',
                            height: 120,
                            width: 95.5,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              height: 120,
                              width: 95.5,
                              color: primary.c,
                              child: const Icon(
                                Icons.broken_image,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["service_name"] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: (item["rating"] ?? 0).toDouble(),
                                    itemBuilder: (_, index) => const Icon(
                                      Icons.star,
                                      color: gradientgreen2.c,
                                    ),
                                    itemCount: 5,
                                    itemSize: 23.0,
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    (item["rating"] ?? 0).toString(),
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_downward,
                                    size: 15,
                                    color: gradientgreen2.c,
                                  ),
                                  Text(
                                    "${item["discount"] ?? 0}%",
                                    style: const TextStyle(
                                        color: gradientgreen2.c, fontSize: 14),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    "₹${formatPrice(item["original_price"])}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    "₹${formatPrice(item["price"])}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  if (item["service_type"] == "Hour") ...[
                                    const Text(
                                      "/hour",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]
                                ],
                              ),
                              const Divider(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        
                                      },
                                      child: Container(
                                        height: 30,
                                        color: primary.c,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Image.asset(
                                                  "assets/icons/can.png"),
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              "Remove",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 200, 200, 200),
                                    height: 32,
                                    width: 1.5,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Handle Book Now
                                      },
                                      child: Container(
                                        height: 30,
                                        color: primary.c,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Image.asset(
                                                  "assets/icons/booking.png"),
                                            ),
                                            const SizedBox(width: 10),
                                            const Text("Book now"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Exterior_Bookingpage.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Home_Booking_Page.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Interior_Booking_page.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/pet_Bookingpage.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/vehicle_booking_page.dart';
// import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';

// class Cartservicecard extends StatelessWidget {
//   Cartservicecard({super.key});

//   String formatPrice(dynamic price) {
//     if (price == null) return "0";
//     try {
//       return double.parse(price.toString()).toInt().toString();
//     } catch (_) {
//       return "0";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('cart').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: gradientgreen1.c,
//               ),
//             );
//           }
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text("Something went wrong"),
//             );
//           }

//           final services = snapshot.data?.docs ?? [];

//           return ListView.builder(
//             itemCount: services.length,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (_, index) {
//               final item = services[index].data() as Map<String, dynamic>;

//               return Card(
//                 color: primary.c,
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           item['imageUrl'] ?? '',
//                           height: 120,
//                           width: 95.5,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) => Container(
//                             height: 120,
//                             width: 95.5,
//                             color: primary.c,
//                             child: const Icon(Icons.broken_image, size: 40),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               item["serviceName"] ?? '',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             const SizedBox(height: 3),
//                             Row(
//                               children: [
//                                 RatingBarIndicator(
//                                   rating: (item["rating"] ?? 0).toDouble(),
//                                   itemBuilder: (_, index) => const Icon(
//                                     Icons.star,
//                                     color: gradientgreen2.c,
//                                   ),
//                                   itemCount: 5,
//                                   itemSize: 23.0,
//                                   direction: Axis.horizontal,
//                                 ),
//                                 const SizedBox(width: 3),
//                                 Text(
//                                   (item["rating"] ?? 0).toString(),
//                                   style: const TextStyle(color: Colors.green),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 const Icon(
//                                   Icons.arrow_downward,
//                                   size: 15,
//                                   color: gradientgreen2.c,
//                                 ),
//                                 Text(
//                                   "${item["discount"] ?? 0}%",
//                                   style: const TextStyle(
//                                       color: gradientgreen2.c, fontSize: 14),
//                                 ),
//                                 const SizedBox(width: 2),
//                                 Text(
//                                   "₹${formatPrice(item["originalPrice"])}",
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.grey,
//                                     decoration: TextDecoration.lineThrough,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 2),
//                                 Text(
//                                   "₹${formatPrice(item["price"])}",
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 if (item["service_type"] == "Hour") ...[
//                                   const Text(
//                                     "/hour",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ]
//                               ],
//                             ),
//                             const Divider(height: 20),
//                             Row(
//                               children: [
//                                 // Remove Button
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () async {
//                                       try {
//                                         await FirebaseFirestore.instance
//                                             .collection('cart')
//                                             .doc(services[index].id)
//                                             .delete();
//                                         ScaffoldMessenger.of(context).showSnackBar(
//                                           SnackBar(
//                                             content: Text(
//                                               "${item['serviceName']} removed",
//                                             ),
//                                           ),
//                                         );
//                                       } catch (e) {
//                                         log("Error removing item: $e");
//                                       }
//                                     },
//                                     child: Container(
//                                       height: 30,
//                                       color: primary.c,
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 10),
//                                             child: Image.asset(
//                                                 "assets/icons/can.png"),
//                                           ),
//                                           const SizedBox(width: 10),
//                                           const Text(
//                                             "Remove",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 // Divider
//                                 Container(
//                                   color:
//                                       const Color.fromARGB(255, 200, 200, 200),
//                                   height: 32,
//                                   width: 1.5,
//                                 ),
//                                 // Book Now Button
//                                 Expanded(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       final category = item["category"];
//                                       if (category == 'Exterior') {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (_) => ExteriorBookingpage(),
//                                           ),
//                                         );
//                                       } else if (category == 'Interior') {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (_) => InteriorBookingPage(),
//                                           ),
//                                         );
//                                       } else if (category == 'Vehicle') {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (_) => VehicleBookingPage(),
//                                           ),
//                                         );
//                                       } else if (category == 'Pet') {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (_) => PetCleaning(),
//                                           ),
//                                         );
//                                       } else if (category == "Home") {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (_) => HomeBookingPage(),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                     child: Container(
//                                       height: 30,
//                                       color: primary.c,
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 10),
//                                             child: Image.asset(
//                                                 "assets/icons/booking.png"),
//                                           ),
//                                           const SizedBox(width: 10),
//                                           const Text("Book now"),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


