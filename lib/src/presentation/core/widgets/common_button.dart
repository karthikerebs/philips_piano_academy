import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.label,
      required this.onTap,
      this.fontSize,
      this.padding,
      this.backgroundColor});
  final String label;
  final Function() onTap;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            shadowColor: AppColors.secondaryColor,
            foregroundColor: AppColors.secondaryColor,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kSize.height * 0.118)),
            backgroundColor: backgroundColor ?? AppColors.primaryColor),
        child: Text(
          label,
          style: AppTypography.dmSansRegular.copyWith(
              color: AppColors.secondaryColor, fontSize: fontSize ?? 12),
        ));
  }
}
