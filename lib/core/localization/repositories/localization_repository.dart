import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/localization/models/i18n_model.dart';

class LocalizationRepository extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {};

  static Future<void> initializeLanguages() async {
    final keys = await readJson();
    Get.clearTranslations();
    Get.addTranslations(keys);
  }

  static Future<Map<String, Map<String, String>>> readJson() async {
    final resEn = await rootBundle.loadString('lang/en.json');
    final resEs = await rootBundle.loadString('lang/es.json');

    Map<String, dynamic> dataEn = jsonDecode(resEn);
    Map<String, dynamic> dataEs = jsonDecode(resEs);

    final english = I18nModel.fromJson(dataEn, "en");
    final spanish = I18nModel.fromJson(dataEs, "es");

    final keys = <String, Map<String, String>>{};

    keys.addAll({english.code!: english.texts!});
    keys.addAll({spanish.code!: spanish.texts!});

    return keys;
  }

  static List<Locale> get supportedLocales {
    return const [
      Locale('en', 'US'),
      Locale('es', 'ES'),
    ];
  }

  static Locale localeResolutionCallback(
      Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.first;
    }
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }

    return supportedLocales.first;
  }
}
