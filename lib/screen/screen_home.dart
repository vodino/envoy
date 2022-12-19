import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String path = '/';
  static const String name = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Customer
  late final BuildContext _context;
  late double _height;

  void _trailingFloatingActionPressed() {
    _myPositionFocus.value = true;
    _goToMyPosition();
  }

  void _afterLayout(BuildContext context) {
    _context = context;
    _openHomeSearch();
  }

  void _openOrderFeedback(Order order) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return OrderFeedbackScreen(order: order);
      },
    );
  }

  void _openHomeOrderList() async {
    _clearMap();
    final popController = ValueNotifier<Order?>(null);
    final controller = showBottomSheet(
      context: _context,
      enableDrag: false,
      builder: (context) {
        return HomeDeliveryScreen(
          popController: popController,
        );
      },
    );
    await controller.closed;
    final value = popController.value;
    if (value != null) {
      _openTrackingOrder(value);
    } else {
      _openHomeSearch();
    }
  }

  void _openHomeFinder(Order order) async {
    final popController = ValueNotifier<Order?>(null);
    final controller = showBottomSheet(
      context: _context,
      enableDrag: false,
      builder: (context) {
        return HomeFinderScreen(
          popController: popController,
          order: order,
        );
      },
    );
    await controller.closed;
    final value = popController.value;
    if (value != null) {
      _openTrackingOrder(value);
    } else {
      _openHomeSearch();
    }
  }

  void _openTrackingOrder(Order data) async {
    final popController = ValueNotifier<Order?>(null);
    final controller = showBottomSheet(
      context: _context,
      enableDrag: false,
      builder: (context) {
        return HomeTrackingScreen(
          popController: popController,
          order: data,
        );
      },
    );
    await controller.closed;
    final value = popController.value;
    if (value != null) {
      _openHomeFinder(value);
    } else {
      _openHomeSearch();
    }
  }

  void _openHomeSearch() async {
    _clearMap();
    final popController = ValueNotifier<Order?>(null);
    final controller = showBottomSheet(
      context: _context,
      enableDrag: false,
      builder: (context) {
        return HomeSearchScreen(
          popController: popController,
        );
      },
    );
    await controller.closed;
    final value = popController.value;
    if (value != null) {
      _openHomeFinder(value);
    } else {
      _openHomeSearch();
    }
  }

  /// MapLibre
  MaplibreMapController? _mapController;
  late final ValueNotifier<bool> _myPositionFocus;
  UserLocation? _userLocation;

  void _onMapCreated(MaplibreMapController controller) async {
    _mapController = controller;
    await _mapController!.updateContentInsets(EdgeInsets.only(bottom: _height * 0.4, right: 16.0, left: 16.0));
    _goToMyPosition();
  }

  void _onUserLocationUpdated(UserLocation location) {
    if (_userLocation == null) {
      _locationService.value = LocationItemState(
        data: LocationData.fromMap({
          'longitude': location.position.longitude,
          'latitude': location.position.latitude,
        }),
      );
    }
    _userLocation = location;
  }

  void _onCameraIdle(PointerMoveEvent event) {
    _myPositionFocus.value = false;
  }

  void _goToMyPosition() async {
    if (_userLocation != null && _mapController != null && _myPositionFocus.value) {
      final position = _userLocation!.position;
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          bearing: _userLocation!.bearing!,
          target: position,
          zoom: 16.0,
        )),
      );
    }
  }

  Future<void> _drawLines(List<RouteSchema> routes) async {
    await _clearMap();

    /// Draw
    const options = LineOptions(lineColor: "#000000", lineJoin: 'round', lineWidth: 4.0);
    for (final route in routes) {
      _drawIcon(path: Assets.images.mappinBlue.path, position: route.coordinates!.last);
      _drawIcon(path: Assets.images.mappinOrange.path, position: route.coordinates!.first);
      _mapController!.addLine(options.copyWith(LineOptions(geometry: route.coordinates)));
      final bottom = _height * 0.55;
      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(route.bounds!, bottom: bottom));
    }
  }

  Future<void> _drawIcon({required String path, required LatLng position}) async {
    final buffer = await rootBundle.load(path);
    final bytes = buffer.buffer.asUint8List();
    await _mapController!.addImage(path, bytes);
    _mapController!.addSymbol(SymbolOptions(geometry: position, iconImage: path));
  }

  Future<void> _clearMap() async {
    if (_mapController == null) return;
    await Future.wait([
      _mapController!.clearLines(),
      _mapController!.clearSymbols(),
    ]);
  }

  /// LocationService
  late final LocationService _locationService;
  StreamSubscription? _locationSubscription;
  // LocationData? _myPosition;

  void _getCurrentLocation() {
    _locationService.handle(const GetLocation(subscription: true, distanceFilter: 5));
  }

  void _listenLocationState(BuildContext context, LocationState state) {
    if (state is LocationItemState) {
      _locationSubscription = state.subscription;
      // _myPosition = state.data;
      _goToMyPosition();
    }
  }

  /// RouteService
  late final RouteService _routeService;

  void _listenRouteState(BuildContext context, RouteState state) {
    if (state is InitRouteState) {
      _clearMap();
    } else if (state is RouteItemListState) {
      _drawLines(state.data);
    }
  }

  /// OrderService
  late final OrderService _orderService;
  late final OrderService _orderFeedbackService;

  void _getOrderFeedbackList() {
    _orderFeedbackService.handle(const GetOrderList(
      equalStatus: OrderStatus.delivered,
      fireImmediately: false,
      isNullStatus: false,
      subscription: true,
    ));
  }

  void _getOrderList() {
    _orderService.handle(const GetOrderList(
      notEqualStatus: OrderStatus.delivered,
      isNullStatus: false,
      subscription: true,
    ));
  }

  void _listenOrderState(BuildContext context, OrderState state) {}

  void _listenOrderFeedbackState(BuildContext context, OrderState state) {
    if (state is OrderItemListState) {
      _openOrderFeedback(state.data.first);
    }
  }

  @override
  void initState() {
    super.initState();

    /// Maplibre
    _myPositionFocus = ValueNotifier(true);

    /// LocationService
    _locationService = LocationService.instance();
    _getCurrentLocation();

    /// RouteService
    _routeService = RouteService.instance();

    /// OrderService
    _orderService = OrderService();
    _orderFeedbackService = OrderService();
    _getOrderList();
    _getOrderFeedbackList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    _height = mediaQuery.size.height;
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableListener(
      listener: _listenOrderFeedbackState,
      valueListenable: _orderFeedbackService,
      child: ValueListenableListener<RouteState>(
        listener: _listenRouteState,
        valueListenable: _routeService,
        child: Scaffold(
          extendBody: true,
          appBar: const HomeAppBar(),
          drawer: const HomeDrawer(),
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableConsumer<OrderState>(
                  listener: _listenOrderState,
                  valueListenable: _orderService,
                  builder: (context, state, child) {
                    List<Order>? items;
                    if (state is OrderItemListState) items = state.data;
                    return Visibility(
                      visible: items != null && items.isNotEmpty,
                      child: HomeFloatingActionButton(
                        onPressed: _openHomeOrderList,
                        child: Builder(builder: (context) {
                          return Badge(
                            badgeContent: Text(
                              items!.length.toString(),
                              style: const TextStyle(color: CupertinoColors.white),
                            ),
                            child: const Icon(CupertinoIcons.cube_box_fill),
                          );
                        }),
                      ),
                    );
                  },
                ),
                HomeFloatingActionButton(
                  onPressed: _trailingFloatingActionPressed,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _myPositionFocus,
                    builder: (context, visible, child) {
                      return Visibility(
                        visible: visible,
                        replacement: const Icon(CupertinoIcons.location),
                        child: const Icon(CupertinoIcons.location_fill),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          body: ValueListenableListener(
            initiated: true,
            listener: _listenLocationState,
            valueListenable: _locationService,
            child: AfterLayout(
              listener: _afterLayout,
              child: Listener(
                onPointerMove: _onCameraIdle,
                child: HomeMap(
                  onMapCreated: _onMapCreated,
                  onUserLocationUpdated: _onUserLocationUpdated,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
