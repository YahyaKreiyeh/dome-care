import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

AppBarTheme appBarTheme() => AppBarTheme(
  elevation: 5,
  backgroundColor: AppColors.white,
  surfaceTintColor: AppColors.appBarBackground,
  foregroundColor: AppColors.appBarForeground,
  titleTextStyle: TextStyles.primaryText70016,
);
