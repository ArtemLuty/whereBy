import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppLocale {
  static dynamic _provider;

  static String get currentLanguage {
    final locale = _provider.locale as Locale;
    return locale.languageCode;
  }

  static List<Locale> supportedLocales = [
    const Locale.fromSubtags(languageCode: 'en'),
    const Locale.fromSubtags(languageCode: 'ru'),
  ];

  static List<LocalizationsDelegate> localizationsDelegates =
      _provider.delegates as List<LocalizationsDelegate>;

  static Future<void> resetToSystemLanguage() {
    final sysLocale = Platform.localeName.split('_');
    return changeLanguage(sysLocale[0]);
  }

  static Future<void> changeLanguage(String language) async {
    if (supportedLocales.contains(Locale(language))) {
      return _provider.setLocale(Locale(language)) as Future<void>;
    }
    return _provider.setLocale(supportedLocales[0]) as Future<void>;
  }

  static Widget localizeApp({required Widget app}) {
    return EasyLocalization(
      path: 'assets/locale',
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      supportedLocales: AppLocale.supportedLocales,
      fallbackLocale: AppLocale.supportedLocales[0],
      child: Builder(
        builder: (context) {
          _provider = EasyLocalization.of(context);
          return app;
        },
      ),
    );
  }
}
