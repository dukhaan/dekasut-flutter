import 'dart:async';

import 'package:dekasut/databases/cart_database.dart';
import 'package:dekasut/helpers/cart_helper.dart';
import 'package:dekasut/helpers/prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:dekasut/theme.dart';
import 'package:dekasut/databases/product_database.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    getInit();
  }

  Future<void> getInit() async {
    await ProductDatabase.instance.insertDummyData();

    Timer(
      const Duration(seconds: 3),
      () async {
        final user = PrefsHelper.instance.getCurrentUser();
        if (user != null) {
          CartHelper.cartModel = await CartDatabase.instance.getCartByUser();
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/sign-in');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image_splash.png'),
            ),
          ),
        ),
      ),
    );
  }
}
