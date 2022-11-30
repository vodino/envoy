import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({
    super.key,
    this.contact,
    required this.title,
  });

  final Widget title;
  final Contact? contact;

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  /// Customer
  void _onContactChanged(bool? selected, Contact contact) {
    if (selected != null && selected) {
      _contactController.value = contact;
    }
  }

  /// Input
  late final TextEditingController _searchTextController;

  bool _onSearchChanged(String value, Contact contact) {
    if (value.isNotEmpty) {
      value = value.toLowerCase();
      return (contact.displayName.toLowerCase().contains(value)) ||
          (contact.phones.any((element) {
            return element.number.contains(value);
          }));
    }
    return true;
  }

  /// ContactService
  late final ValueNotifier<Contact?> _contactController;
  late final ContactService _contactService;

  void _getcontacts() {
    _contactService.handle(const GetContacts());
  }

  void _listenContactState(BuildContext context, ContactState state) {}

  /// ClientService
  late final ClientService _clientService;

  @override
  void initState() {
    super.initState();

    /// Input
    _searchTextController = TextEditingController();

    /// ContactService
    _contactController = ValueNotifier(widget.contact);
    _contactService = ContactService.instance();
    if (_contactService.value is! ContactItemListState) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => _getcontacts(),
      );
    }

    /// ClientService
    _clientService = ClientService.instance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactsAppBar(title: widget.title),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CustomScrollView(
                controller: ModalScrollController.of(context),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverPinnedHeader(
                    child: ContactsSearchTextField(
                      controller: _searchTextController,
                    ),
                  ),
                  const SliverPinnedHeader(child: Material(child: Divider(thickness: 8.0, height: 12.0))),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _searchTextController,
                    builder: (context, textValue, child) {
                      final item = Contact(displayName: 'Moi', phones: [Phone(ClientService.authenticated!.phoneNumber)]);
                      final contains = _onSearchChanged(textValue.text, item);
                      return ValueListenableBuilder<Contact?>(
                        valueListenable: _contactController,
                        builder: (context, contactValue, child) {
                          return SliverVisibility(
                            visible: contains,
                            sliver: SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ContactCheckListTile(
                                    subtitle: Text(item.phones.map((e) => e.number).join(', ')),
                                    onChanged: (value) => _onContactChanged(value, item),
                                    value: contactValue?.id == item.id,
                                    title: Text(item.displayName),
                                  ),
                                  const Divider(thickness: 8.0, height: 12.0)
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _searchTextController,
                    builder: (context, textValue, child) {
                      return ValueListenableConsumer<ContactState>(
                        listener: _listenContactState,
                        valueListenable: _contactService,
                        builder: (context, state, child) {
                          if (state is ContactItemListState) {
                            List<Contact> items = state.data.where((element) => _onSearchChanged(textValue.text, element)).toList();
                            return ValueListenableBuilder<Contact?>(
                              valueListenable: _contactController,
                              builder: (context, contactValue, child) {
                                return SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      if (index.isEven) {
                                        index ~/= 2;
                                        final item = items[index];
                                        return ContactCheckListTile(
                                          title: Text(item.displayName),
                                          value: contactValue?.id == item.id,
                                          onChanged: (value) => _onContactChanged(value, item),
                                          subtitle: Text(item.phones.map((e) => e.number).join(', ')),
                                        );
                                      }
                                      return const Divider();
                                    },
                                    childCount: max(0, items.length * 2 - 1),
                                  ),
                                );
                              },
                            );
                          }
                          return const SliverToBoxAdapter();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: CupertinoButton.filled(
                child: const Text('Valider'),
                onPressed: () {
                  Navigator.pop(context, _contactController.value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
