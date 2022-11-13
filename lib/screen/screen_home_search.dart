import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '_screen.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> with SingleTickerProviderStateMixin {
  /// Input
  late final FocusNode _pickupFocusNode;
  late final FocusNode _deliveryFocusNode;
  late final TextEditingController _pickupTextController;
  late final TextEditingController _deliveryTextController;

  void _listenPickupTextController(BuildContext context, TextEditingValue value) {
    final String query = value.text;
    if (query.isNotEmpty) {
      _getGeocoding(query, latLng: _myPosition!.position, service: _pickupPlaceService);
    }
  }

  void _listenDeliveryTextController(BuildContext context, TextEditingValue value) {
    final String query = value.text;
    if (query.isNotEmpty) {
      _getGeocoding(query, latLng: _myPosition!.position, service: _deliveryPlaceService);
    }
  }

  void _showBottomSheet() async {
    await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return _bottomSheet();
      },
    );

    _pickupTextController.clear();
    _deliveryTextController.clear();
  }

  /// LocationService
  late final LocationService _locationService;
  UserLocation? _myPosition;

  void _listenLocationState(BuildContext context, LocationState state) {
    if (state is UserLocationItemState) {
      _myPosition = state.data;
    }
  }

  /// PlaceService
  late final PlaceService _pickupPlaceService;
  late final PlaceService _deliveryPlaceService;

  void _getGeocoding(String query, {required LatLng latLng, required PlaceService service}) {
    service.handle(
      GetGeocoding(
        long: latLng.longitude,
        lat: latLng.latitude,
        query: query,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    /// Input
    _pickupFocusNode = FocusNode();
    _deliveryFocusNode = FocusNode();
    _pickupTextController = TextEditingController();
    _deliveryTextController = TextEditingController();

    /// LocationService
    _locationService = LocationService.instance();

    /// PlaceService
    _pickupPlaceService = PlaceService();
    _deliveryPlaceService = PlaceService();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      color: Colors.transparent,
      child: Hero(
        tag: 'bottomsheet',
        child: Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomBar(),
              HomeSearchFieldButtons(
                pickupWidget: const Text('Point de ramassage'),
                deliveryWidget: const Text('Où livrer'),
                onDeliveryPressed: () => _showBottomSheet(),
                onPickupPressed: () => _showBottomSheet(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    return ValueListenableListener(
      initiated: true,
      listener: _listenLocationState,
      valueListenable: _locationService,
      child: Scaffold(
        body: BottomAppBar(
          elevation: 0.0,
          color: Colors.transparent,
          child: Hero(
            tag: 'bottomsheet',
            child: Material(
              child: CustomScrollView(
                controller: ModalScrollController.of(context),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverPinnedHeader(
                    child: Material(
                      child: Column(
                        children: [
                          const CustomBar(),
                          HomeSearchFields(
                            pickupFocusNode: _pickupFocusNode,
                            deliveryFocusNode: _deliveryFocusNode,
                            pickupTextController: _pickupTextController,
                            deliveryTextController: _deliveryTextController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomListTile(
                      onTap: () {},
                      title: const Text(
                        'Rechercher des commandes précédentes',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  ValueListenableConsumer<TextEditingValue>(
                    valueListenable: _deliveryTextController,
                    listener: _listenDeliveryTextController,
                    builder: (context, value, child) {
                      return SliverVisibility(
                        visible: value.text.isNotEmpty,
                        sliver: ValueListenableBuilder(
                          valueListenable: _deliveryPlaceService,
                          builder: (context, state, child) {
                            if (state is PendingPlaceState || state is CancelFailurePlaceState) {
                              return const SliverFillRemaining(child: HomeSearchShimmer());
                            } else if (state is PlaceItemListState) {
                              final items = state.data;
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    if (index.isEven) {
                                      index ~/= 2;
                                      final item = items[index];
                                      return CustomListTile(
                                        leading: const Icon(CupertinoIcons.location_solid, size: 18.0),
                                        subtitle: const Text('37 km'),
                                        title: Text(item.title!),
                                        onTap: () {},
                                      );
                                    }
                                    return const Divider(indent: 40.0);
                                  },
                                  childCount: max(0, items.length * 2 - 1),
                                ),
                              );
                            }
                            return const SliverToBoxAdapter();
                          },
                        ),
                      );
                    },
                  ),
                  ValueListenableConsumer<TextEditingValue>(
                    valueListenable: _pickupTextController,
                    listener: _listenPickupTextController,
                    builder: (context, value, child) {
                      return SliverVisibility(
                        visible: value.text.isNotEmpty,
                        sliver: ValueListenableBuilder(
                          valueListenable: _pickupPlaceService,
                          builder: (context, state, child) {
                            if (state is PendingPlaceState || state is CancelFailurePlaceState) {
                              return const SliverFillRemaining(child: HomeSearchShimmer());
                            } else if (state is PlaceItemListState) {
                              final items = state.data;
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    if (index.isEven) {
                                      index ~/= 2;
                                      final item = items[index];
                                      return CustomListTile(
                                        leading: const Icon(CupertinoIcons.location_solid, size: 18.0),
                                        subtitle: const Text('37 km'),
                                        title: Text(item.title!),
                                        onTap: () {},
                                      );
                                    }
                                    return const Divider(indent: 40.0);
                                  },
                                  childCount: max(0, items.length * 2 - 1),
                                ),
                              );
                            }
                            return const SliverToBoxAdapter();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
