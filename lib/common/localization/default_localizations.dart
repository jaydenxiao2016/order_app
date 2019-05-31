import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:order_app/common/style/string_base.dart';
import 'package:order_app/common/style/string_de.dart';
import 'package:order_app/common/style/string_en.dart';
import 'package:order_app/common/style/string_zh.dart';

///自定义多语言实现
class MyLocalizations {
  final Locale locale;

  MyLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  static Map<String, StringBase> _localizedValues = {
    'de': new StringDe(),
    'en': new StringEn(),
    'zh': new StringZh(),
  };

  ///当前语言
  StringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  ///通过 Localizations 加载当前的 Localizations
  ///获取对应的 StringBase
  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, MyLocalizations);
  }
}
