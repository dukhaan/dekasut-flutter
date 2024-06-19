import 'package:dekasut/databases/main_database.dart';
import 'package:dekasut/helpers/prefs_helper.dart';
import 'package:dekasut/pages/cart_page.dart';
import 'package:dekasut/pages/checkout_page.dart';
import 'package:dekasut/pages/detail_chat_page.dart';
import 'package:dekasut/pages/home/main_page.dart';
import 'package:dekasut/pages/product_page.dart';
import 'package:dekasut/pages/sign_in_page.dart';
import 'package:dekasut/pages/sign_up_page.dart';
import 'package:dekasut/pages/splash_page.dart';
import 'package:dekasut/pages/success_page.dart';
import 'package:dekasut/widgets/edit_profile_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainDatabase.instance.database;
  await PrefsHelper.instance.prefs;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SplashPage(),
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/home': (context) => const MainPage(),
        '/detail-chat': (context) => const DetailChatPage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/product': (context) => const ProductPage(),
        '/cart': (context) => const CartPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/success': (context) => const SuccessPage(),
      },
    );
  }
}
