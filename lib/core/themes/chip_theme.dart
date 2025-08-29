import 'package:flutter/material.dart';

ChipThemeData customChipTheme() => ChipThemeData(
  labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: -2),
  padding: EdgeInsets.zero,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  side: WidgetStateBorderSide.resolveWith((states) {
    return BorderSide.none;
  }),
);
