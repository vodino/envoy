import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:go_router/go_router.dart';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  /// Input
  late final FocusNode _pickupFocusNode;
  late final FocusNode _deliveryFocusNode;
  late final TextEditingController _pickupTextController;
  late final TextEditingController _deliveryTextController;

  void _listenDeliveryTextController() {
    final String query = _deliveryTextController.text;
    if (query.isNotEmpty) {
      print(query);
      _getDeliveryGeocoding(query, latLng: _myPosition!.position);
    }
  }

  /// BottomSheet
  late double _minChildSize;
  late double _maxChildSize;
  late final ValueNotifier<bool> _expanded;
  late final DraggableScrollableController _draggableScrollableController;

  void _jumpUp() {
    _draggableScrollableController.jumpTo(_maxChildSize);
  }

  void _jumpDown() {
    _draggableScrollableController.jumpTo(_minChildSize);
  }

  bool _onNotification(DraggableScrollableNotification notification) {
    if (notification.extent.toStringAsFixed(2) == notification.maxExtent.toStringAsFixed(2)) {
      _expanded.value = true;
    } else if (notification.extent.toStringAsFixed(2) == notification.minExtent.toStringAsFixed(2)) {
      _expanded.value = false;
      _closeKeyboard();
    }
    return true;
  }

  void _closeKeyboard() {
    if (!_expanded.value) {
      if (_pickupFocusNode.hasFocus) _pickupFocusNode.unfocus();
      if (_deliveryFocusNode.hasFocus) _deliveryFocusNode.unfocus();
    }
  }

  /// MapLibre
  MaplibreMapController? _mapController;
  late final ValueNotifier<bool> _myPositionFocus;

  void _onMapCreated(MaplibreMapController controller) {
    _mapController = controller;
    _goToMyPosition();
  }

  void _onCameraIdle(PointerMoveEvent event) {
    _myPositionFocus.value = false;
  }

  void _onStyleLoadedCallback() {
    _goToMyPosition();
  }

  void _onUserLocationUpdated(UserLocation location) {
    _locationService.value = UserLocationItemState(data: location);
  }

  void _goToMyPosition() async {
    if (_myPosition != null && _mapController != null && _myPositionFocus.value) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _myPosition!.position,
            zoom: 16.0,
          ),
        ),
        duration: const Duration(seconds: 1),
      );
    }
  }

  /// Customer
  void _onLeadingPressed(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  /// LocationService
  late final LocationService _locationService;
  StreamSubscription? _locationSubscription;
  UserLocation? _myPosition;

  LatLng? _pickupPosition;
  LatLng? _deliveryPosition;

  void _listenLocationState(BuildContext context, LocationState state) {
    if (state is UserLocationItemState) {
      _locationSubscription = state.subscription;
      _myPosition = state.data;
      _goToMyPosition();
    }
  }

  /// PlaceService
  late final PlaceService _deliveryPlaceService;
  late final PlaceService _pickupPlaceService;

  late List<PlaceSchema> _deliveryPlaces;
  late List<PlaceSchema> _pickupPlaces;

  void _getDeliveryGeocoding(
    String query, {
    required LatLng latLng,
  }) {
    _deliveryPlaceService.handle(
      GetGeocoding(
        long: latLng.longitude,
        lat: latLng.latitude,
        query: query,
      ),
    );
  }

  void _listenDeliveryState(BuildContext context, PlaceState state) {
    if (state is PlaceItemListState) {
      _deliveryPlaces = state.data;
    }
  }

  @override
  void initState() {
    super.initState();

    /// Input
    _pickupFocusNode = FocusNode();
    _deliveryFocusNode = FocusNode();
    _pickupTextController = TextEditingController();
    _deliveryTextController = TextEditingController();

    _deliveryTextController.addListener(_listenDeliveryTextController);

    /// BottomSheet
    _draggableScrollableController = DraggableScrollableController();
    final double shortesSide = window.physicalGeometry.width;
    final double longestSide = window.physicalGeometry.height;
    _minChildSize = (window.padding.bottom + (shortesSide * 0.42).clamp(300, 450)) / longestSide;
    _maxChildSize = (longestSide - window.padding.top - 24.0) / longestSide;
    _expanded = ValueNotifier(false);

    /// MapLibre
    _myPositionFocus = ValueNotifier(true);

    /// LocationService
    _locationService = LocationService.instance();

    /// PlaceService
    _deliveryPlaceService = PlaceService();
    _pickupPlaceService = PlaceService();
    _deliveryPlaces = [];
    _pickupPlaces = [];
  }

  @override
  void dispose() {
    _deliveryTextController.removeListener(_listenDeliveryTextController);
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: ValueListenableListener(
        listener: _listenLocationState,
        valueListenable: _locationService,
        child: Scaffold(
          drawer: const HomeDrawer(),
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          body: FractionallySizedBox(
            heightFactor: 1.05 - _minChildSize,
            child: Listener(
              onPointerMove: _onCameraIdle,
              child: HomeMap(
                onMapCreated: _onMapCreated,
                onUserLocationUpdated: _onUserLocationUpdated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
              ),
            ),
          ),
          appBar: HomeAppBar(onLeadingPressed: _onLeadingPressed),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Badge(
                  badgeContent: Text(
                    '01',
                    style: TextStyle(color: context.theme.colorScheme.surface),
                  ),
                  child: HomeFloatingActionButton(
                    onPressed: () => context.pushNamed(AuthScreen.name),
                    child: const Icon(CupertinoIcons.cube_box_fill),
                  ),
                ),
                HomeFloatingActionButton(
                  onPressed: () {
                    _myPositionFocus.value = true;
                    _goToMyPosition();
                  },
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
          bottomSheet: CustomKeepAlive(
            child: DraggableScrollableSheet(
              snap: true,
              expand: false,
              minChildSize: _minChildSize,
              maxChildSize: _maxChildSize,
              initialChildSize: _minChildSize,
              controller: _draggableScrollableController,
              snapSizes: [_minChildSize, _maxChildSize],
              builder: (context, scrollController) {
                return CustomScrollView(
                  controller: scrollController,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    const SliverPinnedHeader(child: CustomBar()),
                    SliverPinnedHeader(
                      child: HomeSearchFields(
                        deliveryTextController: _deliveryTextController,
                        deliveryFocusNode: _deliveryFocusNode,
                        pickupTextController: _pickupTextController,
                        pickupFocusNode: _pickupFocusNode,
                        onTap: _jumpUp,
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _expanded,
                      builder: (context, visible, child) {
                        return SliverVisibility(
                          visible: visible,
                          sliver: SliverToBoxAdapter(
                            child: CustomListTile(
                              onTap: () {
                                showCupertinoModalBottomSheet<bool>(
                                  context: context,
                                  builder: (context) {
                                    return const HomeSearchOrderScreen();
                                  },
                                );
                              },
                              title: const Text(
                                'Rechercher des commandes précédentes',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _expanded,
                      builder: (context, visible, child) {
                        return SliverVisibility(
                          visible: visible,
                          sliver: ValueListenableConsumer<PlaceState>(
                            listener: _listenDeliveryState,
                            valueListenable: _deliveryPlaceService,
                            builder: (context, state, child) {
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    if (index.isEven) {
                                      index ~/= 2;
                                      final item = _deliveryPlaces[index];
                                      return CustomListTile(
                                        leading: const Icon(CupertinoIcons.location_solid, size: 18.0),
                                        subtitle: const Text('37 km'),
                                        title: Text(item.title!),
                                        onTap: () async {
                                          final isOk = await showCupertinoModalBottomSheet<bool>(
                                            context: context,
                                            builder: (context) {
                                              return const HomeOrderScreen();
                                            },
                                          );
                                          if (isOk != null) {
                                            _jumpDown();
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return const HomeFinderScreen();
                                              },
                                            );
                                          }
                                        },
                                      );
                                    }
                                    return const Divider(indent: 40.0);
                                  },
                                  childCount: max(0, _deliveryPlaces.length * 2 - 1),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
