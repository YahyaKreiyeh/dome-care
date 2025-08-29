import 'package:flutter/material.dart';

ChipThemeData customChipTheme() => ChipThemeData(
  padding: EdgeInsets.zero,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  side: WidgetStateBorderSide.resolveWith((states) {
    return BorderSide.none;
  }),
);
