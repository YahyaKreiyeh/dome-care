import 'package:flutter/material.dart';
import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/themes/app_colors.dart';

PopupMenuThemeData popupMenuTheme() => PopupMenuThemeData(
  color: AppColors.greyShade300,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
);
