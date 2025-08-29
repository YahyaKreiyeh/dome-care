import 'package:dome_care/core/constants/enums.dart';
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
}
