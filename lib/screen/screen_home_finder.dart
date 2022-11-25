import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_screen.dart';

class HomeFinderScreen extends StatefulWidget {
  const HomeFinderScreen({
    super.key,
    required this.order,
    required this.popController,
  });

  final OrderSchema order;
  final ValueNotifier<OrderSchema?> popController;

  @override
  State<HomeFinderScreen> createState() => _HomeFinderScreenState();
}

class _HomeFinderScreenState extends State<HomeFinderScreen> {
  /// RouteService
  late final RouteService _routeService;

  void _listenRouteState(BuildContext context, RouteState state) {}

  void _getRoute() {
    _routeService.handle(GetRoute(
      destination: LatLng(
        widget.order.deliveryPlace.latitude!,
        widget.order.deliveryPlace.longitude!,
      ),
      source: LatLng(
        widget.order.pickupPlace.latitude!,
        widget.order.pickupPlace.longitude!,
      ),
    ));
  }

  /// PusherService
  late final PusherService _pusherService;

  void _listenPusherState(BuildContext context, PusherState state) {}

  void _subscribe() {
    _pusherService.handle(const SubscribeToEvent());
  }

  @override
  void initState() {
    super.initState();

    /// RouteService
    _routeService = RouteService.instance();
    _getRoute();

    /// PusherService
    _pusherService = PusherService();
    _subscribe();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableListener(
      listener: _listenPusherState,
      valueListenable: _pusherService,
      child: ValueListenableListener(
        listener: _listenRouteState,
        valueListenable: _routeService,
        child: DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.5,
          minChildSize: 0.5,
          initialChildSize: 0.5,
          builder: (context, scrollController) {
            return BottomAppBar(
              elevation: 0.0,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HomeFinderAppBar(),
                  Expanded(
                    child: HomeFinderLoader(image: Assets.images.motorbike),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: CustomOutlineButton(
                      child: const Text('Annuler'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
