import 'package:dekasut/databases/cart_database.dart';
import 'package:dekasut/models/cart_model.dart';
import 'package:dekasut/models/product_model.dart';
import 'package:dekasut/theme.dart';
import 'package:dekasut/widgets/cart_card.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isLoading = true;
  late CartModel cart;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      debugPrint('testing ${ModalRoute.of(context)!.settings.arguments}');

      cart = await CartDatabase.instance.getCartByUser();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: _buildHeader(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              _isLoading
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: cart.products.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildContent(
                            context, cart.products[index].productModel!, cart);
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _isLoading
          ? const SizedBox.shrink()
          : _buildBottomNavigationBar(context),
    );
  }

  AppBar _buildHeader() {
    return AppBar(
      backgroundColor: backgroundColor1,
      centerTitle: true,
      iconTheme: IconThemeData(color: primaryTextColor),
      title: Text(
        'Your Cart',
        style: primaryTextStyle.copyWith(
          fontSize: 18,
          fontWeight: medium,
        ),
      ),
      elevation: 0,
    );
  }

  Widget emptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon_empty_cart.png',
            width: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Opss! Your Cart is Empty',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Let\'s find your favorite shoes',
            style: secondaryTextStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            color: backgroundColor1,
            width: 152,
            height: 44,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Explore Store',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ProductModel product,
    CartModel cart,
  ) {
    return CartCard(
        product: product,
        cart: cart,
        onUpdate: () async {
          await CartDatabase.instance.updateUserCart(cart);
          setState(() {});
        });
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
  ) {
    return Container(
      height: 165,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        // horizontal: defaultMargin,
        vertical: defaultMargin,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                //horizontal: defaultMargin,
                ),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
                    ),
                  ),
                  Text(
                    '\$${cart.getTotalPrice().toStringAsFixed(2)}',
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Divider(
            thickness: 0.3,
            color: subtitleColor,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/checkout',
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Continue to Checkout',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: primaryTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
