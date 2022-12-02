import 'package:southshore3pl/res/app_sizes.dart';
import 'package:southshore3pl/res/assets.dart';
import 'package:southshore3pl/res/colors.dart';
import 'package:southshore3pl/res/text_styles.dart';
import 'package:flutter/material.dart';

late Assets assets;
late AppColors colors;
late AppSizes sizes;
late AppTextStyles textStyles;

initializeResources({required BuildContext context}) async {
  sizes = AppSizes()..initializeSize(context);
  colors = AppColors();
  assets = Assets();
  textStyles = AppTextStyles();
}
