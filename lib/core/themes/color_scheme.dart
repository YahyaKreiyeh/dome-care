import 'package:flutter/material.dart';
import 'package:dome_care/core/themes/app_colors.dart';

ColorScheme colorScheme() => const ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.white,
  secondary: AppColors.secondary,
  onSecondary: AppColors.white,
  error: AppColors.error,
  onError: AppColors.error,
  surface: AppColors.grey,
  onSurface: AppColors.greyShade800,
);
