import '_service.dart';

abstract class RiderState {
  const RiderState();
}

class InitRiderState extends RiderState {
  const InitRiderState();
}

class PendingRiderState extends RiderState {
  const PendingRiderState();
}

class FailureRiderState extends RiderState {
  const FailureRiderState({
    required this.message,
    this.event,
  });
  final RiderEvent? event;
  final String message;
}

class RiderItemState extends RiderState {
  const RiderItemState({
    required this.data,
  });
  final RiderResultSchema data;
}

class RiderItemListState extends RiderState {
  const RiderItemListState({
    required this.data,
  });
  final List<RiderResultSchema> data;
}
