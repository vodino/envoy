import 'package:flutter/foundation.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_service.dart';

class RouteService extends ValueNotifier<RouteState> {
  RouteService([RouteState value = const InitRouteState()]) : super(value);

  static RouteService? _instance;

  static RouteService instance([RouteState value = const InitRouteState()]) {
    return _instance ??= RouteService(value);
  }

  Future<void> handle(RouteEvent event) => event._execute(this);

  void onState(ValueChanged<RouteState> callBack) => callBack(value);
}

abstract class RouteEvent {
  const RouteEvent();

  Future<void> _execute(RouteService service);
}

class GetRoute extends RouteEvent {
  const GetRoute({
    required this.destination,
    required this.source,
  });

  final LatLng source;
  final LatLng destination;

  String get _url => 'http://router.project-osrm.org/route/v1/driving$_route';

  String get _route => '${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}';

  @override
  Future<void> _execute(RouteService service) async {}
}
