import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_service.dart';

class RiderService extends ValueNotifier<RiderState> {
  RiderService([RiderState value = const InitRiderState()]) : super(value);

  static RiderService? _instance;

  static RiderService instance([RiderState value = const InitRiderState()]) {
    return _instance ??= RiderService(value);
  }

  Future<void> handle(RiderEvent event) => event._execute(this);
}

abstract class RiderEvent {
  const RiderEvent();

  Future<void> _execute(RiderService service);
}

class GetRiderAvailable extends RiderEvent {
  const GetRiderAvailable({
    required this.source,
  });

  final LatLng source;

  String get url => '${RepositoryService.httpURL}/v1/api/riders/available';

  @override
  Future<void> _execute(RiderService service) async {
    service.value = const PendingRiderState();
    try {
      final body = {'lat': source.latitude, 'long': source.longitude};
      final response = await Dio().postUri<String>(Uri.parse(url), data: jsonEncode(body));
      final data = await compute(RiderResultSchema.fromJson, response.data!);
      service.value = RiderItemState(data: data);
    } catch (error) {
      service.value = FailureRiderState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
