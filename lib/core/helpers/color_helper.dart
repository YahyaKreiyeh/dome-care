import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ColorHelper {
  ColorHelper._();

  static (Color bg, Color fg) statusColors(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return (AppColors.lightGreen, AppColors.green);
      case AppointmentStatus.pending:
        return (AppColors.lightOrange, AppColors.orange);
      case AppointmentStatus.rejected:
        return (AppColors.lightRed, AppColors.red);
      case AppointmentStatus.canceled:
        return (AppColors.lightRed, AppColors.red);
    }
  }

  static Color avatarColor(String imagePath) {
    if (imagePath == Assets.images.avatar1.path) {
      return AppColors.avatar1;
    } else if (imagePath == Assets.images.avatar2.path) {
      return AppColors.avatar2;
    } else if (imagePath == Assets.images.avatar3.path) {
      return AppColors.avatar3;
    }
    return AppColors.primary;
  }
}
