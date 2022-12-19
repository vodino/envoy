import 'dart:async';

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
    print(riders);
    if (riders.isNotEmpty && index < riders.length) {
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

  void _subscribeToOrder() {
    _orderService.handle(SubscribeToOrder(id: widget.order.id!));
  }

  @override
  void initState() {
    super.initState();

    /// RouteService
    _routeService = RouteService.instance();
    _getRoute();

    /// MessagingService
    _messagingService = MessagingService();
    _pushMessage();

    /// OrderService
    _orderService = OrderService();
    _subscribeToOrder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                body: BottomAppBar(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const HomeFinderAppBar(),
                      Expanded(child: HomeFinderLoader(image: Assets.images.motorbike)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        child: ValueListenableConsumer<OrderState>(
                          listener: _listenOrderState,
                          valueListenable: _orderService,
                          builder: (context, state, child) {
                            VoidCallback? onPressed = _cancelOrder;
                            if (state is PendingOrderState) onPressed = null;
                            return CustomOutlineButton(
                              onPressed: onPressed,
                              child: const Text('Annuler'),
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
        ),
      ),
    );
  }
}
