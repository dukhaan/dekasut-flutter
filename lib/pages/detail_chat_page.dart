import 'package:dekasut/models/product_model.dart';
import 'package:dekasut/theme.dart';
import 'package:dekasut/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class DetailChatPage extends StatelessWidget {
  const DetailChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: _buildHeader(),
      bottomNavigationBar: _buildChatInput(product),
      body: _buildContent(product),
    );
  }

  AppBar _buildHeader() {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: backgroundColor1,
      iconTheme: IconThemeData(color: primaryTextColor),
      centerTitle: false,
      title: Row(
        children: [
          Image.asset(
            'assets/image_shop_logo_online.png',
            width: 50,
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shoe Store',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              Text(
                'Online',
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: light,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput(ProductModel product) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductPreview(product),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor4,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: TextFormField(
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: light,
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type Message...',
                        hintStyle: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: light,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                'assets/button_send.png',
                width: 45,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductPreview(ProductModel product) {
    return Container(
      width: 225,
      height: 74,
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor5,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              product.galleries.first.url,
              width: 74,
              height: 82,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: primaryTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: priceTextStyle.copyWith(fontWeight: medium),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/button_close.png',
            width: 22,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ProductModel product) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
      ),
      children: [
        ChatBubble(
          isSender: true,
          text: 'Hi, this item still available?',
          hasProduct: true,
          product: product,
        ),
        ChatBubble(
          isSender: false,
          text: 'Good night, this item is only available in size 42 and 43',
          hasProduct: false,
          product: product,
        ),
      ],
    );
  }
}
