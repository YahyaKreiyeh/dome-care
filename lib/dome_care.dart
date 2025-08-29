import 'package:dome_care/core/routing/app_router.dart';
import 'package:dome_care/core/themes/theme.dart';
import 'package:dome_care/features/snackbar/views/snackbar_view.dart';
import 'package:flutter/material.dart';

class DomeCare extends StatelessWidget {
  const DomeCare({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dome Care',
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: initialRoute,
      builder: (context, child) =>
          SnackbarView(child: child ?? const SizedBox.shrink()),
    );
  }
}
