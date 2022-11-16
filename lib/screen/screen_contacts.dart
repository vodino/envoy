import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

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

  @override
  void initState() {
    super.initState();

    /// Input
    _searchTextController = TextEditingController();

    /// ContactService
    _contactController = ValueNotifier(widget.contact);
    _contactService = ContactService.instance();
    _getcontacts();
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
                slivers: [
                  SliverPinnedHeader(
                    child: ContactsSearchTextField(
                      controller: _searchTextController,
                    ),
                  ),
                  const SliverPinnedHeader(child: Material(child: Divider(thickness: 8.0, height: 12.0))),
                  ValueListenableBuilder<Contact?>(
                    valueListenable: _contactController,
                    builder: (context, contact, child) {
                      return SliverToBoxAdapter(
                        child: ContactCheckListTile(
                          subtitle: const Text('+225 0749414602'),
                          title: const Text('Moi'),
                          onChanged: (value) {},
                          value: false,
                        ),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(child: Divider(thickness: 8.0, height: 12.0)),
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
                              builder: (context, contact, child) {
                                return SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      if (index.isEven) {
                                        index ~/= 2;
                                        final item = items[index];
                                        return ContactCheckListTile(
                                          title: Text(item.displayName),
                                          value: contact?.id == item.id,
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
