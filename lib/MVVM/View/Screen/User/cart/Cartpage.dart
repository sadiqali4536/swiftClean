// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
// import 'package:swiftclean_project/MVVM/utils/service_functions/cartservicecard.dart';
// import 'package:swiftclean_project/MVVM/model/models/cart_model.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({Key? key});

//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text("My Cart", style: TextStyle(color: Colors.white)),
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 102, 214, 10),
//                   Color.fromARGB(255, 113, 191, 4),
//                   Color.fromARGB(255, 26, 159, 6),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: const Center(
//           child: Text('Please log in to view your cart.'),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
//       body: Stack(
//         children: [
//           StreamBuilder(
//             //  **Important Change**:  Accessing cartItems subcollection
//             stream: FirebaseFirestore.instance
//                 .collection('carts')
//                 .doc(user.uid)
//                 .collection('cartItems').orderBy('addedAt', descending: true) 
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 if (kDebugMode) {
//                   print('Firestore Stream Error: ${snapshot.error}');
//                 }
//                 return Center(
//                     child: Text('Error loading cart: ${snapshot.error}'));
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return SingleChildScrollView(
//                   // padding: const EdgeInsets.only(bottom: 100),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 80,
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             bottomRight: Radius.circular(20),
//                           ),
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 102, 214, 10),
//                               Color.fromARGB(255, 113, 191, 4),
//                               Color.fromARGB(255, 26, 159, 6),
//                             ],
//                           ),
//                         ),
//                         padding: const EdgeInsets.only(top: 30),
//                         child: const Center(
//                           child: Text(
//                             "My Cart",
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 50),
//                       const Center(
//                         child: Text('Your cart is empty.'),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               // Process data from snapshot
//               final cartItems = snapshot.data!.docs.map((doc) {
//                 return CartModel.fromFirestore(
//                     doc.data() as Map<String, dynamic>);
//               }).toList();

//               return SingleChildScrollView(
//                 padding: const EdgeInsets.only(bottom: 280),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 80,
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(20),
//                           bottomRight: Radius.circular(20),
//                         ),
//                         gradient: LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 102, 214, 10),
//                             Color.fromARGB(255, 113, 191, 4),
//                             Color.fromARGB(255, 26, 159, 6),
//                           ],
//                         ),
//                       ),
//                       padding: const EdgeInsets.only(top: 30),
//                       child: const Center(
//                         child: Text(
//                           "My Cart",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: cartItems.length,
//                       itemBuilder: (context, index) {
//                         final cartItem = cartItems[index];
//                         return Cartservicecard(cartItem: cartItem);
//                       },
//                     ),
                    
//                   ],
//                 ),
//               );
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 700),
//                     curve: Curves.easeInOut,
//                     height: isExpanded ? 270 : 0,
//                     width: double.infinity,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 6,
//                           offset: const Offset(0, -2),
//                         ),
//                       ],
//                     ),
//                     child: isExpanded
//                         ? StreamBuilder<QuerySnapshot>(
//                             //  **Important Change**: Accessing cartItems subcollection
//                             stream: FirebaseFirestore.instance
//                                 .collection('carts')
//                                 .doc(user.uid)
//                                 .collection('cartItems') // Ensure this subcollection exists
//                                 .snapshots(),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               }
//                               if (snapshot.hasError) {
//                                 return Center(
//                                     child: Text('Error: ${snapshot.error}'));
//                               }
//                               if (!snapshot.hasData ||
//                                   snapshot.data!.docs.isEmpty) {
//                                 return const SizedBox
//                                     .shrink(); // Hide if no items
//                               }

//                               // Recalculate totals based on the latest snapshot
//                               double currentTotalPrice = 0;
//                               double currentTotalOriginalPrice = 0;
//                               int currentServiceCount =
//                                   snapshot.data!.docs.length;

//                               for (var doc in snapshot.data!.docs) {
//                                 final data = doc.data() as Map<String, dynamic>;
//                                 currentTotalPrice +=
//                                     double.tryParse(data["price"].toString()) ??
//                                         0;
//                                 currentTotalOriginalPrice +=
//                                     double.tryParse(
//                                             data['original_price'].toString()) ??
//                                         0;
//                               }
//                               double currentDiscount = currentTotalOriginalPrice - currentTotalPrice;

//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       const SizedBox(height: 5),
//                                       const Center(
//                                         child: Text(
//                                           "Price Details",
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 10),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                               "Price ($currentServiceCount Bookings)",
//                                               style:
//                                                   const TextStyle(fontSize: 15)),
//                                           Text(
//                                             "₹${currentTotalOriginalPrice.toStringAsFixed(0)}",
//                                             style: const TextStyle(fontSize: 15),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           const Text("Discount",
//                                               style: TextStyle(fontSize: 15)),
//                                           Text(
//                                             "-₹${currentDiscount.toStringAsFixed(0)}",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 color: gradientgreen2.c),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           const Text(
//                                             "Total Amount",
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             children: [
//                                               if (currentDiscount > 0)
//                                                 Text(
//                                                   "₹${currentTotalOriginalPrice.toStringAsFixed(0)}",
//                                                   style: const TextStyle(
//                                                     decoration:
//                                                         TextDecoration.lineThrough,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                               Text(
//                                                 "₹${currentTotalPrice.toStringAsFixed(0)}",
//                                                 style: const TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 10),
//                                       Center(
//                                         child: SizedBox(
//                                           height: 40,
//                                           width: 150,
//                                           child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                               backgroundColor: gradientgreen2.c,
//                                             ),
//                                             onPressed: () {
//                                               ScaffoldMessenger.of(context)
//                                                   .showSnackBar(
//                                                 const SnackBar(
//                                                     content: Text(
//                                                         'Booking Confirmed!')),
//                                               );
//                                               // TODO: Add actual booking logic here (e.g., move cart items to orders)
//                                             },
//                                             child: const Text("Book Now",
//                                                 style: TextStyle(
//                                                     color: Colors.white)),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           )
//                         : const SizedBox(),
//                   ),
//                   const SizedBox(height: 80),

                  
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//                     bottom: 15,
//                     right: 10,
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 80),
//                       child: FloatingActionButton.small(
//                         backgroundColor: gradientgreen2.c,
//                         onPressed: () {
//                           setState(() {
//                             isExpanded = !isExpanded;
//                           });
//                         },
//                         child: Icon(
//                           isExpanded
//                               ? Icons.keyboard_arrow_down
//                               : Icons.keyboard_arrow_up,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/utils/service_functions/cartservicecard.dart';
import 'package:swiftclean_project/MVVM/model/models/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("My Cart", style: TextStyle(color: Colors.white)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 102, 214, 10),
                  Color.fromARGB(255, 113, 191, 4),
                  Color.fromARGB(255, 26, 159, 6),
                ],
              ),
            ),
          ),
        ),
        body: const Center(
          child: Text('Please log in to view your cart.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('carts')
                .doc(user.uid)
                .collection('cartItems')
                .orderBy('addedAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                if (kDebugMode) {
                  print('Firestore Stream Error: ${snapshot.error}');
                }
                return Center(child: Text('Error loading cart: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 50),
                      const Center(child: Text('Your cart is empty.')),
                    ],
                  ),
                );
              }

              final cartItems = snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return CartModel.fromFirestore(data);
              }).toList();

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 280),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Cartservicecard(cartItem: cartItems[index]);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          _buildBottomPanel(user),
          _buildToggleButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
    );
  }

  Widget _buildBottomPanel(User user) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              height: isExpanded ? 270 : 0,
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
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('carts')
                          .doc(user.uid)
                          .collection('cartItems')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        double total = 0;
                        double original = 0;
                        int count = snapshot.data!.docs.length;

                        for (var doc in snapshot.data!.docs) {
                          final data = doc.data() as Map<String, dynamic>;
                          total += double.tryParse(data["price"]?.toString() ?? "0") ?? 0;
                          original += double.tryParse(data["original_price"]?.toString() ?? "0") ?? 0;
                        }

                        double discount = original - total;

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              const Center(
                                child: Text(
                                  "Price Details",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Price ($count Bookings)",
                                      style: const TextStyle(fontSize: 15)),
                                  Text("₹${original.toStringAsFixed(0)}",
                                      style: const TextStyle(fontSize: 15)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Discount", style: TextStyle(fontSize: 15)),
                                  Text("-₹${discount.toStringAsFixed(0)}",
                                      style: TextStyle(fontSize: 15, color: gradientgreen2.c)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total Amount",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (discount > 0)
                                        Text("₹${original.toStringAsFixed(0)}",
                                            style: const TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              color: Colors.grey,
                                            )),
                                      Text("₹${total.toStringAsFixed(0)}",
                                          style: const TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.bold)),
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
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Booking Confirmed!')),
                                      );
                                      // TODO: Implement actual booking logic
                                    },
                                    child: const Text("Book Now",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    return Positioned(
      bottom: 15,
      right: 10,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.small(
          backgroundColor: gradientgreen2.c,
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Icon(
            isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
