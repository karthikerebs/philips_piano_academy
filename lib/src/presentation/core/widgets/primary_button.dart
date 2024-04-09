import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.backgroundColor,
      this.labelColor,
      this.borderSide,
      this.width});
  final Function() onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? labelColor;
  final BorderSide? borderSide;
  final double? width;
  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      width: widget.width ?? kSize.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: AppColors.primaryColor.withOpacity(.4),
            offset: const Offset(0, 4),
            blurRadius: 20)
      ]),
      child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
              side: widget.borderSide,
              backgroundColor:
                  widget.backgroundColor ?? AppColors.secondaryColor,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kSize.height * 0.131)),
              padding: EdgeInsets.symmetric(vertical: kSize.height * 0.0197)),
          child: Text(
            widget.label,
            style: AppTypography.dmSansMedium.copyWith(
                fontSize: kSize.height * 0.024,
                color: widget.labelColor ?? AppColors.primaryColor),
          )),
    );
  }
}
