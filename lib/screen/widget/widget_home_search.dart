import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '_widget.dart';

class HomeSearchFields extends StatelessWidget {
  const HomeSearchFields({
    super.key,
    this.deliveryAutoFocus = false,
    this.deliveryTextController,
    this.onDeliveryChanged,
    this.deliveryFocusNode,
    this.onDeliveryMapPressed,
    this.pickupAutoFocus = false,
    this.pickupTextController,
    this.onPickupChanged,
    this.onPickupMapPressed,
    this.pickupFocusNode,
    this.onSwitch,
    this.onTap,
  });

  final TextEditingController? pickupTextController;
  final ValueChanged<String>? onPickupChanged;
  final VoidCallback? onPickupMapPressed;
  final FocusNode? pickupFocusNode;
  final bool pickupAutoFocus;

  final TextEditingController? deliveryTextController;
  final ValueChanged<String>? onDeliveryChanged;
  final VoidCallback? onDeliveryMapPressed;
  final FocusNode? deliveryFocusNode;
  final bool deliveryAutoFocus;

  final VoidCallback? onSwitch;
  final VoidCallback? onTap;

  void _onSwitchPressed() {
    if (pickupTextController != null && deliveryTextController != null) {
      final deliveryText = deliveryTextController!.text;
      final pickupText = pickupTextController!.text;
      deliveryTextController!.text = pickupText;
      pickupTextController!.text = deliveryText;
      if (deliveryFocusNode!.hasFocus) {
        pickupFocusNode!.requestFocus();
      } else {
        deliveryFocusNode!.requestFocus();
      }
      onSwitch?.call();
    }
  }

  Widget _mapButton({
    required VoidCallback? onPressed,
  }) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: VerticalDivider(),
        ),
        CupertinoButton(
          onPressed: onPressed,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: const Icon(CupertinoIcons.map, color: CupertinoColors.systemGrey, size: 20.0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    const suffixInsets = EdgeInsetsDirectional.fromSTEB(8.0, 0, 12.0, 0.5);
    const prefixInsets = EdgeInsetsDirectional.fromSTEB(12.0, 0, 8.0, 0.5);
    return Material(
      child: Column(
        children: [
          const CustomBar(),
          const SizedBox(height: 16.0),
          Stack(
            children: [
              Positioned(
                child: CustomBoxShadow(
                  child: SizedBox(
                    height: 120.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Form(
                            child: Row(
                              children: [
                                Expanded(
                                  child: CupertinoSearchTextField(
                                    onTap: onTap,
                                    autofocus: pickupAutoFocus,
                                    focusNode: pickupFocusNode,
                                    onChanged: onPickupChanged,
                                    prefixInsets: prefixInsets,
                                    suffixInsets: suffixInsets,
                                    borderRadius: BorderRadius.zero,
                                    controller: pickupTextController,
                                    backgroundColor: Colors.transparent,
                                    suffixMode: OverlayVisibilityMode.editing,
                                    suffixIcon: const Icon(CupertinoIcons.clear),
                                    prefixIcon: const Icon(CupertinoIcons.search, color: CupertinoColors.activeBlue),
                                  ),
                                ),
                                ChangeNotifierBuilder<FocusNode>(
                                  notifier: pickupFocusNode!,
                                  builder: (context, focusNode, child) {
                                    return Visibility(
                                      visible: focusNode.hasFocus,
                                      child: _mapButton(onPressed: onDeliveryMapPressed),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(indent: 45.0),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: CupertinoSearchTextField(
                                  onTap: onTap,
                                  suffixInsets: suffixInsets,
                                  prefixInsets: prefixInsets,
                                  autofocus: deliveryAutoFocus,
                                  focusNode: deliveryFocusNode,
                                  onChanged: onDeliveryChanged,
                                  borderRadius: BorderRadius.zero,
                                  controller: deliveryTextController,
                                  backgroundColor: Colors.transparent,
                                  suffixIcon: const Icon(CupertinoIcons.clear),
                                  placeholder: localizations.wheretodelivery.capitalize(),
                                  prefixIcon: const Icon(CupertinoIcons.search, color: CupertinoColors.activeOrange),
                                ),
                              ),
                              ChangeNotifierBuilder<FocusNode>(
                                notifier: deliveryFocusNode!,
                                builder: (context, focusNode, child) {
                                  return Visibility(
                                    visible: focusNode.hasFocus,
                                    child: _mapButton(onPressed: onDeliveryMapPressed),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Center(
                  child: CustomButton(
                    onPressed: _onSwitchPressed,
                    child: const Icon(
                      CupertinoIcons.arrow_up_arrow_down_circle_fill,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ),
            ],
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
    this.pickupWidget,
    this.deliveryWidget,
  });
  final Widget? pickupWidget;
  final Widget? deliveryWidget;
  final VoidCallback? onPickupPressed;
  final VoidCallback? onDeliveryPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
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
                subtitle: pickupWidget == null ? const Text('Point de ramassage') : null,
                leading: const Icon(CupertinoIcons.circle, size: 16.0, color: CupertinoColors.activeBlue),
              ),
            ),
            const Divider(indent: 40.0),
            CustomButton(
              onPressed: onDeliveryPressed,
              child: CustomListTile(
                height: 60.0,
                title: deliveryWidget,
                subtitle: deliveryWidget == null ? Text(localizations.wheretodelivery.capitalize()) : null,
                leading: const Icon(CupertinoIcons.circle, size: 16.0, color: CupertinoColors.activeOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
