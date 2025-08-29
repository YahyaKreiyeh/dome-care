import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/localization/locale_keys.g.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/core/routing/routes_extension.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/core/widgets/text_fields/custom_text_field.dart';
import 'package:dome_care/features/appointments/data/datasources/mock_appointment_data_source.dart';
import 'package:dome_care/features/appointments/data/datasources/mock_appointment_data_source_ar.dart';
import 'package:dome_care/features/appointments/domain/entites/doctor_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DoctorsSearchView extends StatefulWidget {
  const DoctorsSearchView({super.key});

  @override
  State<DoctorsSearchView> createState() => _DoctorsSearchViewState();
}

class _DoctorsSearchViewState extends State<DoctorsSearchView> {
  final _controller = TextEditingController();
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final doctors = context.locale.languageCode == 'ar'
        ? mockDoctorsAr
        : mockDoctors;

    final query = _searchTerm.trim().toLowerCase();

    final filteredDoctors = query.isEmpty
        ? doctors
        : doctors
              .where(
                (doctor) =>
                    doctor.name.toLowerCase().contains(query) ||
                    doctor.specialization.toLowerCase().contains(query) ||
                    doctor.location.toLowerCase().contains(query),
              )
              .toList();

    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBackground,
      appBar: AppBar(
        title: Text(LocaleKeys.doctors_bookAppointment.tr()),
        bottom: _SearchBarField(
          controller: _controller,
          onChanged: (value) => setState(() => _searchTerm = value),
        ),
      ),
      body: CustomScrollView(
        slivers: [_DoctorsList(filteredDoctors: filteredDoctors)],
      ),
    );
  }
}

class _DoctorsList extends StatelessWidget {
  const _DoctorsList({required this.filteredDoctors});

  final List<DoctorEntity> filteredDoctors;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 3, bottom: 8),
      sliver: SliverList.builder(
        itemCount: filteredDoctors.length,
        itemBuilder: (context, i) => _DoctorTile(doctor: filteredDoctors[i]),
      ),
    );
  }
}

class _DoctorTile extends StatelessWidget {
  const _DoctorTile({required this.doctor});

  final DoctorEntity doctor;

  @override
  Widget build(BuildContext context) {
    final bg = ColorHelper.avatarColor(doctor.image);
    return Material(
      child: InkWell(
        splashColor: AppColors.primaryLight,
        highlightColor: AppColors.primaryLight,
        onTap: () =>
            context.pushNamed(Routes.appointmentBooking, arguments: doctor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: bg,
                backgroundImage: AssetImage(doctor.image),
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
                    const VerticalSpace(8),
                    Row(
                      children: [
                        Assets.icons.location.svg(
                          colorFilter: const ColorFilter.mode(
                            AppColors.grey2Text,
                            BlendMode.srcIn,
                          ),
                        ),
                        const HorizontalSpace(6),
                        Expanded(
                          child: Text(
                            doctor.location,
                            style: TextStyles.grey2Text40012,
                            overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}

class _SearchBarField extends StatelessWidget implements PreferredSizeWidget {
  const _SearchBarField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 10,
        ),
        child: CustomTextField(
          controller: controller,
          hintText: LocaleKeys.doctors_searchHint.tr(),
          onChanged: onChanged,
          textStyle: TextStyles.primaryText40015,
          filled: true,
          showBorder: false,
          fillColor: AppColors.inputFillGrey,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Assets.icons.search.svg(
              colorFilter: const ColorFilter.mode(
                AppColors.primaryText,
                BlendMode.srcIn,
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints.tightFor(
            width: 43,
            height: 43,
          ),
          suffixIcon: InkWell(
            onTap: () {
              if (controller.text.isNotEmpty) controller.clear();
              onChanged('');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Assets.icons.close.svg(
                colorFilter: const ColorFilter.mode(
                  AppColors.secondaryText,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          suffixIconConstraints: const BoxConstraints.tightFor(
            width: 43,
            height: 43,
          ),
        ),
      ),
    );
  }
}
