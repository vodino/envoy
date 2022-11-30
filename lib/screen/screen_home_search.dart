import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '_screen.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({
    super.key,
    required this.popController,
  });

  final ValueNotifier<OrderSchema?> popController;

  static const String name = 'home_search';
  static const String path = 'search';

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> with SingleTickerProviderStateMixin {
  /// Customer
  late final ValueNotifier<bool> _bottomSheetController;

  void _openOrderCreateSheet({
    required BuildContext customContext,
    required PlaceSchema deliveryPlace,
    required PlaceSchema pickupPlace,
  }) async {
    if (ClientService.authenticated != null) {
      if (_deliveryFocusNode.hasFocus) _deliveryFocusNode.unfocus();
      if (_pickupFocusNode.hasFocus) _pickupFocusNode.unfocus();
      Navigator.push<OrderSchema>(
        customContext,
        CupertinoPageRoute(builder: (context) {
          return HomeOrderCreateScreen(
            order: OrderSchema(
              deliveryPlace: deliveryPlace,
              pickupPlace: pickupPlace,
            ),
          );
        }),
      );
    } else {
      await Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) {
            return const AuthScreen();
          },
        ),
      );
      if (ClientService.authenticated != null) {
        _openOrderCreateSheet(
          pickupPlace: pickupPlace,
          deliveryPlace: deliveryPlace,
          customContext: customContext,
        );
      }
    }
  }

  void _openOrdersSheet() async {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) {
        return const HomeOrderSearchScreen();
      }),
    );
  }

  /// Input
  late FocusNode _pickupFocusNode;
  late FocusNode _deliveryFocusNode;
  late TextEditingController _pickupTextController;
  late TextEditingController _deliveryTextController;

  void _onPickupTextChanged(String query) {
    if (query.isNotEmpty) {
      _getGeocoding(query: query, latLng: _myPosition != null ? LatLng(_myPosition!.latitude!, _myPosition!.longitude!) : null, service: _pickupPlaceService);
      _pickupPlaceItem.value = null;
    }
  }

  void _onDeliveryTextChanged(String query) {
    if (query.isNotEmpty) {
      _getGeocoding(query: query, latLng: _myPosition != null ? LatLng(_myPosition!.latitude!, _myPosition!.longitude!) : null, service: _deliveryPlaceService);
      _deliveryPlaceItem.value = null;
    }
  }

  void _onPlaceItemPressed(BuildContext context, PlaceSchema item, PlaceCategory category) {
    if (category == PlaceCategory.source) {
      if (_deliveryPlaceItem.value == null) {
        _pickupPlaceItem.value = item;
        _pickupTextController.text = item.title!;
        _deliveryFocusNode.requestFocus();
      } else {
        _openOrderCreateSheet(
          customContext: context,
          pickupPlace: item,
          deliveryPlace: _deliveryPlaceItem.value!,
        );
      }
    } else {
      if (_pickupPlaceItem.value == null) {
        _deliveryPlaceItem.value = item;
        _deliveryTextController.text = item.title!;
        _pickupFocusNode.requestFocus();
      } else {
        _openOrderCreateSheet(
          customContext: context,
          deliveryPlace: item,
          pickupPlace: _pickupPlaceItem.value!,
        );
      }
    }
  }

  void _showBottomSheet(PlaceCategory category) async {
    /// Input
    _pickupFocusNode = FocusNode();
    _deliveryFocusNode = FocusNode();
    _pickupTextController = TextEditingController(text: _pickupPlaceItem.value?.title);
    _deliveryTextController = TextEditingController();
    _bottomSheetController.value = true;

    final value = await showCupertinoModalBottomSheet<OrderSchema>(
      expand: true,
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return Navigator(
          onGenerateRoute: (settings) {
            return CupertinoPageRoute(
              builder: (context) {
                return _bottomSheet(category);
              },
            );
          },
        );
      },
    );
    _bottomSheetController.value = false;
    if (value != null && mounted) {
      widget.popController.value = value;
      Navigator.pop(context);
    }
  }

  /// LocationService
  late final LocationService _locationService;
  LocationData? _myPosition;

  void _listenLocationState(BuildContext context, LocationState state) {
    if (state is LocationItemState) {
      _myPosition = state.data;
      if (!_bottomSheetController.value) _getReverseGeocoding(latLng: LatLng(_myPosition!.latitude!, _myPosition!.longitude!), service: _pickupPlaceService);
    }
  }

  /// PlaceService
  late final PlaceService _pickupPlaceService;
  late final PlaceService _deliveryPlaceService;
  late final ValueNotifier<PlaceCategory?> _placeCategoryController;

  late final ValueNotifier<PlaceSchema?> _pickupPlaceItem;
  late final ValueNotifier<PlaceSchema?> _deliveryPlaceItem;

  void _getGeocoding({String? query, required LatLng? latLng, required PlaceService service}) {
    service.handle(FetchPlaces(longitude: latLng?.longitude, latitude: latLng?.latitude, query: query));
  }

  void _getReverseGeocoding({required LatLng? latLng, required PlaceService service}) {
    service.handle(FetchPlaces(longitude: latLng?.longitude, latitude: latLng?.latitude, type: PlaceType.reverseGeocoding));
  }

  void _listenDeliveryPlaceState(BuildContext context, PlaceState state) {}
  void _listenPickupPlaceState(BuildContext context, PlaceState state) {
    if (!_bottomSheetController.value && state is PlaceItemListState) {
      final items = state.data;
      if (items.isNotEmpty) _pickupPlaceItem.value = items.first;
    }
  }

  @override
  void initState() {
    super.initState();

    /// Customer
    _bottomSheetController = ValueNotifier(false);

    /// PlaceService
    _pickupPlaceService = PlaceService();
    _deliveryPlaceService = PlaceService();
    _pickupPlaceItem = ValueNotifier(null);
    _deliveryPlaceItem = ValueNotifier(null);
    _placeCategoryController = ValueNotifier(null);

    /// LocationService
    _locationService = LocationService.instance();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableListener<LocationState>(
      initiated: true,
      listener: _listenLocationState,
      valueListenable: _locationService,
      child: ValueListenableListener<PlaceState>(
        initiated: true,
        listener: _listenPickupPlaceState,
        valueListenable: _pickupPlaceService,
        child: ValueListenableListener<PlaceState>(
          initiated: true,
          listener: _listenDeliveryPlaceState,
          valueListenable: _deliveryPlaceService,
          child: BottomAppBar(
            elevation: 0.0,
            color: Colors.transparent,
            child: Hero(
              tag: HomeSearchScreen.name,
              child: Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomBar(),
                    ValueListenableBuilder<PlaceState>(
                      valueListenable: _pickupPlaceService,
                      builder: (context, state, child) {
                        return ValueListenableBuilder<PlaceSchema?>(
                          valueListenable: _pickupPlaceItem,
                          builder: (context, pickupPlaceItem, child) {
                            return HomeSearchFieldButtons(
                              onPickupPressed: () => _showBottomSheet(PlaceCategory.source),
                              onDeliveryPressed: () => _showBottomSheet(PlaceCategory.destination),
                              pickupWidget: pickupPlaceItem != null ? Text(pickupPlaceItem.title!) : null,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _itemSubtitlePrefix(PlaceOsmTag tag) {
    final localizarions = context.localizations;
    String? prefix;
    switch (tag) {
      case PlaceOsmTag.hospital:
        prefix = localizarions.hospital.capitalize();
        break;
      case PlaceOsmTag.airport:
        prefix = localizarions.airport.capitalize();
        break;
      default:
    }
    return prefix != null ? '$prefix • ' : '';
  }

  String _itemTitlePrefix(PlaceOsmTag tag) {
    final localizarions = context.localizations;
    String? prefix;
    switch (tag) {
      case PlaceOsmTag.neighbourhood:
        prefix = localizarions.neighbourhood.capitalize();
        break;
      default:
    }
    return prefix != null ? '$prefix ' : '';
  }

  Widget _listBuilder({
    required TextEditingController textEditingController,
    required PlaceCategory placeCategory,
    required PlaceService placeService,
    required FocusNode textFocusNode,
  }) {
    void listenerFocusNode(BuildContext context, FocusNode focusNode) {
      if (focusNode.hasFocus) _placeCategoryController.value = placeCategory;
    }

    return ChangeNotifierListener<FocusNode>(
      notifier: textFocusNode,
      listener: listenerFocusNode,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: textEditingController,
        builder: (context, textEditingValue, child) {
          return ValueListenableBuilder<PlaceCategory?>(
            valueListenable: _placeCategoryController,
            builder: (context, category, child) {
              return SliverVisibility(
                visible: category == placeCategory && textEditingValue.text.isNotEmpty,
                sliver: ValueListenableBuilder<PlaceState>(
                  valueListenable: placeService,
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
                                trailing: ValueListenableBuilder<LocationState>(
                                  valueListenable: _locationService,
                                  builder: (context, state, child) {
                                    return Visibility(
                                      visible: _myPosition != null,
                                      child: Builder(builder: (context) {
                                        return Text(
                                          '${NumberFormat.compactCurrency(
                                            decimalDigits: 1,
                                            symbol: '',
                                          ).format(LatLng(item.latitude!, item.longitude!).distance(LatLng(_myPosition!.latitude!, _myPosition!.longitude!)))}m',
                                          style: context.theme.textTheme.caption,
                                        );
                                      }),
                                    );
                                  },
                                ),
                                leading: const Icon(CupertinoIcons.location_solid, size: 18.0, color: CupertinoColors.systemGrey2),
                                subtitle: Text(_itemSubtitlePrefix(item.osmTag!) + item.subtitle!),
                                onTap: () => _onPlaceItemPressed(context, item, placeCategory),
                                title: Text(_itemTitlePrefix(item.osmTag!) + item.title!),
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
          );
        },
      ),
    );
  }

  Widget _bottomSheet(PlaceCategory category) {
    return DraggableScrollableSheet(
      minChildSize: 1.0,
      maxChildSize: 1.0,
      initialChildSize: 1.0,
      builder: (context, scrollController) {
        return Scaffold(
          body: BottomAppBar(
            elevation: 0.0,
            color: Colors.transparent,
            child: Hero(
              tag: HomeSearchScreen.name,
              child: Material(
                child: CustomScrollView(
                  controller: ModalScrollController.of(context),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverPinnedHeader(
                      child: HomeSearchFields(
                        pickupFocusNode: _pickupFocusNode,
                        onPickupChanged: _onPickupTextChanged,
                        deliveryFocusNode: _deliveryFocusNode,
                        onDeliveryChanged: _onDeliveryTextChanged,
                        pickupTextController: _pickupTextController,
                        deliveryTextController: _deliveryTextController,
                        pickupAutoFocus: category == PlaceCategory.source,
                        deliveryAutoFocus: category == PlaceCategory.destination,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomListTile(
                        onTap: _openOrdersSheet,
                        title: const Text(
                          'Rechercher des commandes précédentes',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    _listBuilder(
                      textEditingController: _deliveryTextController,
                      placeCategory: PlaceCategory.destination,
                      placeService: _deliveryPlaceService,
                      textFocusNode: _deliveryFocusNode,
                    ),
                    _listBuilder(
                      textEditingController: _pickupTextController,
                      placeCategory: PlaceCategory.source,
                      placeService: _pickupPlaceService,
                      textFocusNode: _pickupFocusNode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
