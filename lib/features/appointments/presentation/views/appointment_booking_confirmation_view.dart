import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/localization/locale_keys.g.dart';
import 'package:dome_care/core/routing/routes_extension.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/core/widgets/buttons/primary_button.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';
import 'package:dome_care/features/appointments/presentation/widget/appointment_date_chips.dart';
import 'package:dome_care/features/appointments/presentation/widget/details_section.dart';
import 'package:dome_care/features/appointments/presentation/widget/doctor_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppointmentBookingConfirmationView extends StatelessWidget {
  const AppointmentBookingConfirmationView({
    super.key,
    required this.appointment,
  });
  final AppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBackground,
      appBar: AppBar(title: Text(LocaleKeys.appointment_details_title.tr())),
      body: SafeArea(
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
                    VerticalSpace(30),
                    DetailsSection(
                      location: appointment.doctor.location,
                      phoneNumber: appointment.doctor.phoneNumber,
                      telephone: appointment.doctor.telephone,
                      fee: null,
                    ),
                    VerticalSpace(16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BookAppointment(appointment: appointment),
    );
  }
}

class _BookAppointment extends StatelessWidget {
  const _BookAppointment({required this.appointment});

  final AppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.whiteScaffoldBackground,
      padding: const EdgeInsetsDirectional.only(
        start: horizontalPadding,
        end: horizontalPadding,
        top: 16,
        bottom: 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _FeeField(value: appointment.fee),
          VerticalSpace(16),
          PrimaryButton(
            text: LocaleKeys.booking_book_appointment.tr(),
            onPressed: () => context.popUntilFirst(),
          ),
        ],
      ),
    );
  }
}

class _FeeField extends StatelessWidget {
  const _FeeField({required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              LocaleKeys.booking_doctor_fee.tr(),
              style: TextStyles.primaryText40016,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyles.secondaryText40016,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
