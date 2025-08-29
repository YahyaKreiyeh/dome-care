import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:dome_care/core/helpers/formatters.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsView extends StatelessWidget {
  const AppointmentDetailsView({super.key, required this.appointment});

  final AppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    final date = AppFormatter.formatDate(appointment.date);
    final (statusBg, statusTextColor) = ColorHelper.statusColors(
      appointment.status,
    );

    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBackground,
      appBar: AppBar(
        title: const Text('Appointment Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            bottom: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top banner image (from doctor profile)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(appointment.image, fit: BoxFit.cover),
                ),
              ),
              VerticalSpace(16),

              // Name + specialization
              Text(appointment.name, style: TextStyles.primaryText70016),
              VerticalSpace(2),
              Text(
                appointment.specialization,
                style: TextStyles.secondaryText40014,
              ),

              VerticalSpace(16),

              // Date + time chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _Chip(text: date),
                  _Chip(text: appointment.time),
                ],
              ),

              VerticalSpace(16),

              // Details card
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // header row: "Details" + status chip
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Details',
                            style: TextStyles.primaryText70016,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            appointment.status.label,
                            style: TextStyle(
                              color: statusTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(12),

                    _DetailRow(
                      label: 'Location',
                      value:
                          appointment.location ??
                          'Al-Baramkeh, Damascus, Syria',
                      trailing: const Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: AppColors.primaryText,
                      ),
                      onTap: () {}, // hook up to maps if you want
                    ),
                    _DetailRow(
                      label: 'Phone number',
                      value: appointment.phoneNumber ?? '+963 999 999 999',
                      trailing: const Icon(
                        Icons.call,
                        size: 20,
                        color: AppColors.primaryText,
                      ),
                      onTap: () {}, // hook up to dialer if needed
                    ),
                    _DetailRow(
                      label: 'Telephone',
                      value: appointment.telephone ?? '011 214578512',
                      trailing: const Icon(
                        Icons.phone_in_talk_outlined,
                        size: 20,
                        color: AppColors.primaryText,
                      ),
                    ),
                    _DetailRow(
                      label: 'Doctor Fee',
                      value: appointment.fee ?? '40,000 SYR',
                      trailing: const Icon(
                        Icons.payments_outlined,
                        size: 20,
                        color: AppColors.primaryText,
                      ),
                    ),

                    // Canceled reason (only when canceled)
                    if (appointment.status == AppointmentStatus.canceled) ...[
                      VerticalSpace(12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Canceled Reason',
                          style: TextStyles.primaryText70016,
                        ),
                      ),
                      VerticalSpace(8),
                      Text(
                        appointment.cancelReason ??
                            'Why you want to cancel the Appointment? Why you want to cancel the Appointment? '
                                'Why you want to cancel the Appointment? Why you want to cancel the Appointment?',
                        style: TextStyles.secondaryText40014,
                      ),
                    ],
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

/// ——— Helpers ———

class _Chip extends StatelessWidget {
  const _Chip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColors.primaryLight,
      label: Text(text, style: TextStyles.primary70013),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.trailing,
    this.onTap,
  });

  final String label;
  final String value;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Text(label, style: TextStyles.secondaryText40014),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyles.secondaryText40014,
                textAlign: TextAlign.left,
              ),
            ),
            if (tailingGapNeeded(trailing)) const SizedBox(width: 8),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }

  bool tailingGapNeeded(Widget? t) => t != null;
}
