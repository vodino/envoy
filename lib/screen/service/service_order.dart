import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '_service.dart';

class OrderService extends ValueNotifier<OrderState> {
  OrderService([OrderState value = const InitOrderState()]) : super(value);

  static OrderService? _instance;

  static OrderService instance([OrderState state = const InitOrderState()]) {
    return _instance ??= OrderService(state);
  }

  Future<void> handle(OrderEvent event) => event._execute(this);

  void onState(ValueChanged<OrderState> callBack) => callBack(value);
}

abstract class OrderEvent {
  const OrderEvent();

  Future<void> _execute(OrderService service);
}

class CreateOrder extends OrderEvent {
  const CreateOrder({
    required this.order,
  });

  final OrderSchema order;

  String get _url => '${RepositoryService.httpURL}/v1/api/deliveries';

  static const _notificationURL = 'https://fcm.googleapis.com/fcm/send';

  @override
  Future<void> _execute(OrderService service) async {
    final state = ClientService.instance().value as ClientItemState;
    final token = state.data.accessToken;
    service.value = const PendingOrderState();
    try {
      final body = {
        "pickup_address": order.pickupPlace.title,
        "destination_address": order.deliveryPlace.title,

        ///
        "pickup_phone_number": order.pickupPhoneNumber?.phones.map((e) => e.number).join(', '),
        "recipient_phone_number": order.deliveryPhoneNumber?.phones.map((e) => e.number).join(', '),

        ///
        // "scheduled_date": order.scheduledDate,

        ///
        "lat_from": order.pickupPlace.latitude,
        "long_from": order.pickupPlace.longitude,

        ///
        "lat_to": order.deliveryPlace.latitude,
        "long_to": order.deliveryPlace.longitude,

        ///
        "name": order.name,
        "additional_info": order.description,

        ///
        'price': order.price,
      };
      print(jsonEncode({
          'to': '/topics/online_users',
          'data': body,
          'notification': {
            'title': 'hello',
          }
        }));
      final notificationResponse = await Dio().postUri<String>(
        Uri.parse(_notificationURL),
        data: jsonEncode({
          'to': '/topics/online_users',
          'data': body,
          'notification': {
            'title': 'hello',
          }
        }),
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'key=AAAA55CoBZc:APA91bGllEw9yVKfo8S9Reylfs4VQJ8WKRAPYQtZwnsL4R4l1DAR6anH1MrX5iFFUWPgw6xnU833HQ_qz9Rh1iAnqQlHeaIDctDG-e05t7YvWsmoFwjW135nBL2dsoAF6iNF_uWnEzha',
          'Content-Type': 'application/json',
        }),
      );
      print(notificationResponse.data);
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
          service.value = OrderItemState(data: order);
          break;
        default:
          service.value = FailureOrderState(
            message: 'internal error',
            event: this,
          );
      }
    } catch (error) {
      if (error is DioError) print(error.response?.data);
      service.value = FailureOrderState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
