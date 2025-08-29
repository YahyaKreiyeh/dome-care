import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:flutter/widgets.dart';

import 'doctor_image.dart';

class DoctorHeader extends StatelessWidget {
  const DoctorHeader({
    super.key,
    required this.image,
    required this.name,
    required this.specialization,
  });

  final String image;
  final String name;
  final String specialization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpace(16),
        DoctorImage(image: image),
        const VerticalSpace(14),
        Text(name, style: TextStyles.primaryText70016),
        const VerticalSpace(2),
        Text(specialization, style: TextStyles.secondaryText40012),
      ],
    );
  }
}
