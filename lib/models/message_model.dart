import 'package:dekasut/models/product_model.dart';

class MessageModel {
  String message;
  int userId;
  String userName;
  String userImage;
  bool isFromUser;
  ProductModel product;
  DateTime createdAt;
  DateTime updatedAt;

  MessageModel({
    required this.message,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.isFromUser,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      userId: json['user_id'],
      userName: json['user_name'],
      userImage: json['user_image'],
      isFromUser: json['is_from_user'],
      product: ProductModel.fromJson(json['product']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user_id': userId,
      'user_name': userName,
      'user_image': userImage,
      'is_from_user': isFromUser,
      'product': product.toJson(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
