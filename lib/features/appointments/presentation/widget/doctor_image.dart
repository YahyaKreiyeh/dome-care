import 'package:dome_care/core/helpers/color_helper.dart';
import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final bg = ColorHelper.avatarColor(image);
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}
