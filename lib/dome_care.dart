import 'package:dome_care/core/routing/app_router.dart';
import 'package:dome_care/core/themes/theme.dart';
import 'package:dome_care/features/snackbar/views/snackbar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class DomeCare extends StatelessWidget {
  const DomeCare({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Dome Care',
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: initialRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: (context, child) =>
          SnackbarView(child: child ?? const SizedBox.shrink()),
    );
  }
}
