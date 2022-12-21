import '_service.dart';

abstract class BusinessState {
  const BusinessState();
}

class InitBusinessState extends BusinessState {
  const InitBusinessState();
}

class PendingBusinessState extends BusinessState {
  const PendingBusinessState();
}

class FailureBusinessState extends BusinessState {
  const FailureBusinessState({
    required this.message,
    this.event,
  });
  final BusinessEvent? event;
  final String message;
}

class CancelFailureBusinessState extends FailureBusinessState {
  const CancelFailureBusinessState({
    required super.message,
    super.event,
  });
}

class RequestItemBusinessState extends BusinessState {
  const RequestItemBusinessState({
    required this.data,
  });
  final RequestSchema data;
}

class RequestItemListBusinessState extends BusinessState {
  const RequestItemListBusinessState({
    required this.data,
  });
  final List<RequestSchema> data;
}

class MessageSended extends BusinessState {
  const MessageSended();
}
