import 'package:layered_architecture/core/app_string.dart';
import 'package:layered_architecture/core/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightAppTheme = ThemeData(
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      color: Color(0xFFF4511E),
      centerTitle: true,
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xFFF4511E),
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      border: inputBorder,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF4511E),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFF4511E),
    ),
    fontFamily: AppString.appFont,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black54,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey),
        ),
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        side: BorderSide(
          color: Colors.grey,
          width: 2,
        ),
      ),
      dialHandColor: const Color(0xFFF4511E),
      hourMinuteColor: WidgetStateColor.resolveWith(
        (states) {
          return switch (states.contains(WidgetState.selected)) {
            true => const Color(0xFFF4511E),
            false => Colors.black12
          };
        },
      ),
      hourMinuteTextColor: WidgetStateColor.resolveWith(
        (states) {
          return switch (states.contains(WidgetState.selected)) {
            true => Colors.black54,
            false => Colors.grey,
          };
        },
      ),
      dayPeriodBorderSide: const BorderSide(color: Colors.grey),
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      dayPeriodColor: Colors.transparent,
      dayPeriodTextColor: WidgetStateColor.resolveWith(
        (states) {
          return switch (states.contains(WidgetState.selected)) {
            true => const Color(0xFFF4511E),
            false => Colors.black12,
          };
        },
      ),
      hourMinuteShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.black12),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    ),
  );
}
