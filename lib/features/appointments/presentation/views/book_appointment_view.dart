import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/routing/routes_extension.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/core/widgets/buttons/primary_button.dart';
import 'package:dome_care/features/appointments/domain/entites/doctor_entity.dart';
import 'package:dome_care/features/appointments/presentation/widget/app_calendar.dart';
import 'package:flutter/material.dart';

class BookAppointmentView extends StatefulWidget {
  const BookAppointmentView({super.key, required this.doctor});
  final DoctorEntity doctor;

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  String? _selectedTime;

  List<_Slot> _buildSlotsFor(DateTime day) {
    final base = <String>[
      '09:00 AM',
      '09:30 AM',
      '10:00 AM',
      '10:30 AM',
      '11:00 AM',
      '11:30 AM',
      '03:00 PM',
      '03:30 PM',
      '04:00 PM',
      '04:30 PM',
      '05:00 PM',
      '05:30 PM',
    ];

    return List<_Slot>.generate(base.length, (i) {
      final enabled =
          (i % 2 == 1) || (i == 0 && day.weekday != DateTime.sunday);
      return _Slot(label: base[i], enabled: enabled);
    });
  }

  @override
  Widget build(BuildContext context) {
    final slots = _buildSlotsFor(_selectedDay);
    final canContinue = _selectedTime != null;

    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBackground,
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SafeArea(
        bottom: false,
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
              _NextButton(canContinue: canContinue),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.canContinue});

  final bool canContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsetsDirectional.only(
        start: horizontalPadding,
        end: horizontalPadding,
        bottom: 60,
      ),
      child: PrimaryButton(
        text: 'Next',
        onPressed: canContinue
            ? () {
                context.pop();
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
