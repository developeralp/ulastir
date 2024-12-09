import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localizer {
  static final Localizer _singleton = Localizer._internal();

  static Localizer get i => _singleton;

  factory Localizer() {
    return _singleton;
  }

  Localizer._internal();

  late Map<dynamic, dynamic> _localisedValues;

  Future<Localizer> load(Locale locale) async {
    String jsonContent = await rootBundle
        .loadString("assets/locale/${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return this;
  }

  String text(String key) {
    return _localisedValues[key] ?? '$key not found';
  }
}

class LocalizerDelegate extends LocalizationsDelegate<Localizer> {
  const LocalizerDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<Localizer> load(Locale locale) {
    return Localizer.i.load(locale);
  }

  @override
  bool shouldReload(LocalizerDelegate old) => true;
}
