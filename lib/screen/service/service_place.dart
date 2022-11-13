import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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

  static CancelToken? _cancelToken;

  @override
  Future<void> _execute(PlaceService service) async {
    scheduleMicrotask(() async {
      service.value = const PendingPlaceState();
      try {
        final body = {'location_name': query, 'long': long, 'lat': lat};
        _cancelToken?.cancel();
        _cancelToken = CancelToken();
        final response = await Dio().postUri<String>(
          Uri.parse(url),
          data: jsonEncode(body),
          cancelToken: _cancelToken,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
        );
        switch (response.statusCode) {
          case 200:
            final data = await compute(PlaceSchema.fromRawJsonList, response.data!);
            service.value = PlaceItemListState(data: data);
            break;
          default:
            service.value = FailurePlaceState(
              message: response.data!,
              event: this,
            );
        }
      } catch (error) {
        if (error is DioError && error.type == DioErrorType.cancel) {
          service.value = CancelFailurePlaceState(
            message: error.toString(),
            event: this,
          );
        } else {
          service.value = FailurePlaceState(
            message: error.toString(),
            event: this,
          );
        }
      }
    });
  }
}

class GetReverseGeocoding extends PlaceEvent {
  const GetReverseGeocoding({
    required this.long,
    required this.lat,
  });

  final double long;
  final double lat;

  String get url => '${RepositoryService.httpURL}/v1/api/reverse';

  static CancelToken? _cancelToken;

  @override
  Future<void> _execute(PlaceService service) async {
    scheduleMicrotask(() async {
      service.value = const PendingPlaceState();
      try {
        final body = {'long': long, 'lat': lat};
        _cancelToken?.cancel();
        _cancelToken = CancelToken();
        final response = await Dio().postUri<String>(
          Uri.parse(url),
          data: jsonEncode(body),
          cancelToken: _cancelToken,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
        );
        switch (response.statusCode) {
          case 200:
            final data = await compute(PlaceSchema.fromRawJsonList, response.data!);
            service.value = PlaceItemListState(data: data);
            break;
          default:
            service.value = FailurePlaceState(
              message: response.data!,
              event: this,
            );
        }
      } catch (error) {
        if (error is DioError && error.type == DioErrorType.cancel) {
          service.value = CancelFailurePlaceState(
            message: error.toString(),
            event: this,
          );
        } else {
          service.value = FailurePlaceState(
            message: error.toString(),
            event: this,
          );
        }
      }
    });
  }
}
