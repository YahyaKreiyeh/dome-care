import 'package:flutter/material.dart';
import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final IconData? leading;
  final Widget? leadingImageIcon;
  final double leadingSize;
  final double trailingSize;
  final String? text;
  final IconData? trailing;

  final double? height;
  final double? width;
  final bool loading;
  final bool disabled;
  final double borderRadius;
  final Color? backgroundColor;
  final Widget? child;
  final double fontSize;
  final Color progressSpinnerColor;
  const SecondaryButton({
    super.key,
    required this.onPressed,
    this.leading,
    this.leadingSize = 20,
    this.trailingSize = 16,
    this.text,
    this.backgroundColor,
    this.width,
    this.height = 50,
    this.trailing,
    this.borderRadius = radius,
    this.loading = false,
    this.disabled = false,
    this.child,
    this.fontSize = 16,
    this.progressSpinnerColor = Colors.white,
    this.leadingImageIcon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled || loading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.white,
        minimumSize: Size(0, height ?? 48),
        maximumSize: Size(width ?? double.infinity, double.infinity),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: const BorderSide(width: 1, color: AppColors.buttonBorderGrey),
        ),
        elevation: 0,
      ),
      child: Builder(
        builder: (context) {
          if (loading) {
            return Center(
              child: CircularProgressIndicator(color: progressSpinnerColor),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingImageIcon != null) ...[
                leadingImageIcon!,
                const SizedBox(width: 12),
              ],
              if (leading != null) ...[
                Icon(
                  leading,
                  size: leadingSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 12),
              ],
              if (text != null)
                Flexible(
                  child: Text(
                    text ?? '',
                    style: textStyle ?? TextStyles.primaryText50017,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (child != null) ...[child ?? const SizedBox.shrink()],
              if (trailing != null) ...[
                const SizedBox(width: 12),
                Icon(
                  trailing,
                  size: trailingSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
