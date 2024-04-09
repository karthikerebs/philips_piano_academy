import 'package:flutter/material.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.keyboardType,
      this.maxLength,
      this.obscureText = false,
      this.validator,
      this.errorMessage,
      this.fillColor,
      this.suffixIcon,
      this.readOnly,
      this.onChanged,
      this.onTap,
      this.border,
      this.hintColor,
      this.maxLines,
      this.hintstyle,
      this.textColor,
      this.contentPadding,
      this.errorBorder,
      this.prefixIcon,
      this.textCapitalization,
      this.helperText});
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool obscureText;
  final Function? validator;
  final String? errorMessage;
  final Color? fillColor;
  final Widget? suffixIcon;
  final bool? readOnly;
  final Function(String)? onChanged;
  final Function()? onTap;
  final InputBorder? border;
  final Color? hintColor;
  final int? maxLines;
  final TextStyle? hintstyle;
  final Color? textColor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? errorBorder;
  final Widget? prefixIcon;
  final TextCapitalization? textCapitalization;
  final String? helperText;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return TextFormField(
      maxLines: widget.maxLines,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTypography.dmSansRegular.copyWith(
          fontSize: kSize.height * 0.023,
          color: widget.textColor ?? AppColors.blackColor),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTap,
      cursorColor: widget.textColor ?? AppColors.blackColor,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      obscuringCharacter: '*',
      validator: (value) {
        if (widget.validator != null && !widget.validator!(value)) {
          return widget.errorMessage;
        }
        return null;
      },
      decoration: InputDecoration(
          helperText: widget.helperText,
          hintMaxLines: 1,
          helperStyle: AppTypography.dmSansRegular.copyWith(
              fontSize: kSize.height * 0.015,
              height: 1,
              color: AppColors.blackColor.withOpacity(.5)),
          hoverColor: AppColors.transparent,
          isCollapsed: true,
          border: widget.border ??
              OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(kSize.height * 0.142)),
          disabledBorder: widget.border ??
              OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(kSize.height * 0.142)),
          enabledBorder: widget.border ??
              OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(kSize.height * 0.142)),
          errorBorder: widget.errorBorder ??
              OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.redColor),
                  borderRadius: BorderRadius.circular(kSize.height * 0.142)),
          focusedBorder: widget.border ??
              OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.transparent),
                  borderRadius: BorderRadius.circular(kSize.height * 0.142)),
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(
                  horizontal: kSize.width * 0.0605,
                  vertical: kSize.height * 0.019),
          prefixIcon: widget.prefixIcon,
          counter: const SizedBox(),
          fillColor: widget.fillColor ?? AppColors.textFieldFillColor,
          filled: true,
          suffixIcon: widget.suffixIcon,
          isDense: true,
          hintText: widget.hintText,
          hintStyle: widget.hintstyle ??
              AppTypography.dmSansRegular.copyWith(
                  height: 1.7,
                  fontSize: kSize.height * 0.021,
                  color: widget.hintColor)),
    );
  }
}
