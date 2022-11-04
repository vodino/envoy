import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_widget.dart';

class HomeAppBar extends DefaultAppBar {
  const HomeAppBar({
    super.key,
    this.onLeadingPressed,
  });

  final ValueChanged<BuildContext>? onLeadingPressed;

  @override
  Size get preferredSize => super.preferredSize * 1.2;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [BoxShadow(spreadRadius: -12.0, blurRadius: 20.0)],
            borderRadius: BorderRadius.circular(8.0),
            color: theme.colorScheme.surface,
          ),
          child: CustomButton(
            minSize: 40.0,
            padding: EdgeInsets.zero,
            backgroundColor: context.theme.colorScheme.surface,
            onPressed: onLeadingPressed != null ? () => onLeadingPressed?.call(context) : null,
            child: Icon(Icons.sort_rounded, color: context.theme.colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}

class CustomBar extends StatelessWidget {
  const CustomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: FractionallySizedBox(
          widthFactor: 0.15,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: const Divider(
              color: CupertinoColors.systemFill,
              thickness: 5.0,
              height: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeMap extends StatelessWidget {
  const HomeMap({
    super.key,
    this.onMapClick,
    this.onMapCreated,
    this.onMapLongClick,
    this.initialCameraPosition,
    this.onUserLocationUpdated,
    this.onStyleLoadedCallback,
  });

  final OnMapClickCallback? onMapClick;
  final MapCreatedCallback? onMapCreated;
  final OnMapClickCallback? onMapLongClick;
  final VoidCallback? onStyleLoadedCallback;
  final CameraPosition? initialCameraPosition;
  final OnUserLocationUpdated? onUserLocationUpdated;

  @override
  Widget build(BuildContext context) {
    return MaplibreMap(
      compassEnabled: false,
      onMapClick: onMapClick,
      myLocationEnabled: true,
      onMapCreated: onMapCreated,
      onMapLongClick: onMapLongClick,
      onUserLocationUpdated: onUserLocationUpdated,
      onStyleLoadedCallback: onStyleLoadedCallback ?? () {},
      gestureRecognizers: {Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())},
      initialCameraPosition: initialCameraPosition ?? const CameraPosition(target: LatLng(0.0, 0.0)),
      styleString: 'https://api.maptiler.com/maps/57a3fe25-6f58-47b5-863f-ffd1be0122eb/style.json?key=ohdDnBihXL3Yk2cDRMfO',
    );
  }
}

class HomeBottomSheet extends StatefulWidget {
  const HomeBottomSheet({
    super.key,
    this.controller,
    this.maxChildSize,
    this.minChildSize,
    required this.builder,
  });

  final double? minChildSize;
  final double? maxChildSize;
  final ScrollableWidgetBuilder builder;
  final DraggableScrollableController? controller;

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  /// Size
  late double _minChildSize;
  late double _maxChildSize;

  @override
  void initState() {
    super.initState();

    /// Size
    final double shortesSide = window.physicalGeometry.width;
    final double longestSide = window.physicalGeometry.height;
    _minChildSize = widget.minChildSize ?? (window.padding.bottom + (shortesSide * 0.42).clamp(300, 450)) / longestSide;
    _maxChildSize = (longestSide - window.padding.top - 24.0) / longestSide;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      expand: false,
      builder: widget.builder,
      minChildSize: _minChildSize,
      maxChildSize: _maxChildSize,
      controller: widget.controller,
      initialChildSize: _minChildSize,
      snapSizes: [_minChildSize, _maxChildSize],
    );
  }
}

class HomeMyPositionButton extends StatelessWidget {
  const HomeMyPositionButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      elevation: 0.8,
      heroTag: 'location',
      onPressed: onPressed,
      backgroundColor: context.theme.colorScheme.onSurface,
      child: const Icon(CupertinoIcons.location),
    );
  }
}

class HomeActiveOrderButton extends StatelessWidget {
  const HomeActiveOrderButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      elevation: 0.8,
      heroTag: 'cube_box',
      onPressed: onPressed,
      backgroundColor: context.theme.colorScheme.onSurface,
      child: const Icon(CupertinoIcons.cube_box),
    );
  }
}
