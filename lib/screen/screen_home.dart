import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  /// Input
  late final FocusNode _pickupFocusNode;
  late final FocusNode _deliveryFocusNode;
  late final TextEditingController _pickupTextController;
  late final TextEditingController _deliveryTextController;

  /// BottomSheet
  late final DraggableScrollableController _draggableScrollableController;

  void _jumpUp() {
    _draggableScrollableController.jumpTo(1.0);
  }

  void _jumpDown() {
    _draggableScrollableController.jumpTo(0.0);
  }

  bool _onNotification(DraggableScrollableNotification notification) {
    if (notification.extent == notification.minExtent) {
      if (_pickupFocusNode.hasFocus) _pickupFocusNode.unfocus();
      if (_deliveryFocusNode.hasFocus) _deliveryFocusNode.unfocus();
    }
    return true;
  }

  /// MapLibre
  MaplibreMapController? _mapController;

  void _onMapCreated(MaplibreMapController controller) {
    _mapController = controller;
  }

  void _goToMyPosition() async {
    if (_myPosition != null && _mapController != null) {
      await _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(_myPosition!.latitude!, _myPosition!.longitude!), 16),
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
  LocationData? _myPosition;

  Future<void> _getLocation() {
    return _locationService.handle(const GetLocation(distanceFilter: 0.0, subscription: true));
  }

  void _listenLocationState(BuildContext context, LocationState state) {
    if (state is LocationItemState) {
      _locationSubscription = state.subscription;
      _myPosition = state.data;
      _goToMyPosition();
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

    /// BottomSheet
    _draggableScrollableController = DraggableScrollableController();

    /// LocationService
    _locationService = LocationService.instance();
    if (_locationService.value is! LocationItemState) _getLocation();
  }

  @override
  void dispose() {
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
          body: HomeMap(onMapCreated: _onMapCreated),
          appBar: HomeAppBar(onLeadingPressed: _onLeadingPressed),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeActiveOrderButton(onPressed: () => context.pushNamed(AuthScreen.name)),
                HomeMyPositionButton(onPressed: _goToMyPosition),
              ],
            ),
          ),
          bottomSheet: HomeBottomSheet(
            maxChildSize: 0.95,
            controller: _draggableScrollableController,
            builder: (context, scrollController) {
              return CustomScrollView(
                controller: scrollController,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  const SliverPinnedHeader(child: CustomBar()),
                  SliverPinnedHeader(
                    child: HomeBoxShadow(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onTap: _jumpUp,
                            focusNode: _pickupFocusNode,
                            controller: _pickupTextController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              suffix: CustomButton(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: const Icon(
                                  CupertinoIcons.map,
                                  color: CupertinoColors.systemGrey,
                                  size: 20.0,
                                ),
                                onPressed: () {},
                              ),
                              prefixIcon: const Icon(CupertinoIcons.search, color: CupertinoColors.activeBlue),
                              labelText: 'Point de départ',
                            ),
                          ),
                          const Divider(indent: 45.0),
                          TextField(
                            onTap: _jumpUp,
                            focusNode: _deliveryFocusNode,
                            keyboardType: TextInputType.name,
                            controller: _deliveryTextController,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              suffix: CustomButton(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: const Icon(
                                  CupertinoIcons.map,
                                  color: CupertinoColors.systemGrey,
                                  size: 20.0,
                                ),
                                onPressed: () {},
                              ),
                              prefixIcon: const Icon(CupertinoIcons.search, color: CupertinoColors.activeOrange),
                              labelText: "Où livrer ?",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return CustomListTile(
                          leading: const Icon(CupertinoIcons.location_solid, size: 18.0),
                          title: const Text("Quartier Akeikoi"),
                          subtitle: const Text('37 km'),
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
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
