import 'package:flutter/material.dart';
import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/themes/app_colors.dart';

CardThemeData cardTheme() => CardThemeData(
  elevation: 3,
  shadowColor: AppColors.cardShadow,
  color: AppColors.white,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
);
