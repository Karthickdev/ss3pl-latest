import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/screens/login/login_view_model.dart';
import 'package:southshore3pl/shared_widgets/custom_long_button.dart';
import 'package:southshore3pl/shared_widgets/custom_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/util/sizer.dart';
import '../../shared_widgets/snack_bar.dart';
import '../../shared_widgets/svg_icon_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final loginModel = watch(loginViewProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.kColorWhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(149.0),
          child: AppBar(
            backgroundColor: colors.kColorWhite,
            elevation: 0,
            centerTitle: true,
            flexibleSpace: Container(
              height: 260,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/homebg.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes.extraLargePadding),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes.extraLargePadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 450,
                              child: CustomTextFormField(
                                hintText: 'USERNAME',
                                textInputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-z A-Z0-9 @~!#%^&*()]"))
                                ],
                                maxCount: 24,
                                submitField: (_) {
                                  print('username');
                                },
                                isAutofocus: true,
                                hintStyle: textStyles.kTextTitle
                                    .copyWith(color: colors.kColorBlack),
                                controller: loginModel.userNameController,
                                errorText: loginModel.usernameError,
                                isUpperCase: false,
                              ),
                            ),
                            Sizer.half(),
                            SizedBox(
                              width: 450,
                              child: CustomTextFormField(
                                hintText: 'PASSWORD',
                                maxCount: 24,
                                isAutofocus: true,
                                textInputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z0-9 @~!#%^&*()]"))
                                ],
                                hintStyle: textStyles.kTextTitle
                                    .copyWith(color: colors.kColorBlack),
                                controller: loginModel.passwordController,
                                isUpperCase: false,
                                submitField: (_) {
                                  print('login');
                                },
                                hideInput: loginModel.hidePassword,
                                errorText: loginModel.passwordError,
                                suffix: SvgIconButton(
                                    onPress: () => context
                                        .read(loginViewProvider)
                                        .toggleHidePassword(),
                                    assetLink: loginModel.hidePassword
                                        ? assets.closeEye
                                        : assets.eyeOpen),
                              ),
                            ),
                            Sizer.half(),
                            SizedBox(
                              width: 450,
                              child: CustomLongButton(
                                  label: "LOGIN",
                                  textcolor: colors.kColorWhite,
                                  loading: loginModel.loading,
                                  color: colors.kColorgrey2,
                                  width: sizes.width,
                                  height: 46,
                                  onPress: () {
                                    if (loginModel
                                        .userNameController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(errorSnackBar(
                                              "Username cannot be empty"));
                                    }
                                    if (loginModel
                                        .passwordController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(errorSnackBar(
                                              "Password cannot be empty"));
                                    }
                                    if (loginModel.passwordController.text
                                            .isNotEmpty &&
                                        loginModel.userNameController.text
                                            .isNotEmpty) {
                                      context
                                          .read(loginViewProvider)
                                          .submitLogin(context);
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
