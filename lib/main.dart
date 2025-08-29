import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/di/dependency_injection.dart';
import 'package:dome_care/core/helpers/shared_pref_helper.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/dome_care.dart';
import 'package:dome_care/features/snackbar/bloc/snackbar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await setupGetIt();
  final token = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  final startRoute = token.isNotEmpty
      ? Routes.appointmentsCalendar
      : Routes.login;

  runApp(
    BlocProvider(
      create: (_) => getIt<SnackbarBloc>(),
      child: DomeCare(initialRoute: startRoute),
    ),
  );

  WidgetsBinding.instance.addPostFrameCallback(
    (_) => FlutterNativeSplash.remove(),
  );
}
