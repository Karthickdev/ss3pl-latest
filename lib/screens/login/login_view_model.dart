import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/global/preferences.dart';
import 'package:southshore3pl/locator/locator.dart';
import 'package:southshore3pl/models/login_input.dart';
import 'package:southshore3pl/providers/core/default_change_notifier.dart';
import 'package:southshore3pl/providers/user_provider.dart';
import 'package:southshore3pl/router/route_names.dart';
import '../../shared_widgets/snack_bar.dart';

final loginViewProvider =
    ChangeNotifierProvider((ref) => LoginViewModel(ref.read));

class LoginViewModel extends DefaultChangeNotifier {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final pref = locator<Preferences>();
  bool hidePassword = true;
  String? usernameError;
  String? passwordError;
  final Reader ref;
  LoginViewModel(this.ref);

  void clearError() {
    usernameError = null;
    passwordError = null;
    notifyListeners();
  }

  void clearController() {
    userNameController.text = "";
    passwordController.text = "";
    notifyListeners();
  }

  void toggleHidePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  bool validate() {
    if (userNameController.text.isEmpty) {
      usernameError = "Please enter user Id";
    }
    if (passwordController.text.isEmpty) {
      passwordError = "Please enter password";
    }
    return usernameError == null && passwordError == null;
  }

  Future submitLogin(BuildContext context) async {
    try {
      clearError();
      toggleLoadingOn(true);
      if (validate()) {
        final inputlogin = LoginInput(
            loginId: userNameController.text,
            password: passwordController.text);
        final res = await context
            .read(userProvider)
            .loginUser(context: context, input: inputlogin);
        if (res != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.mainmenuScreen, (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              errorSnackBar("User ID and/or password is incorrect"));
        }
      } else {}
    } catch (e) {
      log(e.toString());
    } finally {
      toggleLoadingOn(false);
    }
  }
}
