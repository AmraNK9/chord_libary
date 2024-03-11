import 'package:chord_libary/core/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color colorGray = Colors.grey;

  static get({required bool isLight}) {
    return ThemeData(
      focusColor: AppColors.secondary,
      primaryColor: AppColors.secondary,
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: AppColors.secondary),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary)),
          outlineBorder: BorderSide(color: AppColors.activeOutLineBorder),
          isDense: true,
          focusColor: AppColors.activeOutLineBorder,
          activeIndicatorBorder:
              BorderSide(color: AppColors.activeOutLineBorder),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.outlineInputBorder))),
      dialogBackgroundColor: AppColors.dialogBackgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                AppColors.elevatedButtonBackgroundColor),
            foregroundColor: MaterialStatePropertyAll(
                AppColors.elevatedButtonForegroundColor)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStatePropertyAll(AppColors.textButtonColor)),
      ),
    );
  }
}
