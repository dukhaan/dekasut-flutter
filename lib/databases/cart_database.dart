import 'package:dekasut/databases/main_database.dart';
import 'package:dekasut/databases/product_database.dart';
import 'package:dekasut/models/cart_item_model.dart';
import 'package:dekasut/models/cart_model.dart';
import 'package:dekasut/helpers/prefs_helper.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._privateConstructor();
  static Database? _database;

  CartDatabase._privateConstructor();

  Future<Database> get database async {
    _database = await MainDatabase.instance.database;
    return _database!;
  }

  Future<CartModel> getCartByUser() async {
    Database db = await instance.database;
    final user = PrefsHelper.instance.getCurrentUser();
    List<Map<String, dynamic>> maps =
        await db.query('carts', where: 'userId = ?', whereArgs: [user!.id]);
    final list = <CartItemModel>[];

    for (final data in maps) {
      final product =
          await ProductDatabase.instance.getProductById(data['productId']);
      CartItemModel cartItem = CartItemModel(
        userId: user.id,
        productId: data['productId'],
        quantity: data['quantity'],
        productModel: product,
      );
      list.add(cartItem);
    }

    return CartModel(products: list);
  }

  Future<void> updateUserCart(CartModel cartModel) async {
    Database db = await instance.database;
    final user = PrefsHelper.instance.getCurrentUser();
    await db.delete('carts', where: 'userId = ?', whereArgs: [user!.id]);
    for (final data in cartModel.products) {
      await db.insert('carts', data.toMap());
    }
  }
}
