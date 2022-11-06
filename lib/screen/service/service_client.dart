import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '_service.dart';

class ClientService extends ValueNotifier<ClientState> {
  ClientService([ClientState value = const InitClientState()]) : super(value);

  static ClientService? _instance;

  static ClientService instance([ClientState state = const InitClientState()]) {
    return _instance ??= ClientService(state);
  }

  void handle(ClientEvent event) => event._execute(this);

  Future<void> handleSync(ClientEvent event) => event._execute(this);

  void onState(ValueChanged<ClientState> callBack) => callBack(value);
}

abstract class ClientEvent {
  const ClientEvent();

  Future<void> _execute(ClientService service);
}

class LoginClient extends ClientEvent {
  const LoginClient({
    required this.phoneNumber,
    required this.token,
  });

  final String phoneNumber;
  final String token;

  String get url => '${RepositoryService.httpURL}/v1/api/client/auth';

  @override
  Future<void> _execute(ClientService service) async {
    service.value = const PendingClientState();
    try {
      final body = {'phone_number': phoneNumber, 'firebase_token': token};
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
          final data = await compute(ClientSchema.fromJson, response.body);
          service.value = ClientItemState(data: data);
          break;
        case 404:
          service.value = NoClientItemState(
            phoneNumber: phoneNumber,
            token: token,
          );
          break;
        default:
          service.value = FailureClientState(
            message: 'internal error',
            event: this,
          );
      }
    } catch (error) {
      service.value = FailureClientState(
        message: error.toString(),
        event: this,
      );
    }
  }
}

class RegisterClient extends ClientEvent {
  const RegisterClient({
    required this.phoneNumber,
    required this.fullName,
    required this.token,
  });

  final String phoneNumber;
  final String fullName;
  final String token;

  String get url => '${RepositoryService.httpURL}/v1/api/client/register';

  @override
  Future<void> _execute(ClientService service) async {
    service.value = const PendingClientState();
    try {
      final body = {'phone_number': phoneNumber, 'firebase_token': token, 'full_name': fullName};
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
          final data = await compute(ClientSchema.fromJson, response.body);
          service.value = ClientItemState(data: data);
          break;
        case 404:
          service.value = NoClientItemState(
            phoneNumber: phoneNumber,
            token: token,
          );
          break;
        default:
          service.value = FailureClientState(
            message: response.body,
            event: this,
          );
      }
    } catch (error) {
      service.value = FailureClientState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
