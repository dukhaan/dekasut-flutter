import 'package:dekasut/theme.dart';
import 'package:dekasut/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildEmptyWishList(context),
        // _buildWishList(),
      ],
    );
  }

  Widget _buildHeader() {
    return AppBar(
      backgroundColor: backgroundColor1,
      centerTitle: true,
      title: Container(
        margin: const EdgeInsets.only(
          top: 30,
          bottom: 30,
        ),
        child: Text(
          'Favorite Shoes',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildEmptyWishList(BuildContext context) {
    return Expanded(
      child: Container(
        color: backgroundColor3,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image_wishlist.png',
              width: 74,
            ),
            const SizedBox(
              height: 23,
            ),
            Text(
              'You don\'t have a dream shoes',
              style: primaryTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Let\'s find your favorite shoes',
              style: secondaryTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 44,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 24,
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Explore Store',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWishList() {
    return Expanded(
      child: Container(
        color: backgroundColor3,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: const [
            WishListCard(),
            WishListCard(),
            WishListCard(),
          ],
        ),
      ),
    );
  }
}
