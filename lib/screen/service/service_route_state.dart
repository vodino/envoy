import '_service.dart';

abstract class RouteState {
  const RouteState();
}

class InitRouteState extends RouteState {
  const InitRouteState();
}

class PendingRouteState extends RouteState {
  const PendingRouteState();
}

class FailureRouteState extends RouteState {
  const FailureRouteState({
    required this.message,
    this.event,
  });
  final RouteEvent? event;
  final String message;
}

class RouteItemState extends RouteState {
  const RouteItemState({
    this.duration,
    required this.routes,
    required this.points,
  });
  final int? duration;
  final List<Routes> routes;
  final List<Waypoints> points;
}
