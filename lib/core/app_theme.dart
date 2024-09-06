import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whereby_app/core/app_bloc.dart';

class AppColorSchema {
  final Color accentColor;
  final Color borderColor;
  final Color strokeColor;
  final Color disabledColor;
  final Color accentBgColor;
  final Color primaryBgColor;
  final Color secondaryBgColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color inActiveTextColor;
  final Color positiveColor;
  final Color invertTextColor;

  final Color focusColor;
  final Color errorColor;
  final Color inactiveColor;
  final Color negativeColor;
  final Color primaryButtonColor;
  final Color secondaryButtonColor;
  final Color secondaryAccentColor;

  final Color tabBgColor;
  final Color tabActiveColor;
  final Color successColor;
  final Color primaryLinkColor;
  final Color qrBg;

  final Brightness brightness;

  const AppColorSchema({
    required this.brightness,
    required this.strokeColor,
    required this.accentColor,
    required this.borderColor,
    required this.disabledColor,
    required this.accentBgColor,
    required this.primaryBgColor,
    required this.invertTextColor,
    required this.primaryLinkColor,
    required this.secondaryBgColor,
    required this.primaryTextColor,
    required this.inActiveTextColor,
    required this.secondaryTextColor,
    required this.secondaryAccentColor,
    required this.secondaryButtonColor,
    required this.tabBgColor,
    required this.tabActiveColor,
    required this.qrBg,
    this.inactiveColor = const Color.fromRGBO(159, 167, 191, 1),
    this.successColor = const Color.fromRGBO(0, 188, 119, 1),
    this.focusColor = const Color.fromRGBO(53, 85, 201, 1),
    this.errorColor = const Color.fromRGBO(227, 62, 35, 1),
    this.positiveColor = const Color.fromRGBO(0, 255, 148, 1),
    this.negativeColor = const Color.fromRGBO(255, 200, 70, 1),
    this.primaryButtonColor = const Color.fromRGBO(2, 175, 111, 1),
  });
}

class AppTheme {
  static const AppColorSchema lightColors = AppColorSchema(
    brightness: Brightness.light,
    invertTextColor: Colors.white,
    primaryBgColor: Color.fromRGBO(231, 238, 249, 1),
    strokeColor: Color.fromRGBO(207, 216, 227, 1),
    borderColor: Color.fromRGBO(224, 230, 235, 1),
    accentColor: Color.fromRGBO(60, 73, 101, 1),
    disabledColor: Color.fromRGBO(224, 230, 235, 1),
    primaryTextColor: Color.fromRGBO(4, 18, 40, 1),
    secondaryBgColor: Color.fromRGBO(255, 255, 255, 1),
    secondaryTextColor: Color.fromRGBO(89, 100, 118, 1),
    inActiveTextColor: Color.fromRGBO(163, 175, 186, 1),
    secondaryAccentColor: Color.fromRGBO(60, 73, 101, 1),
    accentBgColor: Color.fromRGBO(239, 245, 255, 1),
    primaryButtonColor: Color.fromRGBO(2, 16, 38, 1),
    secondaryButtonColor: Color.fromRGBO(204, 223, 254, 1),
    tabBgColor: Colors.white,
    tabActiveColor: Color.fromRGBO(204, 223, 254, 1),
    qrBg: Color.fromRGBO(163, 173, 191, 1),
    primaryLinkColor: Color.fromRGBO(57, 111, 214, 1),
  );

  static const AppColorSchema darkColors = AppColorSchema(
    brightness: Brightness.dark,
    primaryTextColor: Colors.white,
    primaryBgColor: Color.fromRGBO(11, 24, 46, 1),
    strokeColor: Color.fromRGBO(32, 43, 60, 1),
    invertTextColor: Color.fromRGBO(16, 37, 67, 1),
    accentBgColor: Color.fromRGBO(37, 57, 92, 1),
    borderColor: Color.fromRGBO(37, 52, 78, 1),
    accentColor: Color.fromRGBO(2, 175, 111, 1),
    secondaryBgColor: Color.fromRGBO(8, 18, 34, 1),
    secondaryTextColor: Color.fromRGBO(162, 175, 198, 1),
    disabledColor: Color.fromRGBO(37, 52, 78, 1),
    inActiveTextColor: Color.fromRGBO(94, 108, 133, 1),
    secondaryAccentColor: Color.fromRGBO(191, 212, 242, 1),
    primaryButtonColor: Color.fromRGBO(177, 220, 255, 1),
    secondaryButtonColor: Color.fromRGBO(16, 35, 67, 1),
    tabBgColor: Color.fromRGBO(22, 42, 73, 1),
    tabActiveColor: Color.fromRGBO(44, 74, 125, 1),
    qrBg: Color.fromRGBO(8, 18, 34, 1),
    primaryLinkColor: Color.fromRGBO(131, 171, 246, 1),
  );

  static void toggleTheme() => AppBloc.appCubit
      .changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);

  static ThemeMode get platformThemeMode =>
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;

  static ThemeMode get currentThemeMode {
    final stateMode = AppBloc.appCubit.state.themeMode;
    if (stateMode == ThemeMode.system) return platformThemeMode;
    return stateMode;
  }

  static bool get isDarkMode => currentThemeMode == ThemeMode.dark;

  static SystemUiOverlayStyle get overlayStyle =>
      isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

  static Color invert(Color darkColor, Color lightColor) =>
      isDarkMode ? darkColor : lightColor;

  static AppColorSchema get colors => isDarkMode ? darkColors : lightColors;

  static ThemeData get lightTheme => buildTheme(lightColors);

  static ThemeData get darkTheme => buildTheme(darkColors);

  static ThemeData buildTheme(AppColorSchema colors) {
    return ThemeData(
      textTheme: GoogleFonts.montserratTextTheme()
          .apply(bodyColor: colors.primaryTextColor),
    );
  }
}
