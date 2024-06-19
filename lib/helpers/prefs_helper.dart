import 'dart:convert';

import 'package:dekasut/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static final PrefsHelper instance = PrefsHelper._privateConstructor();
  SharedPreferences? _prefs;

  PrefsHelper._privateConstructor();

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> setCurrentUser(UserModel? user) async {
    if (user == null) return;
    await _prefs?.setString('user', jsonEncode(user.toMap()));
  }

  UserModel? getCurrentUser() {
    String? user = _prefs?.getString('user');
    if (user != null) {
      return UserModel.fromJson(jsonDecode(user));
    }
    return null;
  }
}
