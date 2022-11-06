import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:shimmer/shimmer.dart';

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

class HomeSearchFields extends StatelessWidget {
  const HomeSearchFields({
    super.key,
    this.deliveryTextController,
    this.deliveryFocusNode,
    this.deliveryMapPressed,
    this.pickupTextController,
    this.pickupMapPressed,
    this.pickupFocusNode,
    this.onTap,
  });

  final TextEditingController? pickupTextController;
  final VoidCallback? pickupMapPressed;
  final FocusNode? pickupFocusNode;

  final TextEditingController? deliveryTextController;
  final VoidCallback? deliveryMapPressed;
  final FocusNode? deliveryFocusNode;

  final VoidCallback? onTap;

  Widget _mapButton({
    required VoidCallback? onPressed,
  }) {
    return CustomButton(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: const Icon(
        CupertinoIcons.map,
        color: CupertinoColors.systemGrey,
        size: 20.0,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    const contentPadding = EdgeInsets.only(right: 40.0, top: 8.0, bottom: 8.0);
    return Stack(
      children: [
        Positioned(
          child: CustomBoxShadow(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  onTap: onTap,
                  focusNode: pickupFocusNode,
                  controller: pickupTextController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.search, color: CupertinoColors.activeBlue),
                    suffix: _mapButton(onPressed: pickupMapPressed),
                    contentPadding: contentPadding,
                    hintText: 'Point de départ',
                  ),
                ),
                const Divider(indent: 45.0, height: 16.0),
                TextField(
                  onTap: onTap,
                  focusNode: deliveryFocusNode,
                  keyboardType: TextInputType.name,
                  controller: deliveryTextController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.search, color: CupertinoColors.activeOrange),
                    suffix: _mapButton(onPressed: deliveryMapPressed),
                    contentPadding: contentPadding,
                    hintText: "Où livrer ?",
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          right: 18.0,
          bottom: 0.0,
          child: Center(
            child: CustomButton(
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.arrow_up_arrow_down_circle_fill,
                size: 35.0,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeMap extends StatelessWidget {
  const HomeMap({
    super.key,
    this.onMapClick,
    this.onCameraIdle,
    this.onMapCreated,
    this.onMapLongClick,
    this.initialCameraPosition,
    this.onUserLocationUpdated,
    this.onStyleLoadedCallback,
  });

  final VoidCallback? onCameraIdle;
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
      trackCameraPosition: true,
      onCameraIdle: onCameraIdle,
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

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: context.theme.colorScheme.onSurface,
      onPressed: onPressed,
      heroTag: UniqueKey(),
      elevation: 0.8,
      child: child,
    );
  }
}

class HomeSearchShimmer extends StatelessWidget {
  const HomeSearchShimmer({super.key});

  Widget _tile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 12.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          const SizedBox(height: 4.0),
          FractionallySizedBox(
            widthFactor: 0.8,
            alignment: Alignment.centerLeft,
            child: Container(
              height: 12.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: List.generate(6, (index) {
            return Colors.white.withOpacity(index * 0.2);
          }),
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.separated(
          itemCount: 8,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const Divider(
              indent: 45.0,
              height: 24.0,
              thickness: 0.8,
              color: CupertinoColors.systemGrey4,
            );
          },
          itemBuilder: (context, index) {
            return _tile();
          },
        ),
      ),
    );
  }
}
