import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum SupportedLocale {
  en,
  de,
  pl,
  zh,
}

class Utils {
  static Locale currentLocale(BuildContext context) {
    return context.locale;
  }

  static void changeLocale(
      BuildContext context, SupportedLocale supportedLocale) {
    Locale locale;

    switch (supportedLocale) {
      case SupportedLocale.en:
        locale = Locale('en');
        break;
      case SupportedLocale.de:
        locale = Locale('de');
        break;
      case SupportedLocale.pl:
        locale = Locale('pl');
        break;
      case SupportedLocale.zh:
        locale = Locale('zh');
        break;
      default:
        locale = Locale('en');
        break;
    }

    EasyLocalization.of(context).setLocale(locale);

    // EasyLocalization.of(context).locale = locale;
  }
}
