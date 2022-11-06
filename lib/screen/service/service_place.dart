import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '_service.dart';

class PlaceService extends ValueNotifier<PlaceState> {
  PlaceService([PlaceState value = const InitPlaceState()]) : super(value);

  static PlaceService? _instance;

  static PlaceService instance([PlaceState state = const InitPlaceState()]) {
    return _instance ??= PlaceService(state);
  }

  Future<void> handle(PlaceEvent event) => event._execute(this);

  void onState(ValueChanged<PlaceState> callBack) => callBack(value);
}

abstract class PlaceEvent {
  const PlaceEvent();

  Future<void> _execute(PlaceService service);
}

class GetGeocoding extends PlaceEvent {
  const GetGeocoding({
    required this.query,
    required this.long,
    required this.lat,
  });

  final String query;
  final double long;
  final double lat;

  String get url => '${RepositoryService.httpURL}/v1/api/location';

  @override
  Future<void> _execute(PlaceService service) async {
    service.value = const PendingPlaceState();
    try {
      final body = {'location_name': query, 'long': long, 'lat': lat};
      final response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final data = await compute(PlaceSchema.fromRawJsonList, response.body);
          service.value = PlaceItemListState(data: data);
          break;
        default:
          service.value = FailurePlaceState(
            message: response.body,
            event: this,
          );
      }
    } catch (error) {
      service.value = FailurePlaceState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
