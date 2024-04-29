import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/src/presentation/core/theme/typography.dart';
import 'package:music_app/src/presentation/core/widgets/textfield.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker(
      {super.key,
      required this.dateController,
      required this.errorMessage,
      required this.hintText,
      required this.onChanged,
      this.firstDate,
      this.initialDate,
      this.borderColor,
      this.suffixIcon,
      this.fillColor,
      this.hintColor,
      this.initialDatePickerMode,
      this.borderRadius,
      this.validator,
      this.lastDate});
  final TextEditingController dateController;
  final String errorMessage;
  final String hintText;
  final Function(DateTime) onChanged;
  final DateTime? firstDate;
  final DateTime? initialDate;
  final Color? borderColor;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? hintColor;
  final DatePickerMode? initialDatePickerMode;
  final BorderRadius? borderRadius;
  final Function? validator;
  final DateTime? lastDate;
  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();
  var dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return CustomTextField(
      hintText: widget.hintText,
      fillColor: widget.fillColor ?? AppColors.secondaryColor,
      hintstyle: AppTypography.dmSansRegular.copyWith(
          fontSize: kSize.height * 0.021,
          color: widget.hintColor ?? AppColors.greyColor),
      readOnly: true,
      controller: widget.dateController,
      errorMessage: widget.errorMessage,
      hintColor: AppColors.primaryColor,
      border: OutlineInputBorder(
          borderSide:
              BorderSide(color: widget.borderColor ?? AppColors.primaryColor),
          borderRadius: widget.borderRadius ??
              BorderRadius.circular(kSize.height * 0.142)),
      suffixIcon: widget.suffixIcon ??
          Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.primaryColor, size: kSize.height * 0.035),
      validator: widget.validator,
      onChanged: (value) {
        widget.onChanged;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime(1950),
          lastDate: widget.lastDate ?? DateTime(2050),
          initialDatePickerMode:
              widget.initialDatePickerMode ?? DatePickerMode.day,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          builder: (context, child) {
            return Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                  primary: AppColors.primaryColor,
                  onPrimary: AppColors.secondaryColor,
                  onSecondary: AppColors.secondaryColor,
                  secondary: AppColors.secondaryColor,
                  onSurface: AppColors.primaryColor,
                )),
                child: child!);
          },
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
            // widget.dateController.text = dateFormat.format(pickedDate);
          });
          widget.onChanged(pickedDate);
        }
      },
    );
  }
}
