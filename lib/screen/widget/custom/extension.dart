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
  static const num earthRadius = 6371009.0;
  double distance(LatLng to) {
    num arcHav(num x) => 2 * asin(sqrt(x));
    num hav(num x) => sin(x * 0.5) * sin(x * 0.5);
    num toRadians(num degrees) => degrees / 180.0 * pi;
    num havDistance(num lat1, num lat2, num dLng) => hav(lat1 - lat2) + hav(dLng) * cos(lat1) * cos(lat2);

    num distanceRadians(num lat1, num lng1, num lat2, num lng2) => arcHav(havDistance(lat1, lat2, lng1 - lng2));
    num computeAngleBetween(LatLng from, LatLng to) => distanceRadians(toRadians(from.latitude), toRadians(from.longitude), toRadians(to.latitude), toRadians(to.longitude));

    return (computeAngleBetween(this, to) * earthRadius).toDouble();
  }
}
