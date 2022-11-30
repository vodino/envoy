import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

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
  late final GlobalKey<ScaffoldState> _scaffoldState;
  late final BuildContext _context;
  late MediaQueryData _mediaQuery;
  late double _height;

  void _trailingFloatingActionPressed() {
    _myPositionFocus.value = true;
    _goToMyPosition();
  }

  void _afterLayout(BuildContext context) {
    _context = context;
    _openHomeSearch();
  }

  void _openHomeFinder(OrderSchema order) async {
    final popController = ValueNotifier<OrderSchema?>(null);
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
    } else {
      _openHomeSearch();
    }
  }

  void _openHomeSearch() async {
    final popController = ValueNotifier<OrderSchema?>(null);
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
    if (value != null) _openHomeFinder(value);
  }

  /// MapLibre
  MaplibreMapController? _mapController;
  late final ValueNotifier<bool> _myPositionFocus;
  UserLocation? _userLocation;

  void _onMapCreated(MaplibreMapController controller) async {
    _mapController = controller;
    await _mapController!.updateContentInsets(
      EdgeInsets.only(bottom: _height * 0.3, right: 16.0, left: 16.0),
    );
    _goToMyPosition();
  }

  void _onUserLocationUpdated(UserLocation location) {
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

  void _drawLines(List<RouteSchema> routes) async {
    await _mapController?.clearLines();

    ///
    const options = LineOptions(lineColor: "#ff0000", lineJoin: 'round', lineWidth: 4.0);
    for (final route in routes) {
      await _mapController?.addLine(
        options.copyWith(LineOptions(geometry: route.coordinates)),
      );
      final bottom = _mediaQuery.size.height * 0.55;
      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(route.bounds!, bottom: bottom),
      );
    }
  }

  /// LocationService
  late final LocationService _locationService;
  StreamSubscription? _locationSubscription;
  LocationData? _myPosition;

  void _getCurrentLocation() {
    _locationService.handle(const GetLocation(subscription: true, distanceFilter: 5));
  }

  void _listenLocationState(BuildContext context, LocationState state) {
    if (state is LocationItemState) {
      _locationSubscription = state.subscription;
      _myPosition = state.data;
      _goToMyPosition();
    }
  }

  /// RouteService
  late final RouteService _routeService;

  void _listenRouteState(BuildContext context, RouteState state) {
    if (state is InitRouteState) {
      _mapController?.clearLines();
    } else if (state is RouteItemListState) {
      _drawLines(state.data);
    }
  }

  @override
  void initState() {
    super.initState();

    /// Customer
    _scaffoldState = GlobalKey();

    /// Maplibre
    _myPositionFocus = ValueNotifier(true);

    /// LocationService
    _locationService = LocationService.instance();
    _getCurrentLocation();

    /// RouteService
    _routeService = RouteService.instance();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mediaQuery = MediaQuery.of(context);
    _height = _mediaQuery.size.height;
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableListener(
      listener: _listenRouteState,
      valueListenable: _routeService,
      child: Scaffold(
        extendBody: true,
        key: _scaffoldState,
        appBar: const HomeAppBar(),
        drawer: const HomeDrawer(),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        floatingActionButton: HomeFloatingActionButton(
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
        body: ValueListenableListener(
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
    );
  }
}
