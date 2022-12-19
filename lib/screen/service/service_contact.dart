import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as contacts;

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
      var result = await contacts.FlutterContacts.getContacts(withProperties: true);
      final data = result.map((e) => Contact(name: e.displayName, phones: e.phones.map((e) => e.number).toList())).toList();
      service.value = ContactItemListState(data: data);
    } catch (error) {
      service.value = FailureContactState(
        message: error.toString(),
        event: this,
      );
    }
  }
}
