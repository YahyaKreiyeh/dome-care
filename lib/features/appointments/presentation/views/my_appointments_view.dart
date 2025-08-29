import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:dome_care/core/helpers/formatters.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/core/routing/routes_extension.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/core/widgets/buttons/primary_button.dart';
import 'package:dome_care/features/appointments/data/datasources/mock_appointment_data_source.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyAppointmentsView extends StatefulWidget {
  const MyAppointmentsView({super.key});

  @override
  State<MyAppointmentsView> createState() => _MyAppointmentsViewState();
}

class _MyAppointmentsViewState extends State<MyAppointmentsView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDay = DateTime(now.year, now.month, now.day);
  }

  List<dynamic> _getEventsForDay(DateTime day) =>
      mockEvents[DateTime(day.year, day.month, day.day)] ?? const [];

  @override
  Widget build(BuildContext context) {
    final list = _selectedDay == null
        ? const []
        : _getEventsForDay(_selectedDay!);

    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments')),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(3),
                _AppointmentsCalendar(
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
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
      bottom: 16,
      left: horizontalPadding,
      right: horizontalPadding,
      child: PrimaryButton(text: 'Add New Appointment', onPressed: () {}),
    );
  }
}

class _AppointmentsList extends StatelessWidget {
  const _AppointmentsList({required this.list});

  final List list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: list.isEmpty
          ? const _EmptyState()
          : ColoredBox(
              color: AppColors.white,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 24,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final appointment = list[index];
                  return _AppointmentTile(appointment: appointment);
                },
              ),
            ),
    );
  }
}

class _AppointmentsCalendar extends StatelessWidget {
  const _AppointmentsCalendar({
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.eventLoader,
  });

  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final List<dynamic> Function(DateTime day) eventLoader;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: TableCalendar(
        firstDay: DateTime.utc(2025, 1, 1),
        lastDay: DateTime.utc(2025, 12, 31),
        focusedDay: focusedDay,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: AppColors.primaryText,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: AppColors.primaryText,
          ),
          titleTextStyle: TextStyles.primaryText60016,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) =>
              AppFormatter.formatWeekday(date, locale: locale),
          weekendStyle: TextStyles.secondaryText40012,
          weekdayStyle: TextStyles.secondaryText40012,
        ),
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          selectedTextStyle: TextStyles.white70014,
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary),
            color: AppColors.primaryLight,
          ),
          todayTextStyle: TextStyles.primary40014,
          defaultTextStyle: TextStyles.primaryText40014,
          weekendTextStyle: TextStyles.primaryText40014,
          cellMargin: EdgeInsets.zero,
          outsideDaysVisible: true,
          outsideTextStyle: TextStyles.secondaryText40014,
        ),
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        eventLoader: eventLoader,
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, day, _) {
            return Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Text('${day.day}', style: TextStyles.white70014),
            );
          },
          defaultBuilder: (context, day, _) {
            final hasEvents = eventLoader(day).isNotEmpty;
            if (!hasEvents) return null;
            return _EventDay(
              day: day,
              textColor: AppColors.green,
              background: AppColors.lightGreen,
            );
          },
          outsideBuilder: (context, day, _) {
            final hasEvents = eventLoader(day).isNotEmpty;
            if (!hasEvents) return null;
            return _EventDay(
              day: day,
              textColor: AppColors.green,
              background: AppColors.lightGreen,
            );
          },
          markerBuilder: (context, day, events) {
            if (events.isEmpty) return const SizedBox.shrink();
            final isSelected = isSameDay(selectedDay, day);
            final dotColor = isSelected ? AppColors.white : AppColors.green;
            final count = events.length.clamp(0, 3);
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  count,
                  (_) => Container(
                    width: 3,
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dotColor,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EventDay extends StatelessWidget {
  const _EventDay({
    required this.day,
    required this.textColor,
    required this.background,
  });

  final DateTime day;
  final Color textColor;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 14,
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
    final date = AppFormatter.formatDate(appointment.date);
    final (backgroundColor, textColor) = ColorHelper.statusColors(
      appointment.status,
    );

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
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage(appointment.image),
                backgroundColor: AppColors.primaryLight,
              ),
              HorizontalSpace(8),
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
                            runSpacing: 4,
                            children: [
                              _Chip(text: date),
                              _Chip(text: appointment.time),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _Chip(
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
                    Text(appointment.name, style: TextStyles.primaryText70014),
                    Text(
                      appointment.specialization,
                      style: TextStyles.secondaryText40012,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, this.backgroundColor, this.textStyle});

  final String text;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: backgroundColor ?? AppColors.primaryLight,
      label: Text(
        text,
        style: textStyle ?? TextStyles.primary70013,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No appointments for this date.',
        style: TextStyles.secondaryText40012,
      ),
    );
  }
}
