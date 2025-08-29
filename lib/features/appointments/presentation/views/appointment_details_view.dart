import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/localization/locale_keys.g.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';
import 'package:dome_care/features/appointments/presentation/widget/appointment_date_chips.dart';
import 'package:dome_care/features/appointments/presentation/widget/details_section.dart';
import 'package:dome_care/features/appointments/presentation/widget/doctor_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsView extends StatelessWidget {
  const AppointmentDetailsView({super.key, required this.appointment});
  final AppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBackground,
      appBar: AppBar(title: Text(LocaleKeys.appointment_details_title.tr())),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              VerticalSpace(3),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                color: AppColors.whiteScaffoldBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpace(3),
                    DoctorHeader(
                      image: appointment.doctor.image,
                      name: appointment.doctor.name,
                      specialization: appointment.doctor.specialization,
                    ),
                    VerticalSpace(4),
                    AppointmentDateChips(
                      date: appointment.date,
                      time: appointment.time,
                    ),
                    VerticalSpace(14),
                    DetailsSection(
                      status: appointment.status,
                      location: appointment.doctor.location,
                      phoneNumber: appointment.doctor.phoneNumber,
                      telephone: appointment.doctor.telephone,
                      fee: appointment.fee,
                      cancelReason:
                          appointment.status == AppointmentStatus.canceled
                          ? (appointment.cancelReason ??
                                LocaleKeys.appointment_contact_doctor_more_info
                                    .tr())
                          : null,
                    ),
                    VerticalSpace(16),
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
