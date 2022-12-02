import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/Api/core/api_exporter.dart';
import 'package:southshore3pl/global/preferences.dart';
import 'package:southshore3pl/locator/locator.dart';
import 'package:southshore3pl/models/login_input.dart';
import 'package:southshore3pl/models/user_login.dart';
import 'package:southshore3pl/providers/core/default_change_notifier.dart';

final userProvider = ChangeNotifierProvider((ref) => UserProvider());

class UserProvider extends DefaultChangeNotifier {
  final pref = locator<Preferences>();
  final api = locator<ApiExporter>();
  UserLogin? _userLoginData;

  UserLogin? get userLoginData => _userLoginData;

  bool isPasswordReset = false;
  bool? get getIsPasswordReset => isPasswordReset;

  void changePasswordResetOption({required bool value}) {
    isPasswordReset = value;
    notifyListeners();
  }

  Future<UserLogin?> loginUser(
      {required LoginInput input, required BuildContext context}) async {
    try {
            toggleLoadingOn(true);
      log(input.toJson().toString());
      _userLoginData = await api.userLogin(input, context);
      notifyListeners();
      return _userLoginData;
    } catch (e) {
      rethrow;
    }
  }

  Future sessionLogout(BuildContext context) async {
    try {
      log("Logout Device");
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        pref.clearLocalPref();
        Phoenix.rebirth(context);
      });
    } catch (e) {
      rethrow;
    }
  }
}
