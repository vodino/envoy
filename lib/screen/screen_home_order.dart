import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

import '_screen.dart';

class HomeOrderCreateScreen extends StatefulWidget {
  const HomeOrderCreateScreen({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  State<HomeOrderCreateScreen> createState() => _HomeOrderCreateScreenState();
}

class _HomeOrderCreateScreenState extends State<HomeOrderCreateScreen> {
  /// Customer
  late final ValueNotifier<String?> _amountPayByCourierController;
  late final ValueNotifier<DateTime?> _scheduledDateController;
  late final TextEditingController _pickupAdditionalInfoTextController;
  late final TextEditingController _deliveryAdditionalInfoTextController;
  late final ValueNotifier<Order> _orderController;
  late final TextEditingController _titleTextController;

  Future<void> _openAmountModal() async {
    final value = await showDialog<String>(
      context: context,
      builder: (context) {
        return CustomTextFieldModal(
          hint: 'Montant',
          title: 'Entrer le montant à payer',
          value: _amountPayByCourierController.value,
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
          dateTime: _scheduledDateController.value,
        );
      },
    );
    if (value != null) _scheduledDateController.value = value;
  }

  Future<void> _switchDatetimeOrder(bool value) async {
    if (value) {
      return _openDatetimeOrderModal();
    } else {
      _scheduledDateController.value = null;
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

  /// RiderService
  late final RiderService _riderService;
  late final ValueNotifier<RiderType> _riderTypeController;
  List<PriceSchema>? _orderPriceItems;

  void _listenRiderState(BuildContext context, RiderState state) {
    if (state is RiderItemState) {
      _orderPriceItems = state.data.prices;
    }
  }

  void _getRiderAvailable() {
    _riderService.handle(GetAvailableRiders(
      source: LatLng(
        _orderController.value.pickupPlace!.latitude!,
        _orderController.value.pickupPlace!.longitude!,
      ),
    ));
  }

  /// OrderService
  late final OrderService _orderService;

  void _listenOrderState(BuildContext context, OrderState state) {
    if (state is OrderItemState) {
      Navigator.of(context, rootNavigator: true).pop(state.data);
    }
  }

  void _createOrder() {
    if (_pickupContactController.value == null) {
      showDialog(
        context: context,
        builder: (context) {
          return const HomeOrderErrorModal(
            text: 'Contact pour le ramassage ne peut être vide. Choisissez un contact',
          );
        },
      );
      return;
    }
    if (_deliveryContactController.value == null) {
      showDialog(
        context: context,
        builder: (context) {
          return const HomeOrderErrorModal(
            text: 'Contact pour la livraison ne peut être vide. Choisissez un contact',
          );
        },
      );
      return;
    }

    _orderService.handle(
      CreateOrder(
        order: _orderController.value.copyWith(
          name: _titleTextController.text,
          scheduledDate: _scheduledDateController.value,
          pickupPhoneNumber: _pickupContactController.value,
          deliveryPhoneNumber: _deliveryContactController.value!,
          pickupAdditionalInfo: _pickupAdditionalInfoTextController.text,
          deliveryAdditionalInfo: _deliveryAdditionalInfoTextController.text,
          amountPaidedByRider: double.tryParse(_amountPayByCourierController.value ?? ''),
          price: _orderPriceItems!.firstWhere((type) => type.type == _riderTypeController.value).price,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    /// Customer
    _amountPayByCourierController = ValueNotifier(widget.order.amountPaidedByRider?.toString());
    _scheduledDateController = ValueNotifier(widget.order.scheduledDate);
    _pickupAdditionalInfoTextController = TextEditingController(text: widget.order.pickupAdditionalInfo);
    _deliveryAdditionalInfoTextController = TextEditingController(text: widget.order.deliveryAdditionalInfo);
    _titleTextController = TextEditingController(text: widget.order.name);
    _orderController = ValueNotifier(widget.order);

    _riderTypeController = ValueNotifier(RiderType.motorbike);

    /// ContactService
    _pickupContactController = ValueNotifier(widget.order.pickupPhoneNumber);
    _deliveryContactController = ValueNotifier(widget.order.deliveryPhoneNumber);

    /// RiderService
    _riderService = RiderService();
    _getRiderAvailable();

    /// OrderService
    _orderService = OrderService();
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
              child: CustomScrollView(
                controller: ModalScrollController.of(context),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverToBoxAdapter(
                    child: HomeOrderPlaceListTile(
                      title: Text(widget.order.pickupPlace!.title!),
                      iconColor: CupertinoColors.activeBlue,
                      onTap: () {},
                    ),
                  ),
                  const SliverToBoxAdapter(child: Divider(indent: 40.0)),
                  SliverToBoxAdapter(
                    child: HomeOrderPlaceListTile(
                      title: Text(widget.order.deliveryPlace!.title!),
                      iconColor: CupertinoColors.activeOrange,
                      onTap: () {},
                    ),
                  ),
                  const SliverToBoxAdapter(child: Divider(thickness: 6.0, height: 6.0)),
                  SliverToBoxAdapter(
                    child: AspectRatio(
                      aspectRatio: 4.0,
                      child: ValueListenableBuilder<RiderState>(
                        valueListenable: _riderService,
                        builder: (context, state, child) {
                          return ValueListenableBuilder<RiderType>(
                            valueListenable: _riderTypeController,
                            builder: (context, type, child) {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                children: [
                                  Builder(
                                    builder: (context) {
                                      final result = _orderPriceItems?.where((value) => value.type == RiderType.motorbike);
                                      final isNotEmpty = result?.isNotEmpty ?? false;
                                      return HomeOrderPriceWidget(
                                        onChanged: isNotEmpty ? (value) => _riderTypeController.value = RiderType.motorbike : null,
                                        amount: _orderPriceItems != null ? (isNotEmpty ? '${result!.first.price.toInt()} F' : '-') : null,
                                        padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                                        value: type == RiderType.motorbike,
                                        image: Assets.images.motorbike,
                                        title: 'À moto',
                                      );
                                    },
                                  ),
                                  // const SizedBox(width: 12.0),
                                  // Builder(
                                  //   builder: (context) {
                                  //     final result = _orderPriceItems?.where((value) => value.type == RiderType.car);
                                  //     final isNotEmpty = result?.isNotEmpty ?? false;
                                  //     return HomeOrderPriceWidget(
                                  //       amount: _orderPriceItems != null ? (isNotEmpty ? '${result!.first.price.toInt()} F' : '-') : null,
                                  //       onChanged: isNotEmpty ? (value) => _riderTypeController.value = RiderType.car : null,
                                  //       value: type == RiderType.car,
                                  //       image: Assets.images.car,
                                  //       title: 'En voiture',
                                  //     );
                                  //   },
                                  // ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ValueListenableBuilder<Contact?>(
                      valueListenable: _pickupContactController,
                      builder: (context, contact, child) {
                        return HomeOrderContactListTile(
                          title: const Text('Contact pour le ramassage'),
                          subtitle: contact != null ? Text(contact.phones!.join(', ')) : null,
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
                    child: CustomTextField(
                      controller: _pickupAdditionalInfoTextController,
                      hintText: "Plus d'infos sur le ramassage",
                      maxLines: 6,
                      minLines: 4,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                  const SliverToBoxAdapter(child: Divider()),
                  const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                  SliverToBoxAdapter(
                    child: ValueListenableBuilder<Contact?>(
                      valueListenable: _deliveryContactController,
                      builder: (context, contact, child) {
                        return HomeOrderContactListTile(
                          title: const Text('Contact pour la livraison'),
                          subtitle: contact != null ? Text(contact.phones!.join(', ')) : null,
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
                      controller: _deliveryAdditionalInfoTextController,
                      hintText: "Plus d'infos sur la livraison",
                      maxLines: 6,
                      minLines: 4,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                  const SliverToBoxAdapter(child: Divider()),
                  const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                  SliverToBoxAdapter(
                    child: CustomTextField(
                      controller: _titleTextController,
                      prefixIcon: const Icon(CupertinoIcons.cube_box_fill, color: CupertinoColors.systemGrey2),
                      hintText: 'Nom de la commande',
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
                  SliverToBoxAdapter(
                    child: ValueListenableBuilder<DateTime?>(
                      valueListenable: _scheduledDateController,
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
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ValueListenableConsumer<OrderState>(
                listener: _listenOrderState,
                valueListenable: _orderService,
                builder: (context, orderState, child) {
                  return ValueListenableConsumer<RiderState>(
                    listener: _listenRiderState,
                    valueListenable: _riderService,
                    builder: (context, riderState, child) {
                      bool available = true;
                      VoidCallback? onPressed = _createOrder;
                      if (riderState is PendingRiderState || orderState is PendingOrderState) {
                        onPressed = null;
                      } else if (riderState is RiderItemState) {
                        available = riderState.data.available;
                        if (!available) onPressed = null;
                      }
                      final style = TextStyle(color: onPressed == null ? CupertinoColors.systemGrey2 : null);
                      return CupertinoButton.filled(
                        onPressed: onPressed,
                        padding: EdgeInsets.zero,
                        disabledColor: CupertinoColors.systemFill,
                        child: Visibility(
                          visible: orderState is! PendingOrderState,
                          replacement: const CupertinoActivityIndicator(),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Visibility(
                              visible: available,
                              replacement: Text('Oops, pas de coursiers disponibles', style: style),
                              child: Text('Commander', style: style),
                            ),
                          ),
                        ),
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
