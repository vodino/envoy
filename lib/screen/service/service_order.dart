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

  String get url => '${RepositoryService.httpURL}/v1/api/deliveries';

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
        "scheduled_date": order.scheduledDate,

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
      final response = await Dio().postUri<String>(
        Uri.parse(url),
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
      service.value = FailureOrderState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
