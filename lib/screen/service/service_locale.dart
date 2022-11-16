import 'package:flutter/widgets.dart';

class LocaleService extends ValueNotifier<Locale?> {
  LocaleService([Locale? value]) : super(value);

  static LocaleService? _instance;
  static LocaleService instance([Locale? value]) {
    return _instance ??= LocaleService(value);
  }
}
