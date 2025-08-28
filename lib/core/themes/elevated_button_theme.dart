import 'package:dome_care/core/constants/constants.dart';
import 'package:flutter/material.dart';

ElevatedButtonThemeData elevatedButtonTheme() => ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, buttonHeight),
    maximumSize: const Size(double.infinity, buttonHeight),
  ),
);
