import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '_widget.dart';

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

  void _onSwichPressed() {
    if (pickupTextController != null && deliveryTextController != null) {
      final deliveryText = deliveryTextController!.text;
      final pickupText = pickupTextController!.text;
      deliveryTextController!.text = pickupText;
      pickupTextController!.text = deliveryText;
    }
  }

  Widget _mapButton({
    required VoidCallback? onPressed,
  }) {
    return CustomButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: const Icon(CupertinoIcons.map, color: CupertinoColors.systemGrey, size: 20.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    const contentPadding = EdgeInsets.only(right: 40.0, top: 8.0, bottom: 8.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Stack(
        children: [
          Positioned(
            child: CustomBoxShadow(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Center(
                        child: TextField(
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
                      ),
                    ),
                    const Divider(indent: 45.0),
                    Expanded(
                      child: Center(
                        child: TextField(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 18.0,
            bottom: 0.0,
            child: Center(
              child: CustomButton(
                onPressed: _onSwichPressed,
                child: const Icon(
                  CupertinoIcons.arrow_up_arrow_down_circle_fill,
                  size: 35.0,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSearchShimmer extends StatelessWidget {
  const HomeSearchShimmer({super.key});

  Widget _tile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
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

class HomeSearchFieldButtons extends StatelessWidget {
  const HomeSearchFieldButtons({
    super.key,
    this.onPickupPressed,
    this.onDeliveryPressed,
    required this.pickupWidget,
    required this.deliveryWidget,
  });

  final Widget pickupWidget;
  final Widget deliveryWidget;
  final VoidCallback? onPickupPressed;
  final VoidCallback? onDeliveryPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CustomBoxShadow(
        child: Column(
          children: [
            CustomButton(
              onPressed: onPickupPressed,
              child: CustomListTile(
                height: 60.0,
                title: pickupWidget,
                leading: const Icon(CupertinoIcons.circle, size: 16.0, color: CupertinoColors.activeBlue),
              ),
            ),
            const Divider(indent: 40.0),
            CustomButton(
              onPressed: onDeliveryPressed,
              child: CustomListTile(
                height: 60.0,
                title: deliveryWidget,
                leading: const Icon(CupertinoIcons.circle, size: 16.0, color: CupertinoColors.activeOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
