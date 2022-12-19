import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class HomeTrackingScreen extends StatefulWidget {
  const HomeTrackingScreen({
    super.key,
    required this.popController,
    required this.order,
  });

  final ValueNotifier<Order?> popController;
  final Order order;

  @override
  State<HomeTrackingScreen> createState() => _HomeTrackingScreenState();
}

class _HomeTrackingScreenState extends State<HomeTrackingScreen> {
  /// Customer
  Future<bool> _onWillPop() async {
    await _canceller?.call();
    return true;
  }

  /// OrderService
  late final OrderService _orderService;
  Future<void> Function()? _canceller;
  late Order _orderItem;

  void _listenOrderState(BuildContext context, OrderState state) {
    if (state is SubscriptionOrderState) {
      _canceller = state.canceller;
    } else if (state is OrderItemState) {
      _orderItem = state.data;
    } else if (state is FailureOrderState) {}
  }

  Future<void> _queryOrder() {
    return _orderService.handle(QueryOrder(id: widget.order.id!));
  }

  void _subscribeToOrder() {
    _orderService.handle(SubscribeToOrder(id: widget.order.id!));
  }

  @override
  void initState() {
    super.initState();

    /// OrderService
    _orderService = OrderService();
    _orderItem = widget.order;
    _subscribeToOrder();
  }

  @override
  void dispose() {
    /// OrderService
    _canceller?.call();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.5,
        minChildSize: 0.5,
        initialChildSize: 0.5,
        builder: (context, scrollController) {
          return Scaffold(
            appBar: const HomeTrackingAppBar(),
            body: BottomAppBar(
              elevation: 0.0,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        CupertinoSliverRefreshControl(
                          refreshTriggerPullDistance: 60,
                          onRefresh: _queryOrder,
                        ),
                        SliverToBoxAdapter(
                          child: TrackingListTile(
                            title: _orderItem.rider!.phoneNumber!,
                            onTap: () {},
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                        const SliverToBoxAdapter(child: Divider(height: 8.0, thickness: 8.0)),
                        ValueListenableConsumer<OrderState>(
                          listener: _listenOrderState,
                          valueListenable: _orderService,
                          builder: (context, state, child) {
                            return SliverList(
                              delegate: SliverChildListDelegate([
                                CustomListTile(
                                  leading: Visibility(
                                    visible: _orderItem.status!.index >= OrderStatus.accepted.index,
                                    replacement: const Icon(CupertinoIcons.circle, color: CupertinoColors.systemFill),
                                    child: const Icon(CupertinoIcons.circle_fill, color: CupertinoColors.activeGreen),
                                  ),
                                  title: const Text('La commande a été acceptée'),
                                ),
                                CustomListTile(
                                  leading: Visibility(
                                    visible: _orderItem.status!.index >= OrderStatus.started.index,
                                    replacement: const Icon(CupertinoIcons.circle, color: CupertinoColors.systemFill),
                                    child: const Icon(CupertinoIcons.circle_fill, color: CupertinoColors.activeGreen),
                                  ),
                                  title: const Text('Début de la livraison'),
                                ),
                                CustomListTile(
                                  leading: Visibility(
                                    visible: _orderItem.status!.index >= OrderStatus.collected.index,
                                    replacement: const Icon(CupertinoIcons.circle, color: CupertinoColors.systemFill),
                                    child: const Icon(CupertinoIcons.circle_fill, color: CupertinoColors.activeGreen),
                                  ),
                                  title: const Text('La collecte du colis'),
                                ),
                                CustomListTile(
                                  leading: Visibility(
                                    visible: _orderItem.status!.index >= OrderStatus.delivered.index,
                                    replacement: const Icon(CupertinoIcons.circle, color: CupertinoColors.systemFill),
                                    child: const Icon(CupertinoIcons.circle_fill, color: CupertinoColors.activeGreen),
                                  ),
                                  title: const Text('Le colis a été livrée'),
                                ),
                              ]),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomOutlineButton(
                            onPressed: () => Navigator.pop(context),
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('Fermer'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('Details'),
                            ),
                            onPressed: () {},
                          ),
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
    );
  }
}
