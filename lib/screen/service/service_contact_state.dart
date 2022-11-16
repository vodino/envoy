import 'package:flutter_contacts/flutter_contacts.dart';

import '_service.dart';

abstract class ContactState {
  const ContactState();
}

class InitContactState extends ContactState {
  const InitContactState();
}

class PendingContactState extends ContactState {
  const PendingContactState();
}

class FailureContactState extends ContactState {
  const FailureContactState({
    required this.message,
    this.event,
  });
  final ContactEvent? event;
  final String message;
}

class ContactItemState extends ContactState {
  const ContactItemState({
    required this.data,
  });
  final Contact data;
}

class ContactItemListState extends ContactState {
  const ContactItemListState({
    required this.data,
  });
  final List<Contact> data;
}
