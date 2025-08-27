import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? initialValue;
  final int maxLines;
  final int? maxLength;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool isRequired;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool disabled;
  final bool filled;
  final bool showBorder;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final Function(PointerDownEvent)? onTapOutside;
  final List<TextInputFormatter>? inputFormatters;
  final BoxConstraints? prefixIconConstraints;
  final TextStyle? textStyle;

  const CustomTextField({
    this.initialValue,
    this.controller,
    this.onChanged,
    this.maxLines = 1,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isRequired = false,
    this.keyboardType,
    this.textInputAction,
    this.errorText,
    this.onEditingComplete,
    this.disabled = false,
    this.obscureText = false,
    this.filled = true,
    this.showBorder = true,
    super.key,
    this.labelText,
    this.onTapOutside,
    this.maxLength,
    this.inputFormatters,
    this.prefixIconConstraints,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (labelText != null && labelText != '')
        Column(
          children: [
            Text(labelText!, style: TextStyles.primaryText40015),
            const VerticalSpace(8),
          ],
        ),
      TextFormField(
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        onTapOutside: onTapOutside ?? (_) => FocusScope.of(context).unfocus(),
        style: textStyle,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onEditingComplete: onEditingComplete,
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        onChanged: onChanged,
        readOnly: disabled,
        canRequestFocus: !disabled,
        obscureText: obscureText,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          fillColor: disabled
              ? AppColors.neutral100.withAlpha((0.5 * 255).toInt())
              : AppColors.inputFillWhite,
          filled: filled,
          hintText: hintText,
          errorText: errorText,
          counterText: '',
          focusedBorder: showBorder ? null : InputBorder.none,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixIconConstraints,
        ),
      ),
    ],
  );
}
