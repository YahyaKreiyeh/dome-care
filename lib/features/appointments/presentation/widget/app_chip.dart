import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textStyle,
  });
  final String text;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: backgroundColor ?? AppColors.primaryLight,
      label: Text(
        text,
        style: textStyle ?? TextStyles.primary70013,
        overflow: TextOverflow.ellipsis,
      ),
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
    );
  }
}
