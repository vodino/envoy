import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  late double _height;

  void _trailingFloatingActionPressed() {
    _myPositionFocus.value = true;
    _goToMyPosition();
  }

  void _afterLayout(BuildContext context) {
    _context = context;
    _openHomeSearch();
  }

  void _openHomeSearch() {
    showBottomSheet(
      context: _context,
      builder: (context) {
        return const HomeSearchScreen();
      },
    );
  }

  /// MapLibre
  MaplibreMapController? _mapController;
  late final ValueNotifier<bool> _myPositionFocus;
  UserLocation? _myPosition;

  void _onMapCreated(MaplibreMapController controller) async {
    _mapController = controller;
    await _mapController!.updateContentInsets(EdgeInsets.only(bottom: _height * 0.3));
    _goToMyPosition();
  }

  void _onCameraIdle(PointerMoveEvent event) {
    _myPositionFocus.value = false;
  }

  void _onUserLocationUpdated(UserLocation location) {
    _locationService.value = UserLocationItemState(data: location);
  }

  void _goToMyPosition() async {
    if (_myPosition != null && _mapController != null && _myPositionFocus.value) {
      final position = _myPosition!.position;
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: position, zoom: 16.0)),
        duration: const Duration(seconds: 1),
      );
    }
  }

  /// LocationService
  late final LocationService _locationService;
  StreamSubscription? _locationSubscription;

  void _listenLocationState(BuildContext context, LocationState state) {
    if (state is UserLocationItemState) {
      _locationSubscription = state.subscription;
      _myPosition = state.data;
      _goToMyPosition();
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
    return Scaffold(
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
    );
  }
}
