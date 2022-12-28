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
        final localizations = context.localizations;
        return CustomTextFieldModal(
          hint: localizations.amount.capitalize(),
          value: _amountPayByCourierController.value,
          title: localizations.enteramount.capitalize(),
        );
      },
    );
    if (value != null) _amountPayByCourierController.value = value;
  }

  Future<Place?> _openLocationMap({
    required LatLng position,
    required PlaceCategory category,
  }) {
    return Navigator.of(context, rootNavigator: true).push<Place>(
      CupertinoPageRoute(builder: (context) {
        return LocationMapScreen(
          category: category,
          postion: position,
        );
      }),
    );
  }

  void _onPickupMapPressed() async {
    final data = await _openLocationMap(
      category: PlaceCategory.source,
      position: LatLng(
        _orderController.value.pickupPlace!.latitude!,
        _orderController.value.pickupPlace!.longitude!,
      ),
    );
    if (data != null) {
      _orderController.value = _orderController.value.copyWith(pickupPlace: data);
      _getRiderAvailable();
    }
  }

  void _onDeliveryMapPressed() async {
    final data = await _openLocationMap(
      category: PlaceCategory.destination,
      position: LatLng(
        _orderController.value.deliveryPlace!.latitude!,
        _orderController.value.deliveryPlace!.longitude!,
      ),
    );
    if (data != null) {
      _orderController.value = _orderController.value.copyWith(deliveryPlace: data);
      _getRiderAvailable();
    }
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
  RiderResultSchema? _orderPriceResult;

  void _listenRiderState(BuildContext context, RiderState state) {
    if (state is RiderItemState) {
      _orderPriceResult = state.data;
    } else if (state is FailureRiderState) {
      showDialog(
        context: context,
        builder: (context) {
          return HomeOrderErrorModal(text: state.message);
        },
      );
    }
  }

  void _getRiderAvailable() {
    _riderService.handle(GetAvailableRiders(
      source: LatLng(
        _orderController.value.pickupPlace!.latitude!,
        _orderController.value.pickupPlace!.longitude!,
      ),
      destination: LatLng(
        _orderController.value.deliveryPlace!.latitude!,
        _orderController.value.deliveryPlace!.longitude!,
      ),
    ));
  }

  /// OrderService
  late final OrderService _orderService;

  void _listenOrderState(BuildContext context, OrderState state) {
    if (state is OrderItemState) {
      Navigator.of(context, rootNavigator: true).pop(state.data);
    } else if (state is FailureOrderState) {
      showDialog(
        context: context,
        builder: (context) {
          return HomeOrderErrorModal(text: state.message);
        },
      );
    }
  }

  void _createOrder() {
    if (_pickupContactController.value == null) {
      showDialog(
        context: context,
        builder: (context) {
          final localizations = context.localizations;
          return HomeOrderErrorModal(
            text: localizations.contactpickuprequired.capitalize(),
          );
        },
      );
      return;
    }
    if (_deliveryContactController.value == null) {
      showDialog(
        context: context,
        builder: (context) {
          final localizations = context.localizations;
          return HomeOrderErrorModal(
            text: localizations.contactdeliveryrequired.capitalize(),
          );
        },
      );
      return;
    }
    _orderService.handle(
      CreateOrder(
        duration: _orderPriceResult!.duration,
        distance: _orderPriceResult!.distance,
        order: _orderController.value.copyWith(
          name: _titleTextController.text,
          scheduledDate: _scheduledDateController.value,
          pickupPhoneNumber: _pickupContactController.value,
          deliveryPhoneNumber: _deliveryContactController.value!,
          pickupAdditionalInfo: _pickupAdditionalInfoTextController.text,
          deliveryAdditionalInfo: _deliveryAdditionalInfoTextController.text,
          amountPaidedByRider: double.tryParse(_amountPayByCourierController.value ?? ''),
          price: _orderPriceResult!.prices.firstWhere((type) => type.type == _riderTypeController.value).price,
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
    final localizations = context.localizations;
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
                  ValueListenableBuilder<Order>(
                    valueListenable: _orderController,
                    builder: (context, order, child) {
                      return MultiSliver(
                        children: [
                          SliverToBoxAdapter(
                            child: HomeOrderPlaceListTile(
                              subtitle: order.pickupPlace!.subtitle != null ? Text(order.pickupPlace!.subtitle!) : null,
                              iconColor: CupertinoColors.activeBlue,
                              title: Text(order.pickupPlace!.title!),
                              onTap: _onPickupMapPressed,
                            ),
                          ),
                          const SliverToBoxAdapter(child: Divider(indent: 40.0)),
                          SliverToBoxAdapter(
                            child: HomeOrderPlaceListTile(
                              subtitle: order.deliveryPlace!.subtitle != null ? Text(order.deliveryPlace!.subtitle!) : null,
                              iconColor: CupertinoColors.activeOrange,
                              title: Text(order.deliveryPlace!.title!),
                              onTap: _onDeliveryMapPressed,
                            ),
                          ),
                        ],
                      );
                    },
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
                                  ValueListenableBuilder<RiderState>(
                                    valueListenable: _riderService,
                                    builder: (context, riderState, child) {
                                      var result = _orderPriceResult?.prices.where((value) => value.type == RiderType.motorbike);
                                      if (riderState is PendingRiderState) result = null;
                                      final isNotEmpty = result?.isNotEmpty ?? false;
                                      return HomeOrderPriceWidget(
                                        onChanged: isNotEmpty ? (value) => _riderTypeController.value = RiderType.motorbike : null,
                                        amount: result != null ? (isNotEmpty ? '${result.first.price.toInt()} F' : '-') : null,
                                        padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                                        title: localizations.onmotorbike.capitalize(),
                                        value: type == RiderType.motorbike,
                                        image: Assets.images.motorbike,
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
                          title: Text(localizations.contactpickup.capitalize()),
                          subtitle: contact != null ? Text(contact.phones!.join(', ')) : null,
                          onTap: () => _onContactPressed(
                            title: localizations.contactpickup.capitalize(),
                            controller: _pickupContactController,
                          ),
                        );
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                  SliverToBoxAdapter(
                    child: CustomTextField(
                      controller: _pickupAdditionalInfoTextController,
                      hintText: localizations.infopickup.capitalize(),
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
                          title: Text(localizations.contactdelivery.capitalize()),
                          subtitle: contact != null ? Text(contact.phones!.join(', ')) : null,
                          onTap: () => _onContactPressed(
                            title: localizations.contactdelivery.capitalize(),
                            controller: _deliveryContactController,
                          ),
                        );
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                  SliverToBoxAdapter(
                    child: CustomTextField(
                      controller: _deliveryAdditionalInfoTextController,
                      hintText: localizations.infodelivery.capitalize(),
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
                      hintText: localizations.ordername.capitalize(),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
                  SliverToBoxAdapter(
                    child: ValueListenableBuilder<DateTime?>(
                      valueListenable: _scheduledDateController,
                      builder: (context, dateTime, child) {
                        return HomeOrderSwitchListTile(
                          trailing: dateTime != null ? '${CupertinoLocalizations.of(context).datePickerMediumDate(dateTime)} à ${TimeOfDay.fromDateTime(dateTime).format(context)}' : null,
                          title: Text(localizations.program.capitalize()),
                          onTrailingPressed: _openDatetimeOrderModal,
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
                          title: Text(localizations.purchasecourier.capitalize()),
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
                      if (riderState is PendingRiderState || orderState is PendingOrderState || riderState is FailureRiderState) {
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
                              replacement: Text(localizations.oopsnocourier.capitalize(), style: style),
                              child: Text(localizations.toorder.capitalize(), style: style),
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
