import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/di/dependency_injection.dart';
import 'package:dome_care/core/helpers/shared_pref_helper.dart';
import 'package:dome_care/core/localization/codegen_loader.g.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/dome_care.dart';
import 'package:dome_care/features/snackbar/bloc/snackbar_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await setupGetIt();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  final token = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  final isOnboardingCompleted = await SharedPrefHelper.getBool(
    SharedPrefKeys.isOnboardingCompleted,
  );
  final startRoute = isOnboardingCompleted
      ? token.isNotEmpty
            ? Routes.appointmentsCalendar
            : Routes.login
      : Routes.onboarding;

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: BlocProvider(
        create: (_) => getIt<SnackbarBloc>(),
        child: DomeCare(initialRoute: startRoute),
      ),
    ),
  );

  WidgetsBinding.instance.addPostFrameCallback(
    (_) => FlutterNativeSplash.remove(),
  );
}
