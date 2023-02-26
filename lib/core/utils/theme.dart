import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_light_color.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Cairo',

  scaffoldBackgroundColor: Colors.white,

  /// appbar
  appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppLightColor.secondaryColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: const TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      )),
  textTheme: TextTheme(
    /// display
    displayLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: AppLightColor.headingColor,
    ),
    displayMedium: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: AppLightColor.headingColor,
    ),
    displaySmall: TextStyle(
      fontSize: 33,
      fontWeight: FontWeight.w600,
      color: AppLightColor.headingColor,
    ),

    /// headline
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppLightColor.headingColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w600,
      color: AppLightColor.headingColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.w600,
      color: AppLightColor.headingColor,
    ),

    /// title
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppLightColor.subHeadingColor,
    ),
    titleMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppLightColor.subHeadingColor,
    ),
    titleSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppLightColor.subHeadingColor,
    ),

    /// label
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppLightColor.labelColor,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppLightColor.labelColor,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: AppLightColor.labelColor,
    ),

    /// body
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppLightColor.bodyColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppLightColor.bodyColor,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppLightColor.bodyColor,
    ),
  ),

  /// text form field
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppLightColor.inputBgColor,
    isCollapsed: true,
    hintStyle: TextStyle(
      color: AppLightColor.subLabelColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    prefixIconColor: AppLightColor.subLabelColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppLightColor.primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppLightColor.redColor.withOpacity(.1)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppLightColor.redColor.withOpacity(.1)),
    ),
  ),

  /// text button
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
        Colors.white,
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        AppLightColor.secondaryColor,
      ),
      elevation: const MaterialStatePropertyAll(0),
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textStyle: MaterialStateProperty.all<TextStyle?>(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        ),
      ),
    ),
  ),

  /// elevated button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
        Colors.white,
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        AppLightColor.primaryColor,
      ),
      elevation: const MaterialStatePropertyAll(0),
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textStyle: MaterialStateProperty.all<TextStyle?>(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        ),
      ),
    ),
  ),
);
