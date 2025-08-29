import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/core/widgets/text_fields/custom_text_field.dart';
import 'package:dome_care/features/appointments/data/datasources/mock_appointment_data_source.dart';
import 'package:dome_care/features/appointments/domain/entites/doctor_entity.dart';
import 'package:flutter/material.dart';

class SearchDoctorsView extends StatefulWidget {
  const SearchDoctorsView({super.key});

  @override
  State<SearchDoctorsView> createState() => _SearchDoctorsViewState();
}

class _SearchDoctorsViewState extends State<SearchDoctorsView> {
  final _controller = TextEditingController();
  String _q = '';

  late final List<DoctorEntity> _items = mockDoctors;

  @override
  Widget build(BuildContext context) {
    final query = _q.trim().toLowerCase();
    final filtered = query.isEmpty
        ? _items
        : _items
              .where(
                (d) =>
                    d.name.toLowerCase().contains(query) ||
                    d.specialization.toLowerCase().contains(query) ||
                    d.location.toLowerCase().contains(query),
              )
              .toList();

    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBackground,
      appBar: AppBar(
        title: const Text('Book Appointment'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 10,
            ),
            child: CustomTextField(
              controller: _controller,
              hintText: 'Search for doctors',
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

              suffixIcon: (_q.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Assets.icons.close.svg(
                        colorFilter: const ColorFilter.mode(
                          AppColors.secondaryText,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Assets.icons.close.svg(
                        colorFilter: const ColorFilter.mode(
                          AppColors.secondaryText,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
              suffixIconConstraints: const BoxConstraints.tightFor(
                width: 43,
                height: 43,
              ),
              onChanged: (v) => setState(() => _q = v),
              filled: true,
              showBorder: false,
              fillColor: AppColors.inputFillGrey,
              textStyle: TextStyles.primaryText40015,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: ColoredBox(
          color: AppColors.whiteScaffoldBackground,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: filtered.length,
            itemBuilder: (context, i) => _DoctorTile(doctor: filtered[i]),
          ),
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
    );
  }
}
