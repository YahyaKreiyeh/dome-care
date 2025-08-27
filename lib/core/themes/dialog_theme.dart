import 'package:flutter/material.dart';
import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';

DialogThemeData dialogTheme() => DialogThemeData(
  backgroundColor: AppColors.white,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
  titleTextStyle: TextStyles.primary60020,
  contentTextStyle: TextStyles.primaryText40015,
);
