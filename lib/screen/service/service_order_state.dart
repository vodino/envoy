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

class OrderItemState extends OrderState {
  const OrderItemState({
    required this.data,
  });
  final OrderSchema data;
}

class OrderItemListState extends OrderState {
  const OrderItemListState({
    required this.data,
  });
  final List<OrderSchema> data;
}
