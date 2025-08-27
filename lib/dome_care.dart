import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/routing/app_router.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/core/themes/theme.dart';
import 'package:dome_care/features/snackbar/views/snackbar_view.dart';
import 'package:flutter/material.dart';

class DomeCare extends StatelessWidget {
  const DomeCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: domeCare,
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: isLoggedInUser ? Routes.home : Routes.login,
      builder: (context, child) {
        return SnackbarView(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
