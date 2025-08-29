import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final IconData? leading;
  final double leadingSize;
  final IconData? trailing;
  final double trailingSize;
  final Color iconColor;
  final double borderRadius;
  final bool loading;
  final bool disabled;
  final Widget? child;
  final Color progressSpinnerColor;
  final String? address;
  final String? phoneNumber;
  final String? url;

  const PrimaryButton({
    super.key,
    this.onPressed,
    this.text,
    this.backgroundColor,
    this.textStyle,
    this.width,
    this.height,
    this.leading,
    this.leadingSize = 20,
    this.trailing,
    this.trailingSize = 16,
    this.iconColor = AppColors.white,
    this.borderRadius = radius,
    this.loading = false,
    this.disabled = false,
    this.child,
    this.progressSpinnerColor = AppColors.white,
    this.address,
    this.phoneNumber,
    this.url,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: disabled || loading
        ? null
        : () async {
            if (onPressed != null) {
              onPressed!();
            }
          },
    style: ElevatedButton.styleFrom(
      disabledBackgroundColor: AppColors.grey,
      backgroundColor:
          backgroundColor ??
          (onPressed == null ? AppColors.grey : AppColors.primary),
      minimumSize: Size(0, height ?? 48),
      maximumSize: Size(width ?? double.infinity, double.infinity),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    child: loading
        ? Center(child: CircularProgressIndicator(color: progressSpinnerColor))
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[
                Icon(leading, size: leadingSize, color: iconColor),
                const SizedBox(width: 12),
              ],
              if (text != null)
                Flexible(
                  child: Text(
                    text!,
                    style: textStyle ?? TextStyles.white70016,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (child != null) ...[child!],
              if (trailing != null) ...[
                const SizedBox(width: 12),
                Icon(trailing, size: trailingSize, color: iconColor),
              ],
            ],
          ),
  );
}
