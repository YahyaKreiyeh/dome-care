import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:dome_care/core/localization/locale_keys.g.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/features/appointments/presentation/widget/app_chip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class StatusChipRow extends StatelessWidget {
  const StatusChipRow({super.key, required this.status});
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final (bg, textColor) = ColorHelper.statusColors(status);
    return Row(
      children: [
        Expanded(
          child: Text(
            LocaleKeys.details_title.tr(),
            style: TextStyles.primaryText40014,
          ),
        ),
        AppChip(
          text: status.label,
          backgroundColor: bg,
          textStyle: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
