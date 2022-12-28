import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_screen.dart';

class LocationMapScreen extends StatefulWidget {
  const LocationMapScreen({
    super.key,
    required this.category,
    required this.postion,
  });

  final LatLng postion;
  final PlaceCategory category;

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  /// Customer
  late double _width;
  late double _height;

  void _trailingFloatingActionPressed() {
    _myPositionFocus.value = true;
    _goToMyPosition();
  }

  String _itemSubtitlePrefix(PlaceOsmTag? tag) {
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

  String _itemTitlePrefix(PlaceOsmTag? tag) {
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

  /// MapLibre
  MaplibreMapController? _mapController;
  late final ValueNotifier<bool> _myPositionFocus;
  UserLocation? _userLocation;

  void _onMapCreated(MaplibreMapController controller) async {
    _mapController = controller;
    final bottom = Platform.isIOS ? _height * 0.2 : _height * 0.5;
    await _mapController!.updateContentInsets(EdgeInsets.only(bottom: bottom, right: 16.0, left: 16.0));
    _goToPosition(widget.postion);
  }

  void _onUserLocationUpdated(UserLocation location) {
    _userLocation = location;
    _goToMyPosition();
  }

  void _onCameraIdle() {
    if (_myPositionFocus.value) _getReverseGeocoding(_mapController!.cameraPosition!.target);
  }

  void _onPointUp(PointerUpEvent event) {
    _myPositionFocus.value = false;
    if (_mapController != null) _getReverseGeocoding(_mapController!.cameraPosition!.target);
  }

  void _goToMyPosition() async {
    if (_userLocation != null && _mapController != null && _myPositionFocus.value) {
      _goToPosition(_userLocation!.position);
    }
  }

  void _goToPosition(LatLng position) async {
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: position,
        zoom: 16.0,
      )),
    );
  }

  /// PlaceService
  late final PlaceService _placeService;
  late final ValueNotifier<Place?> _placeItem;

  void _getReverseGeocoding(LatLng? latLng) {
    _placeService.handle(FetchPlaces(longitude: latLng?.longitude, latitude: latLng?.latitude, type: PlaceType.reverseGeocoding));
  }

  void _listenPlaceState(BuildContext context, PlaceState state) {
    if (state is PlaceItemListState) {
      final items = state.data;
      if (items.isNotEmpty) _placeItem.value = items.first;
    }
  }

  @override
  void initState() {
    super.initState();

    /// Maplibre
    _myPositionFocus = ValueNotifier(false);

    /// PlaceService
    _placeService = PlaceService();
    _placeItem = ValueNotifier(null);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getReverseGeocoding(widget.postion));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    _height = mediaQuery.size.height;
    _width = mediaQuery.size.width;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return ValueListenableListener<PlaceState>(
      initiated: true,
      listener: _listenPlaceState,
      valueListenable: _placeService,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: const LocationMapAppBar(),
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
        body: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Listener(
                  onPointerUp: _onPointUp,
                  child: HomeMap(
                    onCameraIdle: _onCameraIdle,
                    onMapCreated: _onMapCreated,
                    onUserLocationUpdated: _onUserLocationUpdated,
                    initialCameraPosition: CameraPosition(target: widget.postion),
                  ),
                ),
              ),
              Positioned(
                left: (_width * 0.5) - 40.0,
                top: (Platform.isIOS ? _height * 0.2 : _height * 0.5) + 45.0,
                child: Assets.images.pin.image(height: 100.0, width: 80.0),
              ),
            ],
          ),
        ),
        bottomSheet: BottomAppBar(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomListTile(
                leading: Icon(CupertinoIcons.circle, color: widget.category == PlaceCategory.source ? CupertinoColors.activeBlue : CupertinoColors.activeOrange, size: 16.0),
                title: Text(
                  widget.category == PlaceCategory.source ? localizations.pickuppoint.capitalize() : localizations.deliverypoint.capitalize(),
                  style: context.cupertinoTheme.textTheme.navTitleTextStyle,
                ),
              ),
              const Divider(),
              ValueListenableBuilder<Place?>(
                valueListenable: _placeItem,
                builder: (context, item, child) {
                  String? title;
                  String? subtitle;
                  if (item != null) {
                    title = _itemTitlePrefix(item.osmTag) + (item.title ?? item.subtitle ?? '');
                    subtitle = _itemSubtitlePrefix(item.osmTag) + (item.subtitle ?? '');
                  }
                  VoidCallback? onPressed = () => Navigator.pop(context, item?.copyWith(title: title, subtitle: subtitle));
                  if (item == null) onPressed = null;
                  final style = TextStyle(color: onPressed == null ? CupertinoColors.systemGrey2 : null);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomListTile(
                        height: 55.0,
                        title: Text(title ?? 'Chargement...'),
                        subtitle: subtitle != null ? Text(subtitle) : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: CupertinoButton.filled(
                          onPressed: onPressed,
                          padding: EdgeInsets.zero,
                          child: Text(localizations.finished.capitalize(), style: style),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
