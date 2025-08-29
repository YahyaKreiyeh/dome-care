import 'package:dome_care/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ColorHelper {
  ColorHelper._();

  static (Color bg, Color fg) statusColors(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return (AppColors.lightGreen, AppColors.green);
      case 'pending':
        return (AppColors.lightOrange, AppColors.orange);
      case 'rejected':
        return (AppColors.lightRed, AppColors.red);
      default:
        return (AppColors.greyScaffoldBackground, AppColors.grey);
    }
  }
}
