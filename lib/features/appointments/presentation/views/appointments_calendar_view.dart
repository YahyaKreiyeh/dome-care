import 'package:dio/dio.dart';
import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:dome_care/core/helpers/formatters.dart';
import 'package:dome_care/core/helpers/shared_pref_helper.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/localization/locale_keys.g.dart';
import 'package:dome_care/core/networking/dio_factory.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/core/routing/routes_extension.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/core/widgets/buttons/primary_button.dart';
import 'package:dome_care/features/appointments/data/datasources/mock_appointment_data_source.dart';
import 'package:dome_care/features/appointments/data/datasources/mock_appointment_data_source_ar.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';
import 'package:dome_care/features/appointments/presentation/widget/app_calendar.dart';
import 'package:dome_care/features/appointments/presentation/widget/app_chip.dart';
import 'package:dome_care/features/snackbar/bloc/snackbar_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsCalendarView extends StatefulWidget {
  const AppointmentsCalendarView({super.key});

  @override
  State<AppointmentsCalendarView> createState() =>
      _AppointmentsCalendarViewState();
}

class _AppointmentsCalendarViewState extends State<AppointmentsCalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDay = DateTime(now.year, now.month, now.day);
  }

  List<dynamic> _getEventsForDay(DateTime day) =>
      context.locale.languageCode == 'ar'
      ? mockEventsAr[DateTime(day.year, day.month, day.day)] ?? const []
      : mockEvents[DateTime(day.year, day.month, day.day)] ?? const [];

  @override
  Widget build(BuildContext context) {
    final eventsMap = context.locale.languageCode == 'ar'
        ? mockEventsAr
        : mockEvents;
    List<dynamic> eventLoader(DateTime day) =>
        eventsMap[DateTime(day.year, day.month, day.day)] ?? const [];

    final list = _selectedDay == null ? const [] : eventLoader(_selectedDay!);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.appointments_myAppointments.tr()),
        actions: _buildActions(context),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(3),
                AppCalendar(
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  firstDay: DateTime.utc(2025, 1, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  eventLoader: _getEventsForDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = DateTime(
                        selectedDay.year,
                        selectedDay.month,
                        selectedDay.day,
                      );
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                _AppointmentsList(list: list),
              ],
            ),
            _NewAppointmentButton(),
          ],
        ),
      ),
    );
  }
}

class _NewAppointmentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: horizontalPadding,
      right: horizontalPadding,
      child: PrimaryButton(
        text: LocaleKeys.appointments_addNew.tr(),
        onPressed: () => context.pushNamed(Routes.doctorsSearch),
      ),
    );
  }
}

class _AppointmentsList extends StatelessWidget {
  const _AppointmentsList({required this.list});

  final List list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: AppColors.white,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 24, bottom: 50),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final appointment = list[index] as AppointmentEntity;
            return _AppointmentTile(appointment: appointment);
          },
        ),
      ),
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  const _AppointmentTile({required this.appointment});

  final AppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    final localeTag = context.locale.toLanguageTag();
    final date = AppFormatter.formatDate(appointment.date, locale: localeTag);

    final time = AppFormatter.formatTimeFromEnglish(
      appointment.time,
      toLocale: localeTag,
    );

    final (backgroundColor, textColor) = ColorHelper.statusColors(
      appointment.status,
    );
    final avatarBg = ColorHelper.avatarColor(appointment.doctor.image);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Material(
        child: InkWell(
          splashColor: AppColors.primaryLight,
          highlightColor: AppColors.primaryLight,
          onTap: () => context.pushNamed(
            Routes.appointmentDetails,
            arguments: appointment,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: avatarBg,
                  backgroundImage: AssetImage(appointment.doctor.image),
                ),
                const HorizontalSpace(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Wrap(
                              spacing: 4,
                              children: [
                                AppChip(text: date),
                                AppChip(text: time),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: AppChip(
                                text: appointment.status.label,
                                backgroundColor: backgroundColor,
                                textStyle: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        appointment.doctor.name,
                        style: TextStyles.primaryText70014,
                      ),
                      Text(
                        appointment.doctor.specialization,
                        style: TextStyles.secondaryText40012,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildActions(BuildContext context) {
  return [
    IconButton(
      onPressed: () {
        final currentLocale = context.locale;
        if (currentLocale.languageCode == 'en') {
          context.setLocale(const Locale('ar'));
        } else {
          context.setLocale(const Locale('en'));
        }
      },
      icon: const Icon(Icons.language, color: AppColors.grey),
    ),
    // HACK: these buttons are for user session testing
    IconButton(
      onPressed: () async {
        await SharedPrefHelper.deleteSecured(SharedPrefKeys.userToken);
        await SharedPrefHelper.deleteSecured(SharedPrefKeys.refreshToken);
        if (context.mounted) {
          context.read<SnackbarBloc>().add(
            AddSnackbarEvent(
              message: 'Cleared access + refresh. Now tap "Test Refresh".',
              type: SnackbarType.success,
            ),
          );
        }
      },
      icon: const Icon(Icons.delete_forever, color: AppColors.grey),
      tooltip: LocaleKeys.appointments_clearTokens.tr(),
    ),
    IconButton(
      onPressed: () async {
        final dio = await DioFactory.getDio();
        try {
          await dio.get('https://dummyjson.com/auth/me');
          if (context.mounted) {
            context.read<SnackbarBloc>().add(
              AddSnackbarEvent(
                message: LocaleKeys.appointments_testSucceeded.tr(),
                type: SnackbarType.success,
              ),
            );
          }
        } on DioException catch (e) {
          if (context.mounted) {
            context.read<SnackbarBloc>().add(
              AddSnackbarEvent(
                message: LocaleKeys.appointments_testFailed.tr(
                  args: [e.message ?? ''],
                ),
                type: SnackbarType.error,
              ),
            );
          }
        }
      },
      icon: const Icon(Icons.refresh, color: AppColors.grey),
      tooltip: LocaleKeys.appointments_testRefresh.tr(),
    ),
    IconButton(
      onPressed: () async {
        await SharedPrefHelper.deleteSecured(SharedPrefKeys.userToken);
        if (context.mounted) {
          context.pushReplacementNamed(Routes.login);
        }
      },
      icon: const Icon(Icons.logout, color: AppColors.grey),
      tooltip: LocaleKeys.appointments_logout.tr(),
    ),
  ];
}
