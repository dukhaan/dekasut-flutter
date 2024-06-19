import 'package:dekasut/models/product_model.dart';

class CartItemModel {
  final int userId;
  final int productId;
  final ProductModel? productModel;
  int quantity;

  CartItemModel(
      {required this.userId,
      required this.productId,
      required this.quantity,
      this.productModel});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      userId: json['userId'],
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
