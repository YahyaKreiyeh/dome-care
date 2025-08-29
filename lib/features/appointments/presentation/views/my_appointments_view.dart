import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/features/appointments/data/datasources/mock_appointment_data_source.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MyAppointmentsView extends StatefulWidget {
  const MyAppointmentsView({super.key});

  @override
  State<MyAppointmentsView> createState() => _MyAppointmentsViewState();
}

class _MyAppointmentsViewState extends State<MyAppointmentsView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<dynamic> _getEventsForDay(DateTime day) =>
      mockEvents[DateTime(day.year, day.month, day.day)] ?? const [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments')),
      body: Column(
        children: [
          VerticalSpace(3),
          _AppointmentsCalendar(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          VerticalSpace(24),
          if (_selectedDay != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Appointments on ${_selectedDay!.toLocal().toString().split(' ').first}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
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
              DateFormat('EEE', locale).format(date).toUpperCase(),
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
