import 'package:southshore3pl/res/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../res/res.dart';

class CustomTextFormField extends StatelessWidget {
  final String? errorText;
  final String? labelText;
  final double? contentPadding;
  final double? contentPaddingVertical;
  final String? hintText;
  final bool? hideInput;
  final TextEditingController? controller;
  final List<TextInputFormatter>? textInputFormatter;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final ValueChanged<String>? onChanged;
  final Widget? prefix;
  final Widget? suffix;
  final bool? isAutofocus;
  final double? borderRadius;
  final String? initialValue;
  final bool? filled;
  final bool? fillcolor;
  final bool? isReadOnly;
  final Function()? onTab;
  final Function(String value)? submitField;
  final int? maxCount;
  final int? minCount;
  final bool? isUpperCase;
  final TextInputType? inputType;
  final Widget? prefixText;
  final bool? isAliveBorder;
  final TextStyle? style;
  final bool? isBorder;
  final Color? focusColor;

  const CustomTextFormField(
      {Key? key,
      this.onChanged,
      this.contentPadding,
      this.fillcolor,
      this.filled,
      this.maxCount,
      this.prefixText,
      this.hideInput,
      this.isUpperCase,
      this.submitField,
      this.errorText,
      this.isAutofocus,
      this.labelText,
      this.hintText,
      this.controller,
      this.textInputFormatter,
      this.hintStyle,
      this.labelStyle,
      this.prefix,
      this.inputType,
      this.style,
      this.minCount,
      this.onTab,
      this.isReadOnly,
      this.borderRadius,
      this.initialValue,
      this.isAliveBorder,
      this.isBorder,
      this.contentPaddingVertical,
      this.suffix,
      this.focusColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      enableSuggestions: false,
      onFieldSubmitted: submitField,
      textInputAction: TextInputAction.go,
      autocorrect: false,
      autofocus: isAutofocus ?? false,
      minLines: 1,
      maxLines: hideInput ?? false ? 1 : 5,
      controller: controller,
      readOnly: isReadOnly ?? false,
      onTap: onTab,
      obscureText: hideInput ?? false,
      keyboardType: inputType,
      textCapitalization: isUpperCase ?? false
          ? TextCapitalization.characters
          : TextCapitalization.none,
      inputFormatters: textInputFormatter,
      initialValue: initialValue,
      maxLength: maxCount,
      onChanged: onChanged,
      decoration: isAliveBorder ?? true
          ? InputDecoration(
              fillColor: colors.kColorWhite,
              filled: true,
              contentPadding: contentPadding != null
                  ? EdgeInsets.symmetric(
                      horizontal: contentPadding!,
                      vertical: contentPaddingVertical ?? 0)
                  : null,
              border: isBorder ?? true
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 10),
                      borderSide: BorderSide(
                        color: colors.kColorgrey,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 4),
                      borderSide: BorderSide(
                        color: colors.kColorgrey,
                      ),
                    ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                borderSide: BorderSide(
                  color: focusColor ?? colors.kColorgrey,
                ),
              ),
              labelText: labelText,
              prefixIcon: prefix,
              suffixIcon: suffix,
              prefix: prefixText,
              counterText: '',
              isDense: true,
              hintText: hintText,
              errorText: errorText,
              labelStyle: labelStyle ?? textStyles.kTextSubtitle1,
              hintStyle: hintStyle ?? textStyles.kTextSubtitle1,
            )
          : InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.kColorBlack),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.kColorBlack),
              ),
            ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
