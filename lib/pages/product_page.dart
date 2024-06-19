import 'package:carousel_slider/carousel_slider.dart';
import 'package:dekasut/databases/cart_database.dart';
import 'package:dekasut/models/product_model.dart';
import 'package:dekasut/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List images = [
    'assets/detailShoes1.png',
    'assets/detailShoes2.png',
    'assets/detailShoes3.png'
  ];

  List familiarShoes = [
    'assets/famShoes1.png',
    'assets/famShoes2.png',
    'assets/famShoes3.png',
    'assets/famShoes4.png',
    'assets/famShoes5.png',
    'assets/famShoes6.png',
    'assets/famShoes7.png',
  ];
  int currentIndex = 0;
  bool isWishlist = false;

  Future<void> showSuccesDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width - (2 * defaultMargin),
        child: AlertDialog(
          backgroundColor: backgroundColor3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.close,
                      color: primaryTextColor,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/icon_success.png',
                  width: 100,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Hurray :',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Item added successfully',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 154,
                  height: 44,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/cart',
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'View My Cart',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor6,
      body: ListView(
        children: [
          _buildHeader(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.chevron_left,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/cart',
                  );
                },
                child: Icon(
                  Icons.shopping_bag,
                  color: backgroundColor1,
                ),
              ),
            ],
          ),
        ),
        CarouselSlider(
          items: images
              .map((image) => Image.asset(
                    image,
                    width: MediaQuery.of(context).size.width,
                    height: 310,
                    fit: BoxFit.cover,
                  ))
              .toList(),
          options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            int index = entry.key;
            return indicator(index);
          }).toList(),
        ),
      ],
    );
  }

  Widget indicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: currentIndex == index ? 16 : 4,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentIndex == index ? primaryColor : const Color(0xffC4C4C4),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    int index = -1;
    final ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 17),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        color: backgroundColor1,
      ),
      child: Column(
        // NOTE : HEADER
        children: [
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        product.category.name,
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isWishlist = !isWishlist;
                    });

                    if (isWishlist) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: secondaryColor,
                          content: const Text(
                            'Has been added to the Wishlist',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: alertColor,
                          content: const Text(
                            'Has been removed from the Wishlist',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                  child: Image.asset(
                    isWishlist
                        ? 'assets/button_wishlist_blue.png'
                        : 'assets/button_wishlist.png',
                    width: 46,
                  ),
                )
              ],
            ),
          ),

          //NOTE : PRICE
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            decoration: BoxDecoration(
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price start from',
                  style: primaryTextStyle,
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: priceTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ),

          //NOTE : DESCRIPTION
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: defaultMargin,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Unpaved trails and mixed surfaces are easy when you have the traction and support you need. Casual enough for the daily commute.',
                  style: subtitleTextStyle.copyWith(fontWeight: light),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),

          //NOTE : STAR RATING
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: defaultMargin,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rating Product Star',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    _buildRating(4),
                  ],
                ),
              ],
            ),
          ),

          //NOTE : FAMILIAR SHOES
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Text(
                    'Familiar Shoes',
                    style: primaryTextStyle.copyWith(fontWeight: medium),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: familiarShoes.map((image) {
                      index++;
                      return Container(
                          margin: EdgeInsets.only(
                            left: index == 0 ? defaultMargin : 0,
                          ),
                          child: familiarShoesCard(image));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          //NOTE : BUTTONS
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(defaultMargin),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail-chat',
                        arguments: product);
                  },
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      'assets/button_chat.png',
                    ))),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: TextButton(
                      onPressed: () async {
                        final cart =
                            await CartDatabase.instance.getCartByUser();
                        cart.addProduct(product);
                        await CartDatabase.instance.updateUserCart(cart);
                        showSuccesDialog();
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: primaryColor,
                      ),
                      child: Text(
                        'Add to Cart',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget familiarShoesCard(String imageUrl) {
    return Container(
      width: 54,
      height: 54,
      margin: const EdgeInsets.only(
        right: 16,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _buildRating(double rating) {
    int numberOfStars = 5;
    List<Widget> starWidgets = [];

    for (int i = 0; i < numberOfStars; i++) {
      IconData iconData = Icons.star_border;

      if (i < rating) {
        iconData = Icons.star;
      } else if (i == rating && rating % 1 != 0) {
        iconData = Icons.star_half;
      }

      starWidgets.add(Icon(
        iconData,
        color: Colors.yellow,
      ));
    }

    return Row(children: starWidgets);
  }
}
