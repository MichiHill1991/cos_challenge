import 'package:cos_challenge/utils/color.dart';
import 'package:flutter/material.dart';

final ThemeData cosTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: BrandColors.neutralWhite,
  primaryColor: BrandColors.brand,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: BrandColors.brand,
    onPrimary: BrandColors.white,
    secondary: BrandColors.primaryYellow,
    onSecondary: BrandColors.black,
    error: BrandColors.errorRedDark,
    onError: BrandColors.white,
    surface: BrandColors.white,
    onSurface: BrandColors.neutral500,
  ),
  appBarTheme: AppBarTheme(
    elevation: 3,
    centerTitle: true,
    foregroundColor: BrandColors.white,
    backgroundColor: BrandColors.ciBackground,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: BrandColors.white,
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: BrandColors.neutral500,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: BrandColors.neutral500,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: BrandColors.neutral500),
    bodyMedium: TextStyle(fontSize: 14, color: BrandColors.dimGrey),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: BrandColors.brand,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: BrandColors.brandButtonBG,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: BrandColors.brand,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: BrandColors.brandButtonBG,
      foregroundColor: BrandColors.black,
      textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
);
