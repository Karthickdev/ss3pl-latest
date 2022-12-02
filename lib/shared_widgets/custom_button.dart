import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/util/sizer.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final Color color;
  final double width;
  final double height;
  final bool loading;
  final TextStyle textStyle;
  final Icon prefixIcon;

  const CustomButton({
    Key? key,
    required this.loading,
    required this.color,
    required this.label,
    required this.onPress,
    required this.prefixIcon,
    required this.textStyle,
    required this.height,
    required this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // ignore: avoid_dynamic_calls
      onPressed: loading == true ? () {} : () => onPress(),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        fixedSize: Size(width, height),
      ),
      child: loading == true
          ? Center(
              child: CircularProgressIndicator(
                  backgroundColor: colors.kColorWhite))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(visible: prefixIcon != null, child: prefixIcon),
                Visibility(
                    visible: prefixIcon != null, child: Sizer.halfHorizontal()),
                Text(
                  label,
                  style: textStyle,
                ),
              ],
            ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final Color color;
  final double width;
  final double height;
  final bool loading;
  final bool isSelected;

  const CustomOutlineButton({
    Key? key,
   required this.color,
   required this.height,
   required this.label,
   required this.onPress,
   required this.width,
   required this.loading,
   required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = BoxDecoration(
      color:  false ? color : Colors.transparent,
      // border: Border.all(
      //     color: isSelected ?? false ? color : colors.kColorBackground),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
    );
    final normalTextStyle = textStyles.kTextSubtitle2;
    final selectedTextStyle = textStyles.kTextSubtitle2
        .copyWith(color: Colors.white, fontWeight: FontWeight.w700);
    return InkWell(
      // ignore: avoid_dynamic_calls
      onTap: loading == true ? () {} : () => onPress(),
      child: Container(
        height: 48,
        decoration: decoration,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizes.mediumPadding),
          child: Center(
            child: Text(
              label,
              style:normalTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final Color? bordercolor;
  final Color color;
  final double? width;
  final double? height;
  final bool? loading;
  final TextStyle? textStyle;
  const CustomFlatButton(
      {Key? key,
      required this.color,
      this.height,
      required this.label,
      this.loading,
      this.bordercolor,
      required this.onPress,
      this.textStyle,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: TextButton(
          onPressed: loading == true ? () {} : () => onPress(),
          child: Text(
            label,
            style: textStyle ?? textStyles.kTextButton,
          )),
    );
  }
}
