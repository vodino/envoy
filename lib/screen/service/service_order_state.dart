import '_service.dart';

abstract class OrderState {
  const OrderState();
}

class InitOrderState extends OrderState {
  const InitOrderState();
}

class PendingOrderState extends OrderState {
  const PendingOrderState();
}

class FailureOrderState extends OrderState {
  const FailureOrderState({
    required this.message,
    this.event,
  });
  final OrderEvent? event;
  final String message;
}

class SuccessOrderState extends OrderState {
  const SuccessOrderState();
}

class OrderItemState extends OrderState {
  const OrderItemState({
    required this.data,
  });
  final Order data;
}

class OrderItemListState extends OrderState {
  const OrderItemListState({
    required this.data,
  });
  final List<Order> data;
}

class NoOrderItemState extends OrderState {
  const NoOrderItemState({
    this.phoneNumber,
    this.token,
  });

  final String? phoneNumber;
  final String? token;
}

class SubscriptionOrderState extends OrderState {
  const SubscriptionOrderState({
    required this.canceller,
  });
  final Future<void> Function() canceller;
}
