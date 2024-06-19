import 'package:dekasut/pages/home/home_page.dart';
import 'package:dekasut/pages/home/profile_page.dart';
import 'package:dekasut/pages/home/wishlist_page.dart';
import 'package:dekasut/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex == 0 ? backgroundColor1 : backgroundColor3,
      //floatingActionButton: _buildCartButton(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight + 29,
        child: _buildBottomNavigationBar(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildCartButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/cart');
      },
      backgroundColor: secondaryColor,
      child: Image.asset(
        'assets/icon_cart.png',
        width: 20,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      backgroundColor: backgroundColor4,
      indicatorColor: Colors.transparent,
      selectedIndex: currentIndex,
      onDestinationSelected: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      destinations: [
        NavigationDestination(
          icon: Icon(
            Icons.home,
            size: 28,
            color: currentIndex == 0 ? primaryColor : const Color(0xff808191),
          ),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.favorite,
            size: 28,
            color: currentIndex == 1 ? primaryColor : const Color(0xff808191),
          ),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person,
            size: 28,
            color: currentIndex == 2 ? primaryColor : const Color(0xff808191),
          ),
          label: '',
        ),
      ],
    );
  }

  Widget _buildBody() {
    switch (currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const WishListPage();
      case 2:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}
