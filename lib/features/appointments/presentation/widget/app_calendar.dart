import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/helpers/formatters.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// DomeCare-styled calendar with optional event markers.
/// - If [eventLoader] is provided, days with events get green hint background & dots.
/// - Otherwise renders a clean calendar (used in booking flow).
class AppCalendar extends StatelessWidget {
  const AppCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    this.firstDay,
    this.lastDay,
    this.eventLoader,
    this.gestures,
  });

  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final AvailableGestures? gestures;
  final List<dynamic> Function(DateTime day)? eventLoader;

  @override
  Widget build(BuildContext context) {
    final hasEvents = eventLoader != null;
    final localeTag = context.locale.toLanguageTag();
    final startOfWeek = context.locale.languageCode == 'ar'
        ? StartingDayOfWeek.saturday
        : StartingDayOfWeek.sunday;

    Widget headerTitle(BuildContext context, DateTime date) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppFormatter.formatMonthYear(date, locale: localeTag),
              style: TextStyles.primaryText60016,
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: AppColors.primaryText,
            ),
          ],
        ),
      );
    }

    return ColoredBox(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: TableCalendar(
          locale: localeTag,
          startingDayOfWeek: startOfWeek,
          daysOfWeekHeight: 40,
          firstDay: firstDay ?? DateTime.utc(DateTime.now().year, 1, 1),
          lastDay: lastDay ?? DateTime.utc(DateTime.now().year + 1, 12, 31),
          focusedDay: focusedDay,
          availableGestures: gestures ?? AvailableGestures.horizontalSwipe,
          headerStyle: HeaderStyle(
            headerPadding: const EdgeInsets.symmetric(vertical: 16),
            leftChevronMargin: EdgeInsets.zero,
            rightChevronMargin: EdgeInsets.zero,
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: const Icon(
              Icons.chevron_left,
              color: AppColors.primaryText,
            ),
            rightChevronIcon: const Icon(
              Icons.chevron_right,
              color: AppColors.primaryText,
            ),
            titleTextStyle: TextStyles.primaryText60016,
            titleTextFormatter: (date, locale) =>
                AppFormatter.formatMonthYear(date, locale: locale),
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
          selectedDayPredicate: (d) =>
              selectedDay != null &&
              d.year == selectedDay!.year &&
              d.month == selectedDay!.month &&
              d.day == selectedDay!.day,
          onDaySelected: onDaySelected,
          eventLoader: eventLoader ?? (_) => const [],
          calendarBuilders: hasEvents
              ? CalendarBuilders(
                  headerTitleBuilder: headerTitle,
                  selectedBuilder: (context, day, _) => Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Text('${day.day}', style: TextStyles.white70014),
                  ),
                  defaultBuilder: (context, day, _) {
                    final evts = (eventLoader?.call(day) ?? const []);
                    if (evts.isEmpty) return null;
                    return _EventDay(
                      day: day,
                      textColor: AppColors.green,
                      background: AppColors.lightGreen,
                    );
                  },
                  outsideBuilder: (context, day, _) {
                    final evts = (eventLoader?.call(day) ?? const []);
                    if (evts.isEmpty) return null;
                    return _EventDay(
                      day: day,
                      textColor: AppColors.green,
                      background: AppColors.lightGreen,
                    );
                  },
                  markerBuilder: (context, day, events) {
                    if (events.isEmpty) return const SizedBox.shrink();
                    final isSelected =
                        selectedDay != null &&
                        day.year == selectedDay!.year &&
                        day.month == selectedDay!.month &&
                        day.day == selectedDay!.day;
                    final dotColor = isSelected
                        ? AppColors.white
                        : AppColors.green;
                    final count = events.length.clamp(0, 3);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 9),
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
                )
              : CalendarBuilders(headerTitleBuilder: headerTitle),
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
      margin: const EdgeInsets.all(4),
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
