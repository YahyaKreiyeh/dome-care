import 'package:flutter/material.dart';
import 'package:dome_care/core/constants/constants.dart';

ElevatedButtonThemeData elevatedButtonTheme() => ElevatedButtonThemeData(
  style: ButtonStyle(
    maximumSize: WidgetStateProperty.all(
      const Size(double.infinity, buttonHeight),
    ),
    minimumSize: WidgetStateProperty.all(
      const Size(double.infinity, buttonHeight),
    ),
  ),
);
