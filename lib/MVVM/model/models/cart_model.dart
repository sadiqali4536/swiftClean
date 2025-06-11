import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String? cartId;
  final String? userId;
  final String? serviceId;
  final String? serviceName;
  final double? discount;
  final double? price;
  final double? originalPrice;
  final String? imageUrl;
  final FieldValue? createAt;

  CartModel({
    this.cartId,
    this.userId,
    this.serviceId,
    this.serviceName,
    this.discount,
    this.price,
    this.originalPrice,
    this.imageUrl,
    this.createAt,
  });

  /// Factory method to create CartModel from Firestore map
  factory CartModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return CartModel(
      cartId: id,
      userId: map['userId'] as String?,
      serviceId: map['serviceId'] as String?,
      serviceName: map['serviceName'] as String?,
      discount: (map['discount'] as num?)?.toDouble(),
      price: (map['price'] as num?)?.toDouble(),
      originalPrice: (map['originalPrice'] as num?)?.toDouble(),
      imageUrl: map['imageUrl'] as String?,
      createAt: map['createAt'] as FieldValue?,
    );
  }

  /// Convert CartModel to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'discount': discount ?? 0.0,
      'price': price ?? 0.0,
      'originalPrice': originalPrice ?? 0.0,
      'imageUrl': imageUrl,
      'createAt': createAt ?? FieldValue.serverTimestamp(),
    };
  }
}
