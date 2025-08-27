import 'package:flutter/material.dart';
import 'package:dome_care/core/themes/app_bar_theme.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/bottom_sheet_theme.dart';
import 'package:dome_care/core/themes/card_theme.dart';
import 'package:dome_care/core/themes/chip_theme.dart';
import 'package:dome_care/core/themes/color_scheme.dart';
import 'package:dome_care/core/themes/dialog_theme.dart';
import 'package:dome_care/core/themes/elevated_button_theme.dart';
import 'package:dome_care/core/themes/input_decoration_theme.dart';
import 'package:dome_care/core/themes/page_transitions_theme.dart';
import 'package:dome_care/core/themes/popupmenu_theme.dart';
import 'package:dome_care/core/themes/text_theme.dart';

ThemeData getTheme() => ThemeData(
  canvasColor: AppColors.white,
  appBarTheme: appBarTheme(),
  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.primary,
  primaryColorLight: AppColors.primary.withAlpha((0.1 * 255).toInt()),
  colorScheme: colorScheme(),
  textTheme: textTheme(),
  chipTheme: customChipTheme(),
  elevatedButtonTheme: elevatedButtonTheme(),
  pageTransitionsTheme: pageTransitionsTheme(),
  cardTheme: cardTheme(),
  inputDecorationTheme: inputDecorationTheme(),
  bottomSheetTheme: bottomSheetTheme(),
  datePickerTheme: const DatePickerThemeData(backgroundColor: AppColors.white),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: inputDecorationTheme(),
  ),
  dialogTheme: dialogTheme(),
  popupMenuTheme: popupMenuTheme(),
);
