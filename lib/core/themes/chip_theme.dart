import 'package:flutter/material.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';

ChipThemeData customChipTheme() => ChipThemeData(
  showCheckmark: false,
  disabledColor: AppColors.scaffoldBackground,
  backgroundColor: AppColors.white,
  selectedColor: AppColors.secondary,
  surfaceTintColor: AppColors.secondary,
  secondarySelectedColor: AppColors.secondary,
  labelStyle: TextStyles.primaryText50017,
  secondaryLabelStyle: TextStyles.primary50017,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
    side: BorderSide.none,
  ),
  side: WidgetStateBorderSide.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return const BorderSide(color: AppColors.primary, width: 1.0);
    }
    return BorderSide.none;
  }),
);
