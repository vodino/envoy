class RouteResult {
  RouteResult({
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
      routes: List.from(data[waypointsKey]).map((e) => Routes.fromMap(e)).toList(),
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

  @override
  String toString() {
    return toMap().toString();
  }
}

class Routes {
  Routes({
    required this.legs,
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  static const String legsKey = 'legs';
  static const String weightNameKey = 'weight_name';
  static const String weightKey = 'weight';
  static const String durationKey = 'duration';
  static const String distanceKey = 'distance';

  late final List<Legs> legs;
  late final String weightName;
  late final double weight;
  late final int duration;
  late final double distance;

  static Routes fromMap(Map<String, dynamic> data) {
    return Routes(
      legs: List.from(data[legsKey]).map((e) => Legs.fromMap(e)).toList(),
      weightName: data[weightNameKey],
      distance: data[distanceKey],
      duration: data[durationKey],
      weight: data[weightKey],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      weightNameKey: weightName,
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
  Legs({
    required this.steps,
    required this.summary,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  static const String stepsKey = 'steps';
  static const String summaryKey = 'summary';
  static const String weightKey = 'weight';
  static const String durationKey = 'duration';
  static const String distanceKey = 'distance';

  late final List<dynamic> steps;
  late final String summary;
  late final double weight;
  late final double duration;
  late final int? distance;

  static Legs fromMap(Map<String, dynamic> data) {
    return Legs(
      steps: List.castFrom<dynamic, dynamic>(data[stepsKey]),
      distance: data[distanceKey],
      duration: data[durationKey],
      summary: data[summaryKey],
      weight: data[weightKey],
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

class Waypoints {
  Waypoints({
    required this.hint,
    required this.distance,
    required this.name,
    required this.location,
  });
  static const String hintKey = 'hint';
  static const String distanceKey = 'distance';
  static const String nameKey = 'name';
  static const String locationKey = 'locations';

  late final String hint;
  late final double distance;
  late final String name;
  late final List<double> location;

  static Waypoints fromMap(Map<String, dynamic> data) {
    return Waypoints(
      location: List.castFrom<dynamic, double>(data[locationKey]),
      distance: data[distanceKey],
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
