import 'package:dekasut/databases/cart_database.dart';
import 'package:dekasut/models/cart_model.dart';
import 'package:dekasut/pages/success_page.dart';
import 'package:dekasut/theme.dart';
import 'package:dekasut/widgets/checkout_card.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  CartModel? _cart;
  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _cart = await CartDatabase.instance.getCartByUser();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: _isLoading ? AppBar() : _buildHeader(),
      body: _isLoading
          ? const SizedBox.shrink()
          : _buildContent(
              context,
            ),
    );
  }

  AppBar _buildHeader() {
    return AppBar(
      backgroundColor: backgroundColor3,
      iconTheme: IconThemeData(color: primaryTextColor),
      centerTitle: true,
      title: Text('Checkout Details',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          )),
      elevation: 0,
    );
  }

  Widget _buildContent(
    BuildContext context,
  ) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
      ),
      children: [
        // NOTE: LIST ITEMS
        Container(
          margin: const EdgeInsets.only(
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'List Items',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cart!.products.length,
                itemBuilder: (context, index) => CheckoutCard(
                  product: _cart!.products[index].productModel!,
                  quantity: _cart!.products[index].quantity,
                ),
              ),
            ],
          ),
        ),

        // NOTE: ADDRESS DETAILS
        Container(
          margin: const EdgeInsets.only(
            top: 30,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Address Details',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/icon_store_location.png',
                        width: 40,
                      ),
                      Image.asset(
                        'assets/icon_line.png',
                        height: 30,
                      ),
                      Image.asset(
                        'assets/icon_your_address.png',
                        width: 40,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Store Location',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: light,
                        ),
                      ),
                      Text(
                        'Adidas Store',
                        style: primaryTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      SizedBox(
                        height: defaultMargin,
                      ),
                      Text(
                        'Your Address',
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: light,
                        ),
                      ),
                      Text(
                        'Kejawan Gebang',
                        style: primaryTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),

        // NOTE: PAYMENT SUMMARY
        Container(
          margin: const EdgeInsets.only(
            top: 30,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Summary',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Quantity',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: light,
                    ),
                  ),
                  Text(
                    '${_cart!.getTotalQuantity()} Items',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Price',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: light,
                    ),
                  ),
                  Text(
                    '\$${_cart!.getTotalPrice().toStringAsFixed(2)}',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: light,
                    ),
                  ),
                  Text(
                    'Free',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                thickness: 1,
                color: Color(0xff2E3141),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '\$${_cart!.getTotalPrice().toStringAsFixed(2)}',
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // NOTE: CHECKOUT BUTTON
        SizedBox(
          height: defaultMargin,
        ),
        Divider(
          thickness: 0.3,
          color: subtitleColor,
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SuccessPage(),
                ),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Checkout Now',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
