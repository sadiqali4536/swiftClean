import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftclean_project/MVVM/model/models/cart_model.dart';
// import 'package:flutter/foundation.dart'; // You might need this if you use kDebugMode

/// A utility class for cart operations.
class CartService {
  /// Adds a service to the user's cart in Firestore.
  ///
  /// Requires [context] to show SnackBars and access widget properties
  /// via passed parameters.
  static Future<void> addToCart({
    required BuildContext context,
    required String? serviceName,
    required String? image,
    required String? originalPrice,
    required String? discountPrice,
    required String? discount,
    required int? rating,
    required String? category,
    required String? serviceType,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // It's generally safe to show a SnackBar here immediately because
      // the condition is checked synchronously.
      // No need for `!mounted` here because context is directly passed
      // and we are not in a State object.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to add items to cart.')),
      );
      return;
    }

    try {
      final uid = user.uid;
      final userCartCollectionRef = FirebaseFirestore.instance
          .collection('carts')
          .doc(uid)
          .collection('cartItems'); // Ensure 'cartItems' is the correct subcollection name

         

      final String serviceId = userCartCollectionRef.doc().id;

      final cartItem = CartModel(
        service_id: serviceId,
        service_name: serviceName ?? '',
        image: image ?? '',
        original_price: originalPrice ?? '',
        price: discountPrice ?? '',
        discount: discount ?? '',
        rating: rating ?? 0,
        category: category ?? '',
        service_type: serviceType ?? '',
        addedAt: Timestamp.now(),
      ).toJson();

      await userCartCollectionRef.doc(serviceId).set(cartItem);

      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart successfully!')),
      );
    } catch (e) {
      // if (kDebugMode) { // Uncomment if you import 'package:flutter/foundation.dart';
      //   print('🔥 Add to cart failed: $e');
      // }
      debugPrint('🔥 Add to cart failed: $e'); // Use debugPrint for better logging in Flutter

      // Similar consideration for context validity as above.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: ${e.toString()}')),
      );
    }
  }
}