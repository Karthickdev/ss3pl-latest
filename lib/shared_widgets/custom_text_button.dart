import 'package:southshore3pl/res/res.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final TextStyle textStyle;

  const CustomTextButton({
    Key? key,
   required this.text,
   required this.onPress,
   required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: textStyles.kTextTitle.copyWith(color: colors.greyAccent),
        ),
      ),
    );
  }
}
