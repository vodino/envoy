import '_service.dart';

abstract class PlaceState {
  const PlaceState();
}

class InitPlaceState extends PlaceState {
  const InitPlaceState();
}

class PendingPlaceState extends PlaceState {
  const PendingPlaceState();
}

class FailurePlaceState extends PlaceState {
  const FailurePlaceState({
    required this.message,
    this.event,
  });
  final PlaceEvent? event;
  final String message;
}

class CancelFailurePlaceState extends FailurePlaceState {
  const CancelFailurePlaceState({
    required super.message,
    super.event,
  });
}

class PlaceItemState extends PlaceState {
  const PlaceItemState({
    required this.data,
  });
  final PlaceSchema data;
}

class PlaceItemListState extends PlaceState {
  const PlaceItemListState({
    required this.data,
  });
  final List<PlaceSchema> data;
}
