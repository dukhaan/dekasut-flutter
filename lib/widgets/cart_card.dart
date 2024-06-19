import 'package:dekasut/models/cart_model.dart';
import 'package:dekasut/models/product_model.dart';
import 'package:dekasut/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    super.key,
    required this.product,
    required this.cart,
    required this.onUpdate,
  });

  final ProductModel product;
  final CartModel cart;
  final VoidCallback onUpdate;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    int quantity = 0;
    for (var element in widget.cart.products) {
      if (element.productId == widget.product.id) {
        quantity = element.quantity;
      }
    }
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.product.galleries.first.url,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: priceTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.cart.addProduct(widget.product);
                        widget.onUpdate();
                      });
                    },
                    child: Image.asset(
                      'assets/button_add.png',
                      width: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    quantity.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.cart.removeProduct(widget.product);
                        widget.onUpdate();
                      });
                    },
                    child: Image.asset(
                      'assets/button_min.png',
                      width: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
          Row(
            children: [
              const Image(
                image: AssetImage('assets/icon_remove.png'),
                width: 10,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Remove',
                style: alertTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: light,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
