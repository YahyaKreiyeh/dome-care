import 'package:dome_care/core/helpers/formatters.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    AppFormatter.forceLtr(value),
                    style: TextStyles.grey2Text40014,
                    textAlign: TextAlign.end,
                  ),
                ),
                const HorizontalSpace(8),
                Padding(padding: const EdgeInsets.only(top: 4), child: icon),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
