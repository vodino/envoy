import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

import '_screen.dart';

class HomeOrderCreateScreen extends StatefulWidget {
  const HomeOrderCreateScreen({
    super.key,
    required this.order,
  });

  final OrderSchema order;

  @override
  State<HomeOrderCreateScreen> createState() => _HomeOrderCreateScreenState();
}

class _HomeOrderCreateScreenState extends State<HomeOrderCreateScreen> {
  /// Customer
  late final ValueNotifier<String?> _amountPayByCourierController;
  late final ValueNotifier<DateTime?> _dateTimeOrderController;
  late final TextEditingController _descriptionTextController;
  late final TextEditingController _titleTextController;

  Future<void> _openAmountModal() async {
    final value = await showDialog<String>(
      context: context,
      builder: (context) {
        return HomeOrderAmountModal(
          amount: _amountPayByCourierController.value,
        );
      },
    );
    if (value != null) _amountPayByCourierController.value = value;
  }

  Future<void> _switchAmountPayByCourier(bool value) async {
    if (value) {
      return _openAmountModal();
    } else {
      _amountPayByCourierController.value = null;
    }
  }

  Future<void> _openDatetimeOrderModal() async {
    final value = await showModalBottomSheet<DateTime>(
      context: context,
      useRootNavigator: true,
      barrierColor: Colors.black26,
      builder: (context) {
        return HomeOrderDateTimeBottomSheet(
          dateTime: _dateTimeOrderController.value,
        );
      },
    );
    if (value != null) _dateTimeOrderController.value = value;
  }

  Future<void> _switchDatetimeOrder(bool value) async {
    if (value) {
      return _openDatetimeOrderModal();
    } else {
      _dateTimeOrderController.value = null;
    }
  }

  /// ContactService
  late final ValueNotifier<Contact?> _pickupContactController;
  late final ValueNotifier<Contact?> _deliveryContactController;

  void _onContactPressed({
    required ValueNotifier<Contact?> controller,
    required String title,
  }) async {
    final bool isGranted = await Permission.contacts.isGranted;
    if (isGranted && mounted) {
      final value = await Navigator.push<Contact?>(
        context,
        CupertinoPageRoute(
          builder: (context) {
            return ContactsScreen(
              contact: controller.value,
              title: Text(title),
            );
          },
        ),
      );
      if (value != null) controller.value = value;
    } else {
      final status = await Permission.contacts.request();
      if (status.isGranted) {
        _onContactPressed(controller: controller, title: title);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    /// Customer
    _amountPayByCourierController = ValueNotifier(null);
    _dateTimeOrderController = ValueNotifier(null);
    _descriptionTextController = TextEditingController();
    _titleTextController = TextEditingController();

    /// ContactService
    _pickupContactController = ValueNotifier(null);
    _deliveryContactController = ValueNotifier(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeOrderAppBar(),
      body: BottomAppBar(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CupertinoScrollbar(
                child: CustomScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: ModalScrollController.of(context),
                  slivers: [
                    SliverToBoxAdapter(
                      child: HomeOrderPlaceListTile(
                        title: Text(widget.order.pickupPlace.title!),
                        iconColor: CupertinoColors.activeBlue,
                        onTap: () {},
                      ),
                    ),
                    const SliverToBoxAdapter(child: Divider(indent: 40.0)),
                    SliverToBoxAdapter(
                      child: HomeOrderPlaceListTile(
                        title: Text(widget.order.deliveryPlace.title!),
                        iconColor: CupertinoColors.activeOrange,
                        onTap: () {},
                      ),
                    ),
                    const SliverToBoxAdapter(child: Divider(thickness: 6.0, height: 6.0)),
                    SliverToBoxAdapter(
                      child: AspectRatio(
                        aspectRatio: 4.0,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 12.0);
                          },
                          itemBuilder: (context, index) {
                            return HomeOrderPriceWidget(
                              onChanged: (value) {},
                              amount: '1000 F',
                              title: 'À moto',
                              value: false,
                            );
                          },
                          itemCount: 1,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ValueListenableBuilder<Contact?>(
                        valueListenable: _pickupContactController,
                        builder: (context, contact, child) {
                          return HomeOrderContactListTile(
                            title: const Text('Contact pour le ramassage'),
                            subtitle: contact != null ? Text(contact.phones.map((e) => e.number).join(', ')) : null,
                            onTap: () => _onContactPressed(
                              controller: _pickupContactController,
                              title: 'Contact pour le ramassage',
                            ),
                          );
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                    SliverToBoxAdapter(
                      child: ValueListenableBuilder<Contact?>(
                        valueListenable: _deliveryContactController,
                        builder: (context, contact, child) {
                          return HomeOrderContactListTile(
                            title: const Text('Contact pour la livraison'),
                            subtitle: contact != null ? Text(contact.phones.map((e) => e.number).join(', ')) : null,
                            onTap: () => _onContactPressed(
                              controller: _deliveryContactController,
                              title: 'Contact pour la livraison',
                            ),
                          );
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: _titleTextController,
                        prefixIcon: const Icon(CupertinoIcons.cube_box_fill, color: CupertinoColors.systemGrey2),
                        hintText: 'Nom de la commande',
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: _descriptionTextController,
                        hintText: 'Description',
                        maxLines: 6,
                        minLines: 4,
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
                    SliverToBoxAdapter(
                      child: ValueListenableBuilder<DateTime?>(
                        valueListenable: _dateTimeOrderController,
                        builder: (context, dateTime, child) {
                          final localizations = CupertinoLocalizations.of(context);
                          return HomeOrderSwitchListTile(
                            trailing: dateTime != null ? '${localizations.datePickerMediumDate(dateTime)} à ${TimeOfDay.fromDateTime(dateTime).format(context)}' : null,
                            onTrailingPressed: _openDatetimeOrderModal,
                            title: const Text('Programmer'),
                            onChanged: _switchDatetimeOrder,
                            value: dateTime != null,
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ValueListenableBuilder<String?>(
                        valueListenable: _amountPayByCourierController,
                        builder: (context, amount, child) {
                          return HomeOrderSwitchListTile(
                            trailing: amount != null ? '$amount F' : null,
                            title: const Text('Paiement par le livreur'),
                            onChanged: _switchAmountPayByCourier,
                            onTrailingPressed: _openAmountModal,
                            value: amount != null,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: CupertinoButton.filled(
                child: const Text('Commander'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
