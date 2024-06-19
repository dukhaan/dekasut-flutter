import 'dart:convert';

import 'package:dekasut/models/category_model.dart';

import 'gallery_model.dart';

class ProductModel {
  int id;
  String name;
  double price;
  String description;
  CategoryModel category;
  List<GalleryModel> galleries;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.galleries,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<GalleryModel> galleries = [];
    final values = json['galleries'].toString().split(',');
    int i = 1;
    for (var gallery in values) {
      galleries.add(GalleryModel(id: i, url: gallery));
      i++;
    }
    return ProductModel(
      id: json['id'] as int,
      name: json['name'],
      price: json['price'],
      description: json['description'],
      category: CategoryModel.fromJson(jsonDecode(json['category'])),
      galleries: galleries,
    );
  }

  Map<String, dynamic> toJson() {
    var gallery = '';
    int i = 0;
    for (final data in galleries) {
      gallery += data.url;
      if (i < galleries.length - 1) {
        gallery += ',';
      }
      i++;
    }
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': jsonEncode(category.toJson()),
      'galleries': gallery,
    };
  }
}
