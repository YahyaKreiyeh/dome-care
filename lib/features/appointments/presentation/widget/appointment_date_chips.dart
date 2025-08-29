import 'package:dome_care/core/helpers/formatters.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/features/appointments/presentation/widget/app_chip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class AppointmentDateChips extends StatelessWidget {
  const AppointmentDateChips({
    super.key,
    required this.date,
    required this.time,
  });

  final DateTime date;
  final String time;

  @override
  Widget build(BuildContext context) {
    final localeTag = context.locale.toLanguageTag();

    final dateStr = AppFormatter.formatDate(date, locale: localeTag);

    final timeStr = AppFormatter.formatTimeFromEnglish(
      time,
      toLocale: localeTag,
    );

    return Wrap(
      spacing: 4,
      children: [
        AppChip(
          text: dateStr,
          backgroundColor: AppColors.chipGrey,
          textStyle: TextStyles.secondaryText70016,
        ),
        AppChip(
          text: timeStr,
          backgroundColor: AppColors.chipGrey,
          textStyle: TextStyles.secondaryText70016,
        ),
      ],
    );
  }
}
