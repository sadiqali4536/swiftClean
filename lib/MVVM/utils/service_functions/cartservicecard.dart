import 'dart:developer'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Exterior_Bookingpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Home_Booking_Page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/Interior_Booking_page.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/pet_Bookingpage.dart';
import 'package:swiftclean_project/MVVM/View/Screen/User/Booking_page/vehicle_booking_page.dart';
import 'package:swiftclean_project/MVVM/utils/Constants/colors.dart';
import 'package:swiftclean_project/MVVM/model/models/cart_model.dart'; 

class Cartservicecard extends StatelessWidget {
  // Now, Cartservicecard requires a CartModel in its constructor
  final CartModel cartItem;
  // Optional: Add a callback for removing the item
  final VoidCallback? onRemove;

  const Cartservicecard({
    super.key,
    required this.cartItem,
    this.onRemove,
  });

  // This method is fine, helps with formatting price values
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

  // Add a function to handle item removal from Firestore
  Future<void> _removeItemFromCart(BuildContext context) async {
    try {
      
      if (onRemove != null) {
        onRemove!(); // Call the provided callback for removal
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Remove functionality not fully implemented here.')),
        );
      }
    } catch (e) {
      log("Error removing item: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // Cartservicecard no longer needs a StreamBuilder or ListView.builder
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to booking page based on item category
          final category = cartItem.category;
          if (category == 'Exterior') {
            Navigator.push(context, MaterialPageRoute(builder: (_) =>  ExteriorBookingpage()));
          } else if (category == 'Interior') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const InteriorBookingPage()));
          } else if (category == 'Vehicle') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const VehicleBookingPage()));
          } else if (category == 'Pet') {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PetCleaning()));
          } else if (category == "Home") {
            Navigator.push(context, MaterialPageRoute(builder: (_) =>  HomeBookingPage()));
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
                    cartItem.image, // Use cartItem.image
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
                        cartItem.service_name, // Use cartItem.service_name
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: cartItem.rating.toDouble(), // Use cartItem.rating
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
                            cartItem.rating.toString(), // Use cartItem.rating
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
                            "${cartItem.discount}%", // Use cartItem.discount
                            style: TextStyle(
                                color: gradientgreen2.c, fontSize: 14),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            "₹${formatPrice(cartItem.original_price)}", // Use cartItem.original_price
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            "₹${formatPrice(cartItem.price)}", // Use cartItem.price
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          if (cartItem.service_type == "Hour") ...[ // Use cartItem.service_type
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
                                _removeItemFromCart(context); // Call the remove function
                              },
                              child: Container(
                                height: 30,
                                color: primary.c,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // Center content
                                  children: [
                                    Image.asset("assets/icons/can.png", height: 20, width: 20), // Adjust size if needed
                                    const SizedBox(width: 10),
                                    const Text(
                                      "Remove",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: const Color.fromARGB(255, 200, 200, 200),
                            height: 32,
                            width: 1.5,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // TODO: Handle Book Now for this specific item (perhaps navigate to a booking details page)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Booking ${cartItem.service_name} now! (Individual item booking)')),
                                );
                              },
                              child: Container(
                                height: 30,
                                color: primary.c,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // Center content
                                  children: [
                                    Image.asset("assets/icons/booking.png", height: 20, width: 20), // Adjust size if needed
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
      ),
    );
  }
}