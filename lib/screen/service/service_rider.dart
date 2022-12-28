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

class GetAvailableRiders extends RiderEvent {
  const GetAvailableRiders({
    required this.source,
    required this.destination,
  });

  final LatLng source;
  final LatLng destination;

  String get url => '${RepositoryService.httpURL}/v1/api/riders/available';

  @override
  Future<void> _execute(RiderService service) async {
    service.value = const PendingRiderState();
    try {
      final body = {
        'lat_from': source.latitude,
        'long_from': source.longitude,
        'lat_to': destination.latitude,
        'long_to': destination.longitude,
      };
      final response = await Dio().postUri<String>(
        Uri.parse(url),
        data: jsonEncode(body),
        options: Options(headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }),
      );
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

class SendOrderToRider extends RiderEvent {
  const SendOrderToRider({required this.client});

  final Client client;

  String get _url => 'https://fcm.googleapis.com/fcm/send';

  @override
  Future<void> _execute(RiderService service) async {
    service.value = const PendingRiderState();
    try {
      final body = <String, dynamic>{};
      final response = await Dio().postUri(
        Uri.parse(_url),
        data: jsonEncode(body),
        options: Options(headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAA55CoBZc:APA91bGllEw9yVKfo8S9Reylfs4VQJ8WKRAPYQtZwnsL4R4l1DAR6anH1MrX5iFFUWPgw6xnU833HQ_qz9Rh1iAnqQlHeaIDctDG-e05t7YvWsmoFwjW135nBL2dsoAF6iNF_uWnEzha',
        }),
      );
      switch (response.statusCode) {
        case 200:
          break;
        default:
      }
    } catch (error) {
      service.value = FailureRiderState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
