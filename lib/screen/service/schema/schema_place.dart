import 'dart:convert';

import 'package:equatable/equatable.dart';

part 'schema_placeraw.dart';

enum PlaceCategory {
  source('source'),
  destination('destination');

  const PlaceCategory(this.value);

  final String value;
}

enum PlaceType {
  reverseGeocoding,
  geocoding;

  bool isGeocoding() {
    return this == geocoding;
  }
}

enum PlaceOsmTag {
  unknown,

  ///
  neighbourhood,
  bridleway,
  busStop,
  construction,
  cycleway,
  distanceMarker,
  emergencyAccessPoint,
  footway,
  gate,
  motorwayJunction,
  path,
  pedestrian,
  platform,
  primary,
  primaryLink,
  raceway,
  road,
  secondary,
  secondaryLink,
  services,
  steps,
  tertiary,
  track,
  trail,
  trunk,
  trunkLink,
  unsurfaced,

  ///
  airport,
  atm,
  auditorium,
  bank,
  bar,
  bench,
  brothel,
  cafe,
  casino,
  cinema,
  clinic,
  club,
  college,
  courthouse,
  crematorium,
  dentist,
  doctors,
  dormitory,
  embassy,
  fastFood,
  ferryTerminal,
  fountain,
  fuel,
  hall,
  hospital,
  hotel,
  kindergarten,
  library,
  market,
  marketplace,
  nightclub,
  nursery,
  office,
  park,
  parking,
  pharmacy,
  police,
  preschool,
  prison,
  pub,
  publicMarket,
  restaurant,
  sauna,
  school,
  shelter,
  shop,
  shopping,
  studio,
  supermarket,
  taxi,
  telephone,
  theatre,
  toilets,
  townhall,
  university,
  veterinary,
  wifi,
  administrative,
  military,

  ///
  house,
  education,
  placeOfWorship;

  static PlaceOsmTag fromString(String value) {
    switch (value) {
      case 'locality':
      case 'neighbourhood':
        return neighbourhood;
      case 'bus_stop':
      case 'bus_station':
        return busStop;
      case 'place_of_worship':
        return placeOfWorship;
      case 'pharmacy':
        return pharmacy;
      case 'pub':
        return pub;
      case 'shop':
      case 'shopping':
        return shop;
      case 'airport':
        return airport;
      case 'hotel':
        return hotel;
      case 'house':
        return house;
      case 'school':
        return school;
      case 'education':
        return education;
      case 'university':
        return university;
      case 'supermarket':
        return supermarket;
      case 'public_market':
        return publicMarket;
      case 'hospital':
      case 'health_centre':
        return hospital;
      case 'restaurant':
        return restaurant;
      case 'police':
        return police;
      case 'military':
        return military;
      case 'cinema':
        return cinema;
      case 'embassy':
        return embassy;
      default:
        return unknown;
    }
  }
}

class PlaceSchema extends Equatable {
  const PlaceSchema({
    this.title,
    this.extent,
    this.subtitle,
    this.latitude,
    this.longitude,
    this.osmTag,
  });

  static const titleKey = 'title';
  static const extentKey = 'extent';
  static const subtitleKey = 'subtitle';
  static const latitudeKey = 'latitude';
  static const longitudeKey = 'longitude';
  static const osmTagKey = 'osmTag';

  final String? title;
  final String? subtitle;
  final double? latitude;
  final double? longitude;
  final PlaceOsmTag? osmTag;
  final List<double>? extent;

  @override
  List<Object?> get props => [
        title,
        extent,
        subtitle,
        latitude,
        longitude,
        osmTag,
      ];

  PlaceSchema copyWith({
    String? title,
    String? subtitle,
    double? latitude,
    double? longitude,
    PlaceOsmTag? osmTag,
    List<double>? extent,
  }) {
    return PlaceSchema(
      title: title ?? this.title,
      extent: extent ?? this.extent,
      subtitle: subtitle ?? this.subtitle,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      osmTag: osmTag ?? this.osmTag,
    );
  }

  PlaceSchema clone() {
    return copyWith(
      title: title,
      extent: extent,
      subtitle: subtitle,
      latitude: latitude,
      longitude: longitude,
      osmTag: osmTag,
    );
  }

  static PlaceSchema fromMap(Map<String, dynamic> data) {
    return PlaceSchema(
      title: data[titleKey],
      subtitle: data[subtitleKey],
      latitude: data[latitudeKey],
      longitude: data[longitudeKey],
      extent: data[extentKey].cast<double>(),
      osmTag: data[osmTagKey].cast<String, String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      titleKey: title,
      extentKey: extent,
      subtitleKey: subtitle,
      latitudeKey: latitude,
      longitudeKey: longitude,
      osmTagKey: osmTag,
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
        final properties = e.properties!;
        List<String> subtitles = [];
        if (properties.locality != null) subtitles.add(properties.locality!);
        if (properties.city != null) subtitles.add(properties.city!);
        if (properties.state != null) subtitles.add(properties.state!);
        if (properties.country != null) subtitles.add(properties.country!);

        return PlaceSchema(
          title: properties.name,
          extent: properties.extent,
          subtitle: subtitles.join(', '),
          latitude: (e.geometry?.coordinates?[1])?.toDouble(),
          longitude: (e.geometry?.coordinates?[0])?.toDouble(),
          osmTag: PlaceOsmTag.fromString(properties.osmValue!),
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
