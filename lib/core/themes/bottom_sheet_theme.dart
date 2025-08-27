import 'package:flutter/material.dart';
import 'package:dome_care/core/themes/app_colors.dart';

BottomSheetThemeData bottomSheetTheme() => const BottomSheetThemeData(
  backgroundColor: AppColors.white,
  dragHandleColor: AppColors.inputBorderGrey,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
);
