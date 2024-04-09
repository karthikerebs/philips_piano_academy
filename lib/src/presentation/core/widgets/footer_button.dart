import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class FooterButton extends StatelessWidget {
  const FooterButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.backgroundColor,
      this.labelColor,
      this.fontSize,
      this.padding,
      this.boxShadow});
  final String label;
  final Function() onPressed;
  final Color? backgroundColor;
  final Color? labelColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            foregroundColor: AppColors.secondaryColor,
            shadowColor: AppColors.secondaryColor,
            backgroundColor: backgroundColor ?? AppColors.primaryColor,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kSize.height * 0.131)),
            padding: padding ??
                EdgeInsets.symmetric(
                    vertical: kSize.height * 0.012,
                    horizontal: kSize.width * 0.08)),
        child: Text(
          label,
          style: AppTypography.dmSansMedium.copyWith(
              fontSize: fontSize ?? kSize.height * 0.0189,
              color: labelColor ?? AppColors.secondaryColor),
        ));
  }
}
