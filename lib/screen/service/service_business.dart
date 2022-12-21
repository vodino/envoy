import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '_service.dart';

class BusinessService extends ValueNotifier<BusinessState> {
  BusinessService([BusinessState value = const InitBusinessState()]) : super(value);

  static BusinessService? _instance;
  static BusinessService instance([BusinessState state = const InitBusinessState()]) {
    return _instance ??= BusinessService(state);
  }

  Future<void> handle(BusinessEvent event) => event._execute(this);
}

abstract class BusinessEvent {
  const BusinessEvent();

  Future<void> _execute(BusinessService service);
}

class QueryBusinessRequestList extends BusinessEvent {
  const QueryBusinessRequestList();

  String get _url => '${RepositoryService.httpURL}/v1/api/request';

  @override
  Future<void> _execute(BusinessService service) async {
    service.value = const PendingBusinessState();
    try {
      final client = ClientService.authenticated!;
      final token = client.accessToken;
      final response = await Dio().getUri<String>(
        Uri.parse(_url),
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      switch (response.statusCode) {
        case 200:
          final data = await compute(RequestSchema.fromListJson, response.data!);
          service.value = RequestItemListBusinessState(data: data);
          break;
        default:
          service.value = FailureBusinessState(
            message: 'internal',
            event: this,
          );
      }
    } catch (error) {
      service.value = FailureBusinessState(
        message: error.toString(),
        event: this,
      );
    }
  }
}

class SendBusinessMessage extends BusinessEvent {
  const SendBusinessMessage({
    required this.message,
    required this.requestId,
    required this.phoneNumber,
  });

  final String phoneNumber;
  final int requestId;
  final String message;

  String get _url => '${RepositoryService.httpURL}/v1/api/business';

  @override
  Future<void> _execute(BusinessService service) async {
    service.value = const PendingBusinessState();
    try {
      final client = ClientService.authenticated!;
      final token = client.accessToken;
      final body = {
        'message': message,
        'request_id': requestId,
        'phone_number': phoneNumber,
      };
      final response = await Dio().postUri<String>(
        Uri.parse(_url),
        data: jsonEncode(body),
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      switch (response.statusCode) {
        case 200:
          service.value = const MessageSended();
          break;
        default:
          service.value = FailureBusinessState(
            message: 'internal',
            event: this,
          );
      }
    } catch (error) {
      service.value = FailureBusinessState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
