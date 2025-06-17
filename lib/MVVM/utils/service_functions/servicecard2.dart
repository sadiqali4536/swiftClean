
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Exterior_Bookingpage.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Home_Booking_Page.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Interior_Booking_page.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/pet_Bookingpage.dart';
// import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/vehicle_booking_page.dart';
// import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';

// class Servicecard2 extends StatelessWidget {
//   final String category;
//   Servicecard2({super.key, required this.category});

//   // Format price for display
//   String formatPrice(dynamic price) {
//     if (price == null) return "0";
//     if (price is int) return price.toString();
//     if (price is double) return price.toInt().toString();
//     if (price is String) {
//       try {
//         final parsed = double.parse(price);
//         return parsed.toInt().toString();
//       } catch (_) {
//         return "0";
//       }
//     }
//     return "0";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final serviceStream = category == "All"
//         ? FirebaseFirestore.instance.collection('services').snapshots()
//         : FirebaseFirestore.instance
//             .collection('services')
//             .where('category', isEqualTo: category)
//             .snapshots();

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 238, 238, 238),
//       body: SafeArea(
//         child: StreamBuilder<QuerySnapshot>(
//           stream: serviceStream,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: gradientgreen1.c));
//             }
//             if (snapshot.hasError) {
//               return const Center(child: Text("Something went wrong"));
//             }

//             final services = snapshot.data!.docs;

//             return ListView.builder(
//               itemCount: services.length,
//               shrinkWrap: true,
//               itemBuilder: (_, index) {
//                 final item = services[index].data()! as Map<String, dynamic>;

//                 return GestureDetector(
//                   onTap: () {
//                     final category = item['category'];
//                     if (category == 'Exterior') {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => ExteriorBookingpage(
                        
//                       )));
//                     } else if (category == 'Interior') {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => InteriorBookingPage()));
//                     } else if (category == 'Vehicle') {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => VehicleBookingPage()));
//                     } else if (category == 'Pet') {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => PetCleaning()));
//                     } else if (category == 'Home') {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => HomeBookingPage()));
//                     }
//                   },
//                   child: Card(
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.asset(
//                               item['image'] ?? '',
//                               height: 120,
//                               width: 95.5,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) => Container(
//                                 height: 120,
//                                 width: 95.5,
//                                 color: const Color.fromARGB(255, 207, 207, 207),
//                                 child: const Icon(Icons.broken_image, size: 40),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item["service_name"] ?? '',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     RatingBarIndicator(
//                                       rating: (item["rating"] ?? 0).toDouble(),
//                                       itemBuilder: (_, index) => const Icon(
//                                         Icons.star,
//                                         color: gradientgreen2.c,
//                                       ),
//                                       itemCount: 5,
//                                       itemSize: 23.0,
//                                       direction: Axis.horizontal,
//                                     ),
//                                     const SizedBox(width: 6),
//                                     Text(
//                                       (item["rating"] ?? 0).toString(),
//                                       style: const TextStyle(color: gradientgreen2.c),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Wrap(
//                                   crossAxisAlignment: WrapCrossAlignment.center,
//                                   children: [
//                                     const Icon(Icons.arrow_downward, size: 15, color: gradientgreen2.c),
//                                     Text(
//                                       "${item["discount"] ?? 0}%",
//                                       style: const TextStyle(color: gradientgreen2.c, fontSize: 14),
//                                     ),
//                                     Text(
//                                       " ₹${formatPrice(item["original_price"])}",
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                         decoration: TextDecoration.lineThrough,
//                                       ),
//                                     ),
//                                     Text(
//                                       " ₹${formatPrice(item["price"])}",
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color.fromARGB(255, 10, 10, 10),
//                                       ),
//                                     ),
//                                     if (item["service_type"] == "Hour")
//                                       const Text(
//                                         "/hour",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                           color: Color.fromARGB(255, 6, 6, 6),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Exterior_Bookingpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Home_Booking_Page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Interior_Booking_page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/pet_Bookingpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/vehicle_booking_page.dart';

class Servicecard2 extends StatelessWidget {
  final String category;

  const Servicecard2({super.key, required this.category});

  String formatPrice(dynamic price) {
    try {
      return (double.tryParse(price.toString())?.toInt() ?? 0).toString();
    } catch (_) {
      return "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    final serviceStream = category == "All"
        ? FirebaseFirestore.instance.collection('services').snapshots()
        : FirebaseFirestore.instance
            .collection('services')
            .where('category', isEqualTo: category)
            .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: serviceStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        final services = snapshot.data?.docs ?? [];

        if (services.isEmpty) {
          return const Center(child: Text("No services found."));
        }

        return ListView.builder(
          itemCount: services.length,
          itemBuilder: (_, index) {
            final data = services[index].data();
            if (data == null || data is! Map<String, dynamic>) {
              return const SizedBox(); // Skip rendering if data is invalid
            }

            final item = data;

            if (!item.containsKey("service_name") || !item.containsKey("price")) {
              return const SizedBox(); // Skip incomplete service
            }

            return GestureDetector(
              onTap: () {
                switch (item['category']) {
                  case 'Exterior':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ExteriorBookingpage()));
                    break;
                  case 'Interior':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => InteriorBookingPage()));
                    break;
                  case 'Vehicle':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => VehicleBookingPage()));
                    break;
                  case 'Pet':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => PetCleaning()));
                    break;
                  case 'Home':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeBookingPage()));
                    break;
                }
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: item['image'] != null && item['image'].toString().startsWith('http')
                            ? Image.network(
                                item['image'],
                                height: 120,
                                width: 95.5,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 120,
                                width: 95.5,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 40),
                              ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["service_name"] ?? '',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: (item["rating"] ?? 0).toDouble(),
                                  itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.green),
                                  itemCount: 5,
                                  itemSize: 20,
                                  direction: Axis.horizontal,
                                ),
                                const SizedBox(width: 6),
                                Text("${item["rating"] ?? 0}"),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 6,
                              children: [
                                if (item["discount"] != null)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.arrow_downward, size: 15, color: Colors.green),
                                      Text("${item["discount"]}%", style: const TextStyle(color: Colors.green)),
                                    ],
                                  ),
                                if (item["original_price"] != null)
                                  Text(
                                    "₹${formatPrice(item["original_price"])}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                Text(
                                  "₹${formatPrice(item["price"])}",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                if (item["service_type"] == "Hour")
                                  const Text("/hour", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
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
    );
  }
}
