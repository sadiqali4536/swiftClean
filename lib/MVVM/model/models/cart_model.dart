// MVVM/model/models/cart_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String service_id;
  final String service_name;
  final String image;
  final String original_price;
  final String price;
  final String discount;
  final int rating;
  final String category;
  final String service_type;
  final Timestamp addedAt; // Changed to Timestamp

  CartModel({
    required this.service_id,
    required this.service_name,
    required this.image,
    required this.original_price,
    required this.price,
    required this.discount,
    required this.rating,
    required this.category,
    required this.service_type,
    required this.addedAt,
  });

  // Factory constructor to create a CartModel from a Firestore document
  factory CartModel.fromFirestore(Map<String, dynamic> data) {
    return CartModel(
      service_id: data['service_id'] ?? '',
      service_name: data['service_name'] ?? '',
      image: data['image'] ?? '',
      original_price: data['original_price'] ?? '',
      price: data['price'] ?? '',
      discount: data['discount'] ?? '',
      rating: data['rating'] ?? 0,
      category: data['category'] ?? '',
      service_type: data['service_type'] ?? '',
      addedAt: data['addedAt'] as Timestamp? ?? Timestamp.now(), // Handle null
    );
  }

  // Convert CartModel to a JSON map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'service_id': service_id,
      'service_name': service_name,
      'image': image,
      'original_price': original_price,
      'price': price,
      'discount': discount,
      'rating': rating,
      'category': category,
      'service_type': service_type,
      'addedAt': addedAt,
    };
  }
}