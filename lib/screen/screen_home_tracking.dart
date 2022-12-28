import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _openOrderDetails(Order order) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: const HomeOrderDetailsAppBar(),
          body: SingleChildScrollView(child: HomeOrderDetailsScreen(order: order)),
          bottomNavigationBar: BottomAppBar(
            elevation: 0.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Divider(indent: 16.0, endIndent: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: const Text(
                      'Annuler la commande',
                      style: TextStyle(color: CupertinoColors.destructiveRed),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _launchPhone(String phone) {
    launchUrl(Uri(scheme: 'tel', host: phone));
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

  /// RouteService
  late final RouteService _routeService;

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

  @override
  void initState() {
    super.initState();

    /// OrderService
    _orderService = OrderService();
    _orderItem = widget.order;
    _subscribeToOrder();

    /// RouteService
    _routeService = RouteService.instance();
    _getRoute();
  }

  @override
  void dispose() {
    /// OrderService
    _canceller?.call();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
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
            body: CustomScrollView(
              slivers: [
                CupertinoSliverRefreshControl(
                  refreshTriggerPullDistance: 60,
                  onRefresh: _queryOrder,
                ),
                SliverToBoxAdapter(
                  child: TrackingListTile(
                    foregroundImage: _orderItem.rider!.avatar != null ? NetworkImage('${RepositoryService.httpURL}/storage/${_orderItem.rider!.avatar}') : null,
                    onTap: () => _launchPhone(_orderItem.rider!.phoneNumber!),
                    subtitle: _orderItem.rider!.phoneNumber!,
                    title: _orderItem.rider!.fullName!,
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
                          title: const Text('Le colis a été livré'),
                        ),
                      ]),
                    );
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomOutlineButton(
                            onPressed: () => Navigator.pop(context),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(localizations.close.capitalize()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            onPressed: () => _openOrderDetails(_orderItem),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(localizations.details.capitalize()),
                            ),
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
