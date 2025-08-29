import 'package:dome_care/core/di/dependency_injection.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';
import 'package:dome_care/features/appointments/domain/entites/doctor_entity.dart';
import 'package:dome_care/features/appointments/presentation/views/appointment_booking_confirmation_view.dart';
import 'package:dome_care/features/appointments/presentation/views/appointment_booking_view.dart';
import 'package:dome_care/features/appointments/presentation/views/appointment_details_view.dart';
import 'package:dome_care/features/appointments/presentation/views/appointments_calendar_view.dart';
import 'package:dome_care/features/appointments/presentation/views/doctors_search_view.dart';
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
      case Routes.appointmentDetails:
        final appt = settings.arguments as AppointmentEntity;
        return MaterialPageRoute(
          builder: (_) => AppointmentDetailsView(appointment: appt),
        );
      case Routes.appointmentBooking:
        final doctor = settings.arguments as DoctorEntity;
        return MaterialPageRoute(
          builder: (_) => AppointmentBookingView(doctor: doctor),
        );
      case Routes.appointmentBookingConfirmation:
        final appt = settings.arguments as AppointmentEntity;
        return MaterialPageRoute(
          builder: (_) => AppointmentBookingConfirmationView(appointment: appt),
        );

      case Routes.doctorsSearch:
        return MaterialPageRoute(builder: (_) => const DoctorsSearchView());
      case Routes.appointmentsCalendar:
        return MaterialPageRoute(builder: (_) => AppointmentsCalendarView());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      default:
        return null;
    }
  }
}
