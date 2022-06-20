import 'package:flutter/material.dart';
import 'package:aquaman/utilities/utils.dart';
import 'package:aquaman/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:aquaman/utilities/constants.dart';

class LanguageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(95, 103, 113, 1),
      child: Container(
        height: 0.35 * MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          vertical: 0.02 * MediaQuery.of(context).size.height,
          horizontal: 0.045 * MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.01 * MediaQuery.of(context).size.height,
              ),
              child: Text(
                LocaleKeys.settings_language.tr(),
                style: kBodyTitle(context),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  /// emojis from: https://emojipedia.org/flags/

                  LanguageListTile(
                    languageEmoji: '🇺🇸',
                    languageName: 'English',
                    showCheck: Utils.currentLocale(context) == Locale('en'),
                    locale: SupportedLocale.en,
                  ),

                  LanguageListTile(
                    languageEmoji: '🇩🇪',
                    languageName: 'Deutsch',
                    showCheck: Utils.currentLocale(context) == Locale('de'),
                    locale: SupportedLocale.de,
                  ),
                  LanguageListTile(
                    languageEmoji: '🇹🇼',
                    languageName: '繁體中文',
                    showCheck: Utils.currentLocale(context) == Locale('pl'),
                    locale: SupportedLocale.pl,
                  ),
                  LanguageListTile(
                    languageEmoji: '🇨🇳',
                    languageName: '简体中文',
                    showCheck: Utils.currentLocale(context) == Locale('zh'),
                    locale: SupportedLocale.zh,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageListTile extends StatelessWidget {
  const LanguageListTile({
    Key key,
    @required this.languageEmoji,
    @required this.languageName,
    @required this.showCheck,
    @required this.locale,
  }) : super(key: key);

  final String languageEmoji;
  final String languageName;
  final bool showCheck;
  final SupportedLocale locale;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        languageEmoji,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      title: Text(languageName, style: kBodyTitle(context)),
      trailing: showCheck
          ? Icon(
              Icons.check,
            )
          : null,
      onTap: () {
        Utils.changeLocale(context, locale);
      },
    );
  }
}
