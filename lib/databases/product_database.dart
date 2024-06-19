import 'dart:convert';

import 'package:dekasut/databases/main_database.dart';
import 'package:dekasut/models/category_model.dart';
import 'package:dekasut/models/gallery_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dekasut/models/product_model.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._privateConstructor();
  static Database? _database;

  ProductDatabase._privateConstructor();

  Future<Database> get database async {
    _database = await MainDatabase.instance.database;
    return _database!;
  }

  Future<int> insertProduct(ProductModel product) async {
    Database db = await instance.database;
    return await db.insert('products', product.toJson());
  }

  Future<List<ProductModel>> getProducts() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: CategoryModel.fromJson(jsonDecode(maps[i]['category'])),
        galleries: maps[i]['galleries']
            .split(',')
            .map<GalleryModel>((gallery) => GalleryModel(id: i, url: gallery))
            .toList(),
      );
    });
  }

  Future<int> updateProduct(ProductModel product) async {
    Database db = await instance.database;
    return await db.update(
      'products',
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    Database db = await instance.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<ProductModel?> getProductById(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ProductModel.fromJson(maps.first);
    }
    return null;
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'category = ?',
      whereArgs: [category],
    );
    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: CategoryModel.fromJson(maps[i]['category']),
        galleries: (maps[i]['galleries'] as List<dynamic>)
            .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery))
            .toList(),
      );
    });
  }

  Future<List<ProductModel>> getProductsByName(String name) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );
    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: CategoryModel.fromJson(maps[i]['category']),
        galleries: (maps[i]['galleries'] as List<dynamic>)
            .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery))
            .toList(),
      );
    });
  }

  Future<void> insertDummyData() async {
    final db = await instance.database;
    final tables =
        await db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
    print('testing tables $tables');
    final list = await db.query('products');
    if (list.isNotEmpty) return;
    List<ProductModel> dummyProducts = [
      ProductModel(
        id: 1,
        name: 'TERREX URBAN LOW',
        price: 143.98,
        description: 'Description of Product 1',
        category: CategoryModel(id: 1, name: 'Hiking'),
        galleries: [
          GalleryModel(id: 1, url: 'assets/imageHome1.png'),
        ],
      ),
      ProductModel(
        id: 2,
        name: 'COURT VISION 2.0',
        price: 58.68,
        description: 'Description of Product 2',
        category: CategoryModel(id: 1, name: 'Hiking'),
        galleries: [
          GalleryModel(id: 2, url: 'assets/imageHome2.png'),
        ],
      ),
      ProductModel(
        id: 3,
        name: 'SL 72 SHOES',
        price: 115.19,
        description: 'Description of Product 3',
        category: CategoryModel(id: 2, name: 'Training'),
        galleries: [
          GalleryModel(id: 3, url: 'assets/imageHome3.png'),
        ],
      ),

      //NEW ARRIVAL
      ProductModel(
        id: 4,
        name: 'Predator 20.3 Firm Ground',
        price: 68.47,
        description: 'Description of Product 4',
        category: CategoryModel(id: 4, name: 'Running'),
        galleries: [
          GalleryModel(id: 4, url: 'assets/newArrival1.png'),
        ],
      ),
      ProductModel(
        id: 5,
        name: 'Ultra 4D 5 Shoes',
        price: 285.73,
        description: 'Description of Product 5',
        category: CategoryModel(id: 4, name: 'Running'),
        galleries: [
          GalleryModel(id: 5, url: 'assets/newArrival2.png'),
        ],
      ),
      ProductModel(
        id: 6,
        name: 'Court Vision 2.0 Shoes',
        price: 57.15,
        description: 'Description of Product 6',
        category: CategoryModel(id: 5, name: 'Basketball'),
        galleries: [
          GalleryModel(id: 6, url: 'assets/newArrival3.png'),
        ],
      ),
      ProductModel(
        id: 7,
        name: 'LEGO® SPORT SHOES',
        price: 92.72,
        description: 'Description of Product 7',
        category: CategoryModel(id: 2, name: 'Training'),
        galleries: [
          GalleryModel(id: 7, url: 'assets/newArrival4.png'),
        ],
      ),

      // Add more dummy products as needed
    ];

    for (ProductModel product in dummyProducts) {
      await insertProduct(product);
    }
  }

  Future<List<ProductModel>> getProductsFromDatabase() async {
    return await getProducts();
  }
}
