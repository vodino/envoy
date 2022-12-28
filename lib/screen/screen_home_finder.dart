import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_screen.dart';

class HomeFinderScreen extends StatefulWidget {
  const HomeFinderScreen({
    super.key,
    required this.order,
    required this.popController,
  });

  final Order order;
  final ValueNotifier<Order?> popController;

  @override
  State<HomeFinderScreen> createState() => _HomeFinderScreenState();
}

class _HomeFinderScreenState extends State<HomeFinderScreen> {
  /// Customer
  late final ValueNotifier<bool> _errorController;

  Future<bool> _onWillPop() async {
    _timer?.cancel();
    _timer = null;
    await _canceller?.call();
    return true;
  }

  void _cancelOrder() async {
    await _onWillPop();
    if (mounted) Navigator.pop(context);
  }

  /// RouteService
  late final RouteService _routeService;

  void _listenRouteState(BuildContext context, RouteState state) {}

  void _getRoute() {
    _routeService.handle(GetRoute(
      destination: LatLng(
        widget.order.deliveryPlace!.latitude!,
        widget.order.deliveryPlace!.longitude!,
      ),
      source: LatLng(
        widget.order.pickupPlace!.latitude!,
        widget.order.pickupPlace!.longitude!,
      ),
    ));
  }

  /// MessagingService
  late final MessagingService _messagingService;
  Timer? _timer;

  void _listenMessagingState(BuildContext context, MessagingState state) {}

  void _pushMessage([int index = 0]) async {
    final riders = widget.order.onlineRiders!;
    if (riders.isNotEmpty && index < riders.length) {
      if (index != 0) {
        await _queryOrder(widget.order.id!);
        final state = _orderService.value;
        if (state is OrderItemState && state.data.status != null) return;
      }
      final rider = riders.elementAt(index);
      await _messagingService.handle(PushMessage(
        body: 'Vous avez une nouvelle course',
        topic: 'online_users.${rider.id}',
        data: widget.order.toMap(),
        title: 'Nouvelle course',
      ));

      /// Timer
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 30), () => _pushMessage(++index));
    } else {
      _errorController.value = true;
    }
  }

  /// OrderService
  late final OrderService _orderService;
  Future<void> Function()? _canceller;

  void _listenOrderState(BuildContext context, OrderState state) async {
    if (state is SubscriptionOrderState) {
      _canceller = state.canceller;
    } else if (state is OrderItemState) {
      final data = state.data;
      if (data.status != null) {
        await _onWillPop();
        widget.popController.value = data;
        if (mounted) Navigator.pop(context);
      }
    }
  }

  Future<void> _queryOrder(int id) {
    return _orderService.handle(QueryOrder(id: id));
  }

  void _subscribeToOrder() {
    _pushMessage();
    _errorController.value = false;
    _orderService.handle(SubscribeToOrder(id: widget.order.id!));
  }

  @override
  void initState() {
    super.initState();

    /// Customer
    _errorController = ValueNotifier(false);

    /// RouteService
    _routeService = RouteService.instance();
    _getRoute();

    /// MessagingService
    _messagingService = MessagingService();
    // _pushMessage();

    /// OrderService
    _orderService = OrderService();
    _subscribeToOrder();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ValueListenableListener<MessagingState>(
        listener: _listenMessagingState,
        valueListenable: _messagingService,
        child: ValueListenableListener<RouteState>(
          listener: _listenRouteState,
          valueListenable: _routeService,
          child: DraggableScrollableSheet(
            expand: false,
            maxChildSize: 0.5,
            minChildSize: 0.5,
            initialChildSize: 0.5,
            builder: (context, scrollController) {
              return Scaffold(
                appBar: const HomeFinderAppBar(),
                body: BottomAppBar(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _errorController,
                          builder: (context, hasError, child) {
                            return Visibility(
                              visible: !hasError,
                              replacement: const HomeFinderError(),
                              child: HomeFinderLoader(image: Assets.images.motorbike),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ValueListenableConsumer<OrderState>(
                                listener: _listenOrderState,
                                valueListenable: _orderService,
                                builder: (context, state, child) {
                                  VoidCallback? onPressed = _cancelOrder;
                                  if (state is PendingOrderState) onPressed = null;
                                  return CustomOutlineButton(
                                    onPressed: onPressed,
                                    child: Text(localizations.cancel.capitalize()),
                                  );
                                },
                              ),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _errorController,
                              builder: (context, hasError, child) {
                                return Visibility(
                                  visible: hasError,
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: ValueListenableConsumer<OrderState>(
                                            listener: _listenOrderState,
                                            valueListenable: _orderService,
                                            builder: (context, state, child) {
                                              VoidCallback? onPressed = _subscribeToOrder;
                                              if (state is PendingOrderState) onPressed = null;
                                              return CupertinoButton.filled(
                                                onPressed: onPressed,
                                                padding: EdgeInsets.zero,
                                                child: Text(localizations.tryagain.capitalize()),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
