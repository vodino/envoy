import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

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

class QueryOrderList extends OrderEvent {
  const QueryOrderList();

  String get _url => '${RepositoryService.httpURL}/v1/api/client/deliveries';

  @override
  Future<void> _execute(OrderService service) async {
    final client = ClientService.authenticated!;
    final token = client.accessToken;
    try {
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
          final data = await compute(Order.fromFirebaseListJson, response.data!);
          await OrderService().handle(PutOrderList(data: data));
          service.value = OrderItemListState(data: data);
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

class QueryOrder extends OrderEvent {
  const QueryOrder({required this.id});

  final int id;

  String get _url => '${RepositoryService.httpURL}/v1/api/client/deliveries/$id';

  @override
  Future<void> _execute(OrderService service) async {
    final client = ClientService.authenticated!;
    final token = client.accessToken;
    service.value = const PendingOrderState();
    try {
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
          final data = await compute(Order.fromOtherServerJson, response.data!);
          await OrderService().handle(PutOrderList(data: [data]));
          service.value = OrderItemState(data: data);
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

class CreateOrder extends OrderEvent {
  const CreateOrder({
    required this.order,
  });

  final Order order;

  String get _url => '${RepositoryService.httpURL}/v1/api/deliveries';

  @override
  Future<void> _execute(OrderService service) async {
    final client = ClientService.authenticated!;
    final token = client.accessToken;
    service.value = const PendingOrderState();
    try {
      final body = {
        "pickup_address": order.pickupPlace!.title,
        "destination_address": order.deliveryPlace!.title,

        ///
        "pickup_phone_number": order.pickupPhoneNumber?.phones?.join(', '),
        "recipient_phone_number": order.deliveryPhoneNumber?.phones?.join(', '),

        ///
        "scheduled_date": order.scheduledDate?.toIso8601String(),
        "amount_paided_by_rider": order.amountPaidedByRider,

        ///
        "lat_from": order.pickupPlace!.latitude,
        "long_from": order.pickupPlace!.longitude,

        ///
        "lat_to": order.deliveryPlace!.latitude,
        "long_to": order.deliveryPlace!.longitude,

        ///
        "name": order.name,
        "pickup_additional_info": order.pickupAdditionalInfo,
        "destination_additional_info": order.deliveryAdditionalInfo,

        ///
        'price': order.price,
      }..removeWhere((key, value) => value == null);
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
          var data = await compute(Order.fromServerJson, response.data!);
          data = data.copyWith(client: client.copyWith(accessToken: ''));
          await OrderService().handle(PutOrderList(data: [data]));
          service.value = OrderItemState(data: data);
          break;
        default:
          service.value = FailureOrderState(
            message: 'internal error',
            event: this,
          );
      }
    } catch (error) {
      if (error is DioError) print(error.response?.data);
      print(error);
      service.value = FailureOrderState(
        message: error.toString(),
        event: this,
      );
    }
  }
}

class SubscribeToOrder extends OrderEvent {
  const SubscribeToOrder({required this.id});

  final int id;

  String get _activeOrderTopic => 'active_order.$id';

  @override
  Future<void> _execute(OrderService service) async {
    service.value = const PendingOrderState();
    final firebaseMessaging = FirebaseService.firebaseMessaging;
    await firebaseMessaging.requestPermission();
    await firebaseMessaging.subscribeToTopic(_activeOrderTopic);

    await service.handle(GetOrder(id: id, subscription: true));

    /// Handle subscription
    final subscriptionOpenedApp = FirebaseMessaging.onMessageOpenedApp.listen((message) {
      OrderService().handle(PutOrderList(data: [Order.fromFirebaseJson(message.data['order'])]));
    });
    final subscription = FirebaseMessaging.onMessage.listen((message) {
      OrderService().handle(PutOrderList(data: [Order.fromFirebaseJson(message.data['order'])]));
    });
    service.value = SubscriptionOrderState(
      canceller: () async {
        service.value = const PendingOrderState();
        await Future.wait([
          subscription.cancel(),
          subscriptionOpenedApp.cancel(),
          firebaseMessaging.unsubscribeFromTopic(_activeOrderTopic),
        ]);
        service.value = const InitOrderState();
      },
    );
  }
}

class GetOrder extends OrderEvent {
  const GetOrder({
    required this.id,
    this.subscription = false,
  });

  final int id;
  final bool subscription;

  @override
  Future<void> _execute(OrderService service) async {
    service.value = const PendingOrderState();
    try {
      if (subscription) {
        IsarService.isar.orders.watchObject(id, fireImmediately: true).listen((data) {
          if (data != null) service.value = OrderItemState(data: data);
        });
      } else {
        final data = await IsarService.isar.orders.get(id);
        if (data != null) service.value = OrderItemState(data: data);
      }
    } catch (error) {
      service.value = FailureOrderState(
        message: error.toString(),
        event: this,
      );
    }
  }
}

class GetOrderList extends OrderEvent {
  const GetOrderList({
    this.subscription = false,
    this.limit = 30,
    this.offset = 0,
    this.isNullStatus = false,
    this.equalStatus,
    this.notEqualStatus,
    this.sort = Sort.desc,
    this.fireImmediately = true,
  });

  final Sort sort;
  final int limit;
  final int offset;
  final bool isNullStatus;
  final bool fireImmediately;
  final OrderStatus? equalStatus;
  final OrderStatus? notEqualStatus;

  final bool subscription;

  @override
  Future<void> _execute(OrderService service) async {
    service.value = const PendingOrderState();
    try {
      var query = IsarService.isar.orders.where(sort: sort).filter().idIsNotNull();
      if (isNullStatus) {
        query = query.statusIsNull();
      } else {
        query = query.statusIsNotNull();
      }
      if (equalStatus != null) query = query.statusEqualTo(equalStatus);
      if (notEqualStatus != null) query = query.not().statusEqualTo(notEqualStatus);

      if (subscription) {
        query.offset(offset).limit(limit).watch(fireImmediately: fireImmediately).listen((data) {
          service.value = OrderItemListState(data: data);
        });
      } else {
        final data = await query.offset(offset).limit(limit).findAll();
        service.value = OrderItemListState(data: data);
      }
    } catch (error) {
      service.value = FailureOrderState(
        message: error.toString(),
        event: this,
      );
    }
  }
}

class PutOrderList extends OrderEvent {
  const PutOrderList({
    required this.data,
  });

  final List<Order> data;

  @override
  Future<void> _execute(OrderService service) async {
    service.value = const PendingOrderState();
    try {
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.orders.putAll(data);
        service.value = OrderItemListState(data: data);
      });
    } catch (error) {
      service.value = FailureOrderState(
        message: error.toString(),
        event: this,
      );
    }
  }
}

class DeleteOrder extends OrderEvent {
  const DeleteOrder({
    required this.data,
  });

  final Order data;

  @override
  Future<void> _execute(OrderService service) async {
    service.value = const PendingOrderState();
    try {
      await IsarService.isar.orders.delete(data.id!);
      service.value = OrderItemState(data: data);
    } catch (error) {
      service.value = FailureOrderState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
