import 'package:flutter/widgets.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/i18n/strings/en_us.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/i18n/strings/pr_br.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/i18n/strings/translations.dart';


class R {
  static Translations  strings = PtBr();

  static void load(Locale locale) {
    switch (locale.toString()) {
      case "en_US":
        strings = EnUs();
        break;
      default:
      strings = PtBr();
    }
  }
}
