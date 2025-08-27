import 'package:flutter/material.dart';
import 'package:dome_care/core/themes/app_colors.dart';

TextTheme textTheme() => const TextTheme(
  displaySmall: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  ),
  headlineMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  ),
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  bodyLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
  labelLarge: TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.whiteText,
    fontSize: 14,
  ),
);
