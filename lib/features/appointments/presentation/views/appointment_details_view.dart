import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:dome_care/core/helpers/formatters.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';
import 'package:dome_care/features/appointments/presentation/widget/chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppointmentDetailsView extends StatelessWidget {
  const AppointmentDetailsView({super.key, required this.appointment});

  final AppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBackground,
      appBar: AppBar(title: const Text('Appointment Details')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpace(4),
              _Body(appointment: appointment),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.appointment});

  final AppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      color: AppColors.whiteScaffoldBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpace(16),
          _DoctorImage(image: appointment.image),
          VerticalSpace(14),
          _DoctorName(name: appointment.name),
          VerticalSpace(2),
          _DoctorSpecialization(specialization: appointment.specialization),
          VerticalSpace(4),
          _AppointmentDate(date: appointment.date, time: appointment.time),
          VerticalSpace(30),
          _DetailsSection(
            status: appointment.status,
            location: appointment.location,
            phoneNumber: appointment.phoneNumber,
            telephone: appointment.telephone,
            fee: appointment.fee,
            cancelReason: appointment.cancelReason,
          ),
        ],
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({
    required this.status,
    required this.location,
    required this.phoneNumber,
    required this.telephone,
    required this.fee,
    this.cancelReason,
  });

  final AppointmentStatus status;
  final String location;
  final String phoneNumber;
  final String telephone;
  final String fee;
  final String? cancelReason;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          _StatusRow(status: status),
          VerticalSpace(17),
          _DetailRow(
            label: 'Location',
            value: location,
            icon: Assets.icons.location.svg(),
          ),
          _DetailRow(
            label: 'Phone number',
            value: phoneNumber,
            icon: Assets.icons.phone.svg(),
          ),
          _DetailRow(
            label: 'Telephone',
            value: telephone,
            icon: Assets.icons.telephone.svg(),
          ),
          _DetailRow(
            label: 'Doctor Fee',
            value: fee,
            icon: Assets.icons.money.svg(),
          ),
          VerticalSpace(16),
          _CancelReason(status: status, cancelReason: cancelReason),
        ],
      ),
    );
  }
}

class _CancelReason extends StatelessWidget {
  const _CancelReason({required this.status, required this.cancelReason});

  final AppointmentStatus status;
  final String? cancelReason;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (status == AppointmentStatus.canceled) ...[
          VerticalSpace(12),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Canceled Reason', style: TextStyles.primaryText40014),
          ),
          VerticalSpace(8),
          Text(
            cancelReason ?? 'Contact doctor for more information',
            style: TextStyles.secondaryText40014,
          ),
          VerticalSpace(32),
        ],
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.status});

  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final (statusBg, statusTextColor) = ColorHelper.statusColors(status);
    return Row(
      children: [
        Expanded(child: Text('Details', style: TextStyles.primaryText40014)),
        ChipWidget(
          text: status.label,
          backgroundColor: statusBg,
          textStyle: TextStyle(
            color: statusTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _DoctorSpecialization extends StatelessWidget {
  const _DoctorSpecialization({required this.specialization});

  final String specialization;

  @override
  Widget build(BuildContext context) {
    return Text(specialization, style: TextStyles.secondaryText40012);
  }
}

class _DoctorName extends StatelessWidget {
  const _DoctorName({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: TextStyles.primaryText70016);
  }
}

class _AppointmentDate extends StatelessWidget {
  const _AppointmentDate({required this.date, required this.time});

  final DateTime date;
  final String time;

  @override
  Widget build(BuildContext context) {
    final formattedDate = AppFormatter.formatDate(date);
    return Wrap(
      spacing: 4,
      children: [
        ChipWidget(
          text: formattedDate,
          backgroundColor: AppColors.chipGrey,
          textStyle: TextStyles.lightGrey70016,
        ),
        ChipWidget(
          text: time,
          backgroundColor: AppColors.chipGrey,
          textStyle: TextStyles.lightGrey70016,
        ),
      ],
    );
  }
}

class _DoctorImage extends StatelessWidget {
  const _DoctorImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final avatarBackground = ColorHelper.avatarColor(image);
    return Container(
      decoration: BoxDecoration(
        color: avatarBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final String value;
  final SvgPicture icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(label, style: TextStyles.secondaryText40014),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyles.grey2Text40014,
                    textAlign: TextAlign.end,
                  ),
                ),
                HorizontalSpace(8),
                icon,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
