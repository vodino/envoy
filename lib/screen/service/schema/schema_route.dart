import 'dart:convert';

import 'package:maplibre_gl/mapbox_gl.dart';

class RouteResult {
  const RouteResult({
    required this.code,
    required this.routes,
    required this.waypoints,
  });

  static const String codeKey = 'code';
  static const String routesKey = 'routes';
  static const String waypointsKey = 'waypoints';

  final String code;
  final List<Routes> routes;
  final List<Waypoints> waypoints;

  static RouteResult fromMap(Map<String, dynamic> data) {
    return RouteResult(
      waypoints: List.from(data[waypointsKey]).map((e) => Waypoints.fromMap(e)).toList(),
      routes: List.from(data[routesKey]).map((e) => Routes.fromMap(e)).toList(),
      code: data[codeKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      waypointsKey: waypoints,
      routesKey: routes,
      codeKey: code,
    };
  }

  static RouteResult fromJson(String data) {
    return fromMap(jsonDecode(data));
  }

  static RouteResult fromServerJson(String data) {
    return fromMap(jsonDecode(data)['data']);
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class Routes {
  const Routes({
    this.legs,
    this.weightName,
    this.weight,
    this.duration,
    this.distance,
    this.geometry,
  });

  static const String geometryKey = 'geometry';
  static const String legsKey = 'legs';
  static const String weightNameKey = 'weight_name';
  static const String weightKey = 'weight';
  static const String durationKey = 'duration';
  static const String distanceKey = 'distance';

  final Geometry? geometry;
  final List<Legs>? legs;
  final String? weightName;
  final double? weight;
  final int? duration;
  final double? distance;

  static Routes fromMap(Map<String, dynamic> data) {
    return Routes(
      legs: (data[legsKey] as List?)?.map((e) => Legs.fromMap(e)).toList(),
      distance: (data[distanceKey] as num?)?.toDouble(),
      duration: (data[durationKey] as num?)?.toInt(),
      weight: (data[weightKey] as num?)?.toDouble(),
      geometry: Geometry.fromMap(data[geometryKey]),
      weightName: data[weightNameKey],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      weightNameKey: weightName,
      geometryKey: geometry,
      durationKey: duration,
      distanceKey: distance,
      weightKey: weight,
      legsKey: legs,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class Legs {
  const Legs({
    this.steps,
    this.summary,
    this.weight,
    this.duration,
    this.distance,
  });

  static const String stepsKey = 'steps';
  static const String summaryKey = 'summary';
  static const String weightKey = 'weight';
  static const String durationKey = 'duration';
  static const String distanceKey = 'distance';

  final List<dynamic>? steps;
  final String? summary;
  final double? weight;
  final int? duration;
  final double? distance;

  static Legs fromMap(Map<String, dynamic> data) {
    return Legs(
      distance: (data[distanceKey] as num?)?.toDouble(),
      duration: (data[durationKey] as num?)?.toInt(),
      weight: (data[weightKey] as num?)?.toDouble(),
      steps: (data[stepsKey] as List?),
      summary: data[summaryKey],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      durationKey: duration,
      distanceKey: distance,
      summaryKey: summary,
      weightKey: weight,
      stepsKey: steps,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class Geometry {
  const Geometry({
    this.coordinates,
  });

  static const String coordinatesKey = 'coordinates';

  final List<LatLng>? coordinates;

  static Geometry fromMap(Map<String, dynamic> data) {
    return Geometry(
      coordinates: (data[coordinatesKey] as List?)?.map((e) => LatLng(e[1], e[0])).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      coordinatesKey: coordinates,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class Waypoints {
  const Waypoints({
    this.hint,
    this.distance,
    this.name,
    this.location,
  });

  static const String hintKey = 'hint';
  static const String distanceKey = 'distance';
  static const String nameKey = 'name';
  static const String locationKey = 'locations';

  final String? hint;
  final double? distance;
  final String? name;
  final List<double>? location;

  static Waypoints fromMap(Map<String, dynamic> data) {
    return Waypoints(
      location: (data[locationKey] as List?)?.map((e) => e as double).toList(),
      distance: (data[distanceKey] as num?)?.toDouble(),
      hint: data[hintKey],
      name: data[nameKey],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      locationKey: location,
      distanceKey: distance,
      hintKey: hint,
      nameKey: name,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
