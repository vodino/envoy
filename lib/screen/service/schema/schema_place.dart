import 'dart:convert';

import 'package:equatable/equatable.dart';

part 'schema_placeraw.dart';

enum PlaceCategory {
  source,
  destination;

  static PlaceCategory fromString(String value) {
    switch (value) {
      case 'source':
        return source;
      case 'destination':
        return destination;
      default:
        throw ('$value is not a type of PlaceCategory');
    }
  }

  @override
  String toString() {
    switch (this) {
      case source:
        return 'source';
      default:
        return 'destination';
    }
  }
}

enum PlaceType {
  reverseGeocoding,
  geocoding;

  bool isGeocoding() {
    return this == geocoding;
  }
}

class PlaceSchema extends Equatable {
  const PlaceSchema({
    this.title,
    this.extent,
    this.subtitle,
    this.latitude,
    this.longitude,
    this.countryCode,
  });

  static const titleKey = 'title';
  static const extentKey = 'extent';
  static const subtitleKey = 'subtitle';
  static const latitudeKey = 'latitude';
  static const longitudeKey = 'longitude';
  static const countryCodeKey = 'countryCode';

  final String? title;
  final String? subtitle;
  final double? latitude;
  final double? longitude;
  final String? countryCode;
  final List<double>? extent;

  @override
  List<Object?> get props => [
        title,
        extent,
        subtitle,
        latitude,
        longitude,
        countryCode,
      ];

  PlaceSchema copyWith({
    String? title,
    String? subtitle,
    double? latitude,
    double? longitude,
    String? countryCode,
    List<double>? extent,
  }) {
    return PlaceSchema(
      title: title ?? this.title,
      extent: extent ?? this.extent,
      subtitle: subtitle ?? this.subtitle,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  PlaceSchema clone() {
    return copyWith(
      title: title,
      extent: extent,
      subtitle: subtitle,
      latitude: latitude,
      longitude: longitude,
      countryCode: countryCode,
    );
  }

  static PlaceSchema fromMap(Map<String, dynamic> data) {
    return PlaceSchema(
      title: data[titleKey],
      subtitle: data[subtitleKey],
      latitude: data[latitudeKey],
      longitude: data[longitudeKey],
      extent: data[extentKey].cast<double>(),
      countryCode: data[countryCodeKey].cast<String, String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      titleKey: title,
      extentKey: extent,
      subtitleKey: subtitle,
      latitudeKey: latitude,
      longitudeKey: longitude,
      countryCodeKey: countryCode,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static PlaceSchema fromJson(String value) {
    return fromMap(jsonDecode(value));
  }

  static List<PlaceSchema> fromJsonList(String value) {
    return List.of(
      (jsonDecode(value) as List).map((map) => fromMap(map)),
    );
  }

  static List<PlaceSchema> fromRawJsonList(String value) {
    final result = _PlaceResult.fromJson(value);
    return List.of(
      (result.features!.map((e) {
        final properties = e.properties;
        return PlaceSchema(
          title: '${properties?.name} ${properties?.state}, '
              '${properties?.country}',
          extent: properties?.extent,
          countryCode: properties?.countryCode,
          latitude: e.geometry?.coordinates?[0],
          longitude: e.geometry?.coordinates?[0],
        );
      })),
    );
  }

  static String toJsonList(List<PlaceSchema> value) {
    return jsonEncode(List.of(value.map((e) => e.toMap())));
  }

  @override
  String toString() {
    return '$title: ($latitude, $longitude)';
  }
}
