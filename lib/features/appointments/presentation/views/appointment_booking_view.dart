import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/localization/locale_keys.g.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/core/routing/routes_extension.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/core/widgets/buttons/primary_button.dart';
import 'package:dome_care/features/appointments/domain/entites/appointment_entity.dart';
import 'package:dome_care/features/appointments/domain/entites/doctor_entity.dart';
import 'package:dome_care/features/appointments/presentation/widget/app_calendar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppointmentBookingView extends StatefulWidget {
  const AppointmentBookingView({super.key, required this.doctor});
  final DoctorEntity doctor;

  @override
  State<AppointmentBookingView> createState() => _AppointmentBookingViewState();
}

class _AppointmentBookingViewState extends State<AppointmentBookingView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  String? _selectedTime;

  List<_Slot> _buildSlotsFor(DateTime day) {
    final times = <TimeOfDay>[
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 9, minute: 30),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 10, minute: 30),
      const TimeOfDay(hour: 11, minute: 0),
      const TimeOfDay(hour: 11, minute: 30),
      const TimeOfDay(hour: 15, minute: 0),
      const TimeOfDay(hour: 15, minute: 30),
      const TimeOfDay(hour: 16, minute: 0),
      const TimeOfDay(hour: 16, minute: 30),
      const TimeOfDay(hour: 17, minute: 0),
      const TimeOfDay(hour: 17, minute: 30),
    ];

    final locale = context.locale.toString();

    return times.map((t) {
      final dt = DateTime(0, 1, 1, t.hour, t.minute);

      final timeEn = DateFormat('hh:mm', 'en').format(dt);
      var period = DateFormat('a', locale).format(dt);
      if (period.trim().isEmpty) {
        period = DateFormat('a', 'en').format(dt);
      }
      final formatted = '$timeEn $period';

      final enabled =
          (t.minute == 30) ||
          (t.hour == 9 && t.minute == 0 && day.weekday != DateTime.sunday);

      return _Slot(label: formatted, enabled: enabled);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final slots = _buildSlotsFor(_selectedDay);
    final canContinue = _selectedTime != null;

    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBackground,
      appBar: AppBar(title: Text(LocaleKeys.appointment_booking_title.tr())),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              VerticalSpace(3),
              _DoctorHeader(doctor: widget.doctor),
              AppCalendar(
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = DateTime(
                      selected.year,
                      selected.month,
                      selected.day,
                    );
                    _focusedDay = focused;
                    _selectedTime = null;
                  });
                },
              ),
              _TimeGrid(
                slots: slots,
                selected: _selectedTime,
                onSelect: (v) => setState(() => _selectedTime = v),
              ),
              VerticalSpace(16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _NextButton(
        canContinue: canContinue,
        selectedDay: _selectedDay,
        selectedTime: _selectedTime,
        widget: widget,
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.canContinue,
    required DateTime selectedDay,
    required String? selectedTime,
    required this.widget,
  }) : _selectedDay = selectedDay,
       _selectedTime = selectedTime;

  final bool canContinue;
  final DateTime _selectedDay;
  final String? _selectedTime;
  final AppointmentBookingView widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsetsDirectional.only(
        start: horizontalPadding,
        end: horizontalPadding,
        top: 16,
        bottom: 32,
      ),
      child: PrimaryButton(
        text: LocaleKeys.appointment_booking_confirm_next.tr(),
        onPressed: canContinue
            ? () {
                final appt = AppointmentEntity(
                  date: _selectedDay,
                  time: _selectedTime!,
                  status: AppointmentStatus.pending,
                  doctor: widget.doctor,
                  fee: LocaleKeys.unknown.tr(),
                );
                context.pushNamed(
                  Routes.appointmentBookingConfirmation,
                  arguments: appt,
                );
              }
            : null,
      ),
    );
  }
}

class _DoctorHeader extends StatelessWidget {
  const _DoctorHeader({required this.doctor});
  final DoctorEntity doctor;

  @override
  Widget build(BuildContext context) {
    final bg = ColorHelper.avatarColor(doctor.image);
    return ColoredBox(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            VerticalSpace(16),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 53,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(doctor.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const HorizontalSpace(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor.name, style: TextStyles.primaryText70014),
                        const VerticalSpace(2),
                        Text(
                          doctor.specialization,
                          style: TextStyles.secondaryText40012,
                        ),
                        const VerticalSpace(6),
                        Row(
                          children: [
                            Assets.icons.location.svg(
                              colorFilter: const ColorFilter.mode(
                                AppColors.grey2Text,
                                BlendMode.srcIn,
                              ),
                            ),
                            const HorizontalSpace(4),
                            Expanded(
                              child: Text(
                                doctor.location,
                                style: TextStyles.grey2Text40012,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpace(30),
          ],
        ),
      ),
    );
  }
}

class _TimeGrid extends StatelessWidget {
  const _TimeGrid({
    required this.slots,
    required this.selected,
    required this.onSelect,
  });

  final List<_Slot> slots;
  final String? selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          VerticalSpace(30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: slots.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.6,
            ),
            itemBuilder: (_, i) {
              final slot = slots[i];
              final isSelected = slot.label == selected;
              return _TimePill(
                label: slot.label,
                enabled: slot.enabled,
                selected: isSelected,
                onTap: slot.enabled ? () => onSelect(slot.label) : null,
              );
            },
          ),
          VerticalSpace(12),
        ],
      ),
    );
  }
}

class _TimePill extends StatelessWidget {
  const _TimePill({
    required this.label,
    required this.enabled,
    required this.selected,
    this.onTap,
  });

  final String label;
  final bool enabled;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color bg = !enabled
        ? AppColors.disabledChipBackground.withValues(alpha: 0.30)
        : selected
        ? AppColors.selectedChipBackground
        : AppColors.chipBackground;

    final TextStyle textStyle = !enabled
        ? TextStyles.disabledChipText40016
        : selected
        ? TextStyles.primary70016
        : TextStyles.chipText40016;

    final double elevation = (!enabled || selected) ? 0 : 8;

    return Material(
      color: bg,
      elevation: elevation,
      shadowColor: AppColors.enabledChipShadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primaryLight,
        highlightColor: AppColors.primaryLight,
        child: SizedBox(
          height: 44,
          child: Center(child: Text(label, style: textStyle)),
        ),
      ),
    );
  }
}

class _Slot {
  const _Slot({required this.label, required this.enabled});
  final String label;
  final bool enabled;
}
