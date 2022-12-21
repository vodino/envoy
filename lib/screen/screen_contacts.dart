import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

  void _onSubmitted() {
    final data = _contactController.value ?? Contact(phones: [_searchTextController.text]);
    Navigator.pop(context, data);
  }

  /// Input
  late final TextEditingController _searchTextController;

  void _listenSearchTextValue(BuildContext context, TextEditingValue value) {
    if (value.text.isNotEmpty) {
      _contactController.value = null;
    }
  }

  bool _onSearchChanged(String value, Contact contact) {
    if (value.isNotEmpty) {
      value = value.toLowerCase();
      return (contact.name!.toLowerCase().contains(value)) || (contact.phones!.any((element) => element.contains(value)));
    }
    return true;
  }

  /// ContactService
  late final ValueNotifier<Contact?> _contactController;
  late final ContactService _contactService;
  late List<Contact> _contactItems;
  late final Contact _myContact;

  void _getcontacts([bool pending = false]) {
    if (pending) _contactService.value = const PendingContactState();
    _contactService.handle(const GetContacts());
  }

  void _listenContactState(BuildContext context, ContactState state) {
    if (state is ContactItemListState) {
      _contactItems = state.data;
    }
  }

  @override
  void initState() {
    super.initState();

    /// Input
    _searchTextController = TextEditingController();

    /// ContactService
    _contactItems = List.empty();
    _contactService = ContactService.instance();
    _contactController = ValueNotifier(widget.contact);
    _myContact = Contact(name: 'Moi', phones: [ClientService.authenticated!.phoneNumber!]);
    if (_contactService.value is! ContactItemListState) WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getcontacts(true));
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
                  ValueListenableConsumer<TextEditingValue>(
                    listener: _listenSearchTextValue,
                    valueListenable: _searchTextController,
                    builder: (context, textValue, child) {
                      final contains = _onSearchChanged(textValue.text, _myContact);
                      return ValueListenableBuilder<Contact?>(
                        valueListenable: _contactController,
                        builder: (context, contactValue, child) {
                          return SliverVisibility(
                            visible: contains,
                            sliver: SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomCheckListTile(
                                    subtitle: Text(_myContact.phones!.join(', ')),
                                    onChanged: (value) => _onContactChanged(value, _myContact),
                                    value: listEquals(contactValue?.phones, _myContact.phones),
                                    title: Text(_myContact.name!),
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
                        initiated: true,
                        listener: _listenContactState,
                        valueListenable: _contactService,
                        builder: (context, state, child) {
                          if (state is PendingContactState) {
                            return const SliverFillRemaining(child: ContactsShimmer());
                          } else if (state is ContactItemListState) {
                            List<Contact> items = _contactItems.where((element) => _onSearchChanged(textValue.text, element)).toList();
                            return ValueListenableBuilder<Contact?>(
                              valueListenable: _contactController,
                              builder: (context, contactValue, child) {
                                return SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      if (index.isEven) {
                                        index ~/= 2;
                                        final item = items[index];
                                        return CustomCheckListTile(
                                          value: listEquals(contactValue?.phones, item.phones),
                                          onChanged: (value) => _onContactChanged(value, item),
                                          subtitle: Text(item.phones!.join(', ')),
                                          title: Text(item.name!),
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
                          return SliverFillRemaining(hasScrollBody: false, child: CustomErrorPage(onTap: () => _getcontacts(true)));
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
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchTextController,
                builder: (context, textValue, child) {
                  bool active = false;
                  if (textValue.text.isNotEmpty) {
                    final phone = textValue.text.contains(RegExp(r'^[0-9]{6,14}'));
                    List<Contact> items = List.from(_contactItems)..add(_myContact);
                    items = items.where((element) => _onSearchChanged(textValue.text, element)).toList();
                    active = items.isEmpty && phone;
                  }
                  return ValueListenableBuilder<Contact?>(
                    valueListenable: _contactController,
                    builder: (context, value, child) {
                      VoidCallback? onPressed = _onSubmitted;
                      if (value == null && !active) onPressed = null;
                      final style = TextStyle(color: onPressed == null ? CupertinoColors.systemGrey2 : null);
                      return CupertinoButton.filled(
                        onPressed: onPressed,
                        child: Text('Valider', style: style),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
