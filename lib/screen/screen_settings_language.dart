import 'package:flutter/material.dart';

import '_screen.dart';

class SettingsLanguageScreen extends StatefulWidget {
  const SettingsLanguageScreen({
    super.key,
    this.locale,
  });

  static const String name = 'settings_language';
  static const String path = 'language';

  final Locale? locale;

  @override
  State<SettingsLanguageScreen> createState() => _SettingsLanguageScreenState();
}

class _SettingsLanguageScreenState extends State<SettingsLanguageScreen> {
  /// LocaleService
  late List<Locale> _localeItems;
  late final LocaleService _localeService;

  @override
  void initState() {
    super.initState();
    _localeService = LocaleService.instance();
    _localeItems = CustomBuildContext.supportedLocales;
  }

  String _language(String languageCode) {
    final localizations = context.localizations;
    switch (languageCode) {
      case 'fr':
        return localizations.french;
      default:
        return localizations.english;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsLanguageAppBar(),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          final item = _localeItems[index];
          return ContactCheckListTile(
            value: widget.locale == item,
            onChanged: (value) {
              _localeService.value = item;
              Navigator.pop(context);
            },
            title: Text(_language(item.languageCode).capitalize()),
          );
        },
        itemCount: _localeItems.length,
      ),
    );
  }
}
