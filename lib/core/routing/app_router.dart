import 'package:dome_care/core/di/dependency_injection.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/features/appointments/presentation/views/my_appointments_view.dart';
import 'package:dome_care/features/login/presentation/cubit/login_cubit.dart';
import 'package:dome_care/features/login/presentation/views/login_view.dart';
import 'package:dome_care/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        );
      case Routes.myAppointments:
        return MaterialPageRoute(builder: (_) => MyAppointmentsView());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      default:
        return null;
    }
  }
}
