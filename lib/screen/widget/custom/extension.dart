import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

extension CustomBuildContext on BuildContext {
  bool isPortrait(Orientation orientation) {
    return orientation == Orientation.portrait;
  }

  bool isLandscape(Orientation orientation) {
    return orientation == Orientation.landscape;
  }

  MediaQueryData get mediaQuery {
    return MediaQuery.of(this);
  }

  ThemeData get theme {
    return Theme.of(this);
  }

  CupertinoThemeData get cupertinoTheme {
    return CupertinoTheme.of(this);
  }

  static List<Locale> get supportedLocales {
    return AppLocalizations.supportedLocales;
  }

  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    return AppLocalizations.localizationsDelegates;
  }

  AppLocalizations get localizations {
    return AppLocalizations.of(this)!;
  }
}

extension CustomString on String {
  String toUTF8() {
    return utf8.decode(codeUnits);
  }

  String capitalize() {
    if (isNotEmpty) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }
    return this;
  }

  String trimSpace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  static String toFlag(String value) {
    return String.fromCharCodes(
      List.of(value.toUpperCase().codeUnits.map((code) => code + 127397)),
    );
  }
}

extension CustomList<T> on List<T> {
  List<List<T>> group(bool Function(T element, T value) combine) {
    final result = List<List<T>>.empty(growable: true);
    for (var i = 0; i < length; i++) {
      final element = elementAt(i);
      final items = [element];
      for (var j = length - 1; j > i; j--) {
        final value = elementAt(j);
        if (combine(element, value)) {
          items.add(value);
          removeAt(j);
        }
      }
      result.add(items);
    }
    return result;
  }
}

extension CustomLatLng on LatLng {
  String distance(LatLng latLng) {
    const p = 0.017453292519943295;
    final a = 0.5 - cos((latLng.latitude - latitude) * p) / 2 + cos(latitude * p) * cos(latLng.latitude * p) * (1 - cos((latLng.longitude - longitude) * p)) / 2;
    final result = 12742 * asin(sqrt(a));
    return result >= 0.0 && result <= 1.0 ? '${(result*1000).toStringAsFixed(1)} M' : '${result.toStringAsFixed(1)} Km';
  }
}
