import 'package:dome_care/core/di/dependency_injection.dart';
import 'package:dome_care/dome_care.dart';
import 'package:dome_care/features/snackbar/bloc/snackbar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();

  runApp(
    BlocProvider(
      create: (context) => getIt<SnackbarBloc>(),
      child: const DomeCare(),
    ),
  );
}
