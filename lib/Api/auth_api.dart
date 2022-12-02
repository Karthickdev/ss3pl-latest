import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/Api/core/api_core.dart';
import 'package:southshore3pl/models/login_input.dart';
import 'package:southshore3pl/models/user_login.dart';
import 'package:southshore3pl/providers/user_provider.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';

mixin AuthApi on ApiCore {
  Future<UserLogin?> userLogin(LoginInput _input, BuildContext context) async {
    try {
      final uri = Uri.parse(apiLinks.login);
      var response = await apiClient.post(
        uri,
        body: _input.toJson(),
      );
      log('res:: ${response.body}');
      if (response.statusCode == 401) {
        context.read(userProvider).sessionLogout(context);
      }
      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar("SOMETHING WENT WRONG"));
      }
      return jsonDecode(response.body) == null ? null : UserLogin.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
