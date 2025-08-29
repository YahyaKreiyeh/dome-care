import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/features/appointments/presentation/widget/detail_row.dart';
import 'package:dome_care/features/appointments/presentation/widget/status_chip_row.dart';
import 'package:flutter/widgets.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({
    super.key,
    required this.location,
    required this.phoneNumber,
    required this.telephone,
    this.fee,
    this.status,
    this.cancelReason,
  });

  final String location;
  final String phoneNumber;
  final String telephone;
  final String? fee;
  final AppointmentStatus? status;
  final String? cancelReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (status != null)
            StatusChipRow(status: status!)
          else
            Text('Details', style: TextStyles.primaryText40014),
          VerticalSpace(12),
          DetailRow(
            label: 'Location',
            value: location,
            icon: Assets.icons.location.svg(),
          ),
          DetailRow(
            label: 'Phone number',
            value: phoneNumber,
            icon: Assets.icons.phone.svg(),
          ),
          DetailRow(
            label: 'Telephone',
            value: telephone,
            icon: Assets.icons.telephone.svg(),
          ),
          if (fee != null)
            DetailRow(
              label: 'Doctor Fee',
              value: fee!,
              icon: Assets.icons.money.svg(),
            ),
          if (status == AppointmentStatus.canceled && cancelReason != null) ...[
            VerticalSpace(12),
            Text('Canceled Reason', style: TextStyles.primaryText40014),
            VerticalSpace(8),
            Text(cancelReason!, style: TextStyles.secondaryText40014),
          ],
        ],
      ),
    );
  }
}
