import 'package:southshore3pl/res/res.dart';
import 'package:flutter/material.dart';

class CustomLongButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final Color color;
  final Color textcolor;
  final bool loading;
  final double width;
  final double height;

  const CustomLongButton({
    Key? key,
   required this.loading,
   required this.color,
   required this.label,
   required this.onPress,
   required this.textcolor,
   required this.width,
   required this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // ignore: avoid_dynamic_calls
      onPressed: loading == true ? () {} : () => onPress(),
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: textcolor,
        //  textStyle: Color(textcolor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size(width, height),
      ),
      child: loading == true
          ? Center(
              child: CircularProgressIndicator(
                  backgroundColor: colors.kColorWhite))
          : Text(
              label,
              style: textStyles.kTextbuttonTitle,
            ),
    );
  }
}
