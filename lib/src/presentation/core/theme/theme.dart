import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.light(
      secondary: AppColors.secondaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor)),
    timePickerTheme: const TimePickerThemeData(
      dayPeriodTextColor: AppColors.secondaryColor,
      dayPeriodColor: AppColors.primaryColor,
      hourMinuteColor: AppColors.textFieldFillColor,
      entryModeIconColor: AppColors.primaryColor,
      hourMinuteTextColor: AppColors.primaryColor,
      dialHandColor: AppColors.primaryColor,
    ),
    /* const DatePickerThemeData(
        dividerColor: AppColors.primaryColor,
        headerBackgroundColor: AppColors.primaryColor,
        todayBackgroundColor: MaterialStatePropertyAll(AppColors.primaryColor)), */
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      foregroundColor: AppColors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.secondaryColor,
      ),
    ),
    fontFamily: 'DM sans',
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionHandleColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor.withOpacity(.2),
    ),
  );
}
