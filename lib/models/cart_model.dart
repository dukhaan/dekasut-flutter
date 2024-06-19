import 'package:dekasut/helpers/prefs_helper.dart';
import 'package:dekasut/models/cart_item_model.dart';
import 'package:dekasut/models/product_model.dart';

class CartModel {
  int? id;
  List<CartItemModel> products;

  CartModel({
    this.id,
    required this.products,
  });

  void addProduct(ProductModel product) {
    int existingIndex = products.indexWhere((p) => p.productId == product.id);

    if (existingIndex != -1) {
      products[existingIndex].quantity++;
    } else {
      products.add(CartItemModel(
        userId: PrefsHelper.instance.getCurrentUser()!.id,
        productId: product.id,
        quantity: 1,
      ));
    }
  }

  void removeProduct(ProductModel product) {
    int existingIndex = products.indexWhere((p) => p.productId == product.id);

    if (existingIndex != -1) {
      products[existingIndex].quantity--;
      if (products[existingIndex].quantity == 0) {
        products.removeAt(existingIndex);
      }
    }
  }

  double getTotalPrice() {
    double totalPrice = 0;
    if (products.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        totalPrice += products[i].productModel!.price * products[i].quantity;
      }
    }
    return totalPrice;
  }

  int getTotalQuantity() {
    int totalQuantity = 0;
    if (products.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        totalQuantity += products[i].quantity;
      }
    }
    return totalQuantity;
  }
}
