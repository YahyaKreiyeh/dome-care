import 'package:flutter/material.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';

AppBarTheme appBarTheme() => AppBarTheme(
  backgroundColor: AppColors.white,
  surfaceTintColor: AppColors.appBarBackground,
  foregroundColor: AppColors.appBarForeground,
  titleTextStyle: TextStyles.primaryText60022,
);
