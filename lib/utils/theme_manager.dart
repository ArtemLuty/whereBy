import 'package:flutter/material.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/utils/fonts.dart';

class AppThemes {
  static final light = ThemeData.light().copyWith(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: ColorConstants.primaryBlue,
    // hintColor: ColorConstants.hintText,
    // cardColor: ColorConstants.lableText,
    // hoverColor: ColorConstants.lableText,
    // disabledColor: ColorConstants.borderColor,
    splashColor: Colors.transparent,
    canvasColor: Colors.transparent,
    highlightColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        // color: ColorConstants.headlineText,
        fontSize: 20,
        fontWeight: FontWeight.normal,
        fontFamily: FontFamily.poppinsBold,
      ),
      displayMedium: TextStyle(
        // color: ColorConstants.headlineText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.poppinsBold,
      ),
      displaySmall: TextStyle(
        // color: ColorConstants.appWhite,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.poppinsBold,
      ),
      bodySmall: TextStyle(
        // color: ColorConstants.lableText,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.poppins,
      ),
      bodyMedium: TextStyle(
        color: ColorConstants.mainText,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.poppins,
      ),
      bodyLarge: TextStyle(
        // color: ColorConstants.headlineText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.poppins,
      ),
      labelLarge: TextStyle(
        color: ColorConstants.containerColor,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        fontFamily: FontFamily.poppinsBold,
      ),
      headlineSmall: TextStyle(
        // color: ColorConstants.lableText,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.poppinsBold,
      ),
    ),
  );
}
