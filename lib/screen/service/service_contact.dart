import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '_service.dart';

class ContactService extends ValueNotifier<ContactState> {
  ContactService([ContactState value = const InitContactState()]) : super(value);

  static ContactService? _instance;

  static ContactService instance([ContactState value = const InitContactState()]) {
    return _instance ??= ContactService(value);
  }

  Future<void> handle(ContactEvent event) => event._execute(this);
}

abstract class ContactEvent {
  const ContactEvent();

  Future<void> _execute(ContactService service);
}

class GetContacts extends ContactEvent {
  const GetContacts();

  @override
  Future<void> _execute(ContactService service) async {
    service.value = const PendingContactState();
    try {
      final data = await FlutterContacts.getContacts(withProperties: true);
      service.value = ContactItemListState(data: data);
    } catch (error) {
      service.value = FailureContactState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
