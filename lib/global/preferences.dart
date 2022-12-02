import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _prefInstance;

  Future<void> init() async {
    _prefInstance = await SharedPreferences.getInstance();
  }

  Future clearLocalPref() async {
    await _prefInstance?.clear();
  }

  // ignore: non_constant_identifier_names
  Future setLoginId(String LoginId) async =>
      _prefInstance?.setString(_LoginIdKey, LoginId);
}

// ignore: constant_identifier_names
const String _LoginIdKey = "LoginIdKey";
