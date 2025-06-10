// import 'package:flutter/material.dart';
// import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
// import 'package:swiftclean_project/MVVM/utils/service_functions/cartservicecard.dart';
// import 'package:swiftclean_project/MVVM/utils/widget/button/custombutton.dart';
// import 'package:swiftclean_project/MVVM/utils/widget/price_details_tab/price_details_cart.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
//       body: Stack(
//         children: [
       
//           SingleChildScrollView(
//           child: Column(
//           children: [
//             // Top AppBar Style Container
//             Container(
//               height: 80,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 102, 214, 10),
//                     Color.fromARGB(255, 113, 191, 4),
//                     Color.fromARGB(255, 26, 159, 6),
//                   ],
//                 ),
//               ),
//               padding: const EdgeInsets.only(top: 30),
//               child: const Center(
//                 child: Text(
//                   "My Cart",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
                    
//             // Cart Items
//             Cartservicecard(),
                    
//             // // Price Details Panel (conditionally shown)
           
//             ],
//           //   const SizedBox(height: 100), // For space below content
//                     ),
//         ),
//                      if (isExpanded) ...[
//           Container(
//             height: screenHeight,
//             width: screenWidth,
//             color: Colors.grey[200], // Background color
//           ),
          
//           // Price Details Panel (conditionally shown)
//           if (isExpanded)
//             Positioned(
//               top: screenHeight * 0.3, // Adjust vertical position
//               left: screenWidth * 0.02, // Adjust horizontal position
//               right: screenWidth * 0.02,
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.white,
//                 ),
//                 padding: EdgeInsets.all(screenWidth * 0.05),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Price Details",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
          
//                     // Price Row
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         Text(
//                           "Price (2 Bookings)",
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Color.fromRGBO(87, 86, 86, 1),
//                           ),
//                         ),
//                         Text(
//                           "₹1,799",
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Color.fromRGBO(87, 86, 86, 1),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
          
//                     // Discount Row
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         Text(
//                           "Discount",
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Color.fromRGBO(87, 86, 86, 1),
//                           ),
//                         ),
//                         Text(
//                           "-₹399",
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Color.fromRGBO(53, 120, 1, 1),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
          
//                     // Total
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Total Amount",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: const [
//                             Text(
//                               "₹1,799",
//                               style: TextStyle(
//                                 decoration: TextDecoration.lineThrough,
//                                 color: Color.fromRGBO(163, 161, 161, 1),
//                               ),
//                             ),
//                             Text(
//                               "₹1,400",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
          
//                     // Book Now Button
//                     Center(
//                       child: SizedBox(
//                         height: 40,
//                         width: 150,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ), backgroundColor: Colors.blue,
//                           ),
//                           onPressed: () {
//                             // Handle booking
//                           },
//                           child: const Text(
//                             "Book Now",
//                             style: TextStyle(color: Colors.white, fontSize: 14),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//                 ],
//       ]
//       ),

//       // Floating Expand/Collapse Button
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 80),
//         child: FloatingActionButton.small(
//           backgroundColor: gradientgreen2.c,
//           onPressed: () {
//             setState(() {
//               isExpanded = !isExpanded;
//             });
//           },
//           child: Icon(
//             isExpanded ? Icons.arrow_downward : Icons.arrow_upward,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/service_functions/cartservicecard.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double panelHeight = isExpanded ? 270 : 0;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      body: Stack(
        children: [
          // Main content scrollable area
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 280), 
            child: Column(
              children: [
                // Top AppBar Style Container
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 102, 214, 10),
                        Color.fromARGB(255, 113, 191, 4),
                        Color.fromARGB(255, 26, 159, 6),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 30),
                  child: const Center(
                    child: Text(
                      "My Cart",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Cart Items
                Cartservicecard(),
              ],
            ),
          ),

          // Floating expandable price details panel
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: panelHeight,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: isExpanded
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5,),
                              Center(
                                child: const Text(
                                  "Price Details",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Price (2 Bookings)", style: TextStyle(fontSize: 15)),
                                  Text("₹1,799", style: TextStyle(fontSize: 15)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Discount", style: TextStyle(fontSize: 15)),
                                  Text("-₹399", style: TextStyle(fontSize: 15, color: gradientgreen2.c)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total Amount",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      Text(
                                        "₹1,799",
                                        style: TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "₹1,400",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 150,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: gradientgreen2.c,
                                    ),
                                    onPressed: () {
                                      // Handle booking action
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Booking Confirmed!')),
                                      );
                                    },
                                    child: const Text("Book Now", style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      )
                      : const Center(
                          
                        ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Floating Expand Button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.small(
          backgroundColor: gradientgreen2.c,
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Icon(
            isExpanded ? Icons.arrow_downward : Icons.arrow_upward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
