import 'package:flutter/material.dart';

import '_screen.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> with SingleTickerProviderStateMixin {
  /// CustomBottomSheet
  late final CustomBottomSheetController _bottomSheetController;

  void _jumpUp() {
    _bottomSheetController.open();
  }

  void _listenBottomSheetController() {
    if (!_bottomSheetController.value) {
      if (_pickupFocusNode.hasFocus) _pickupFocusNode.unfocus();
      if (_deliveryFocusNode.hasFocus) _deliveryFocusNode.unfocus();
    }
  }

  /// Input
  late final FocusNode _pickupFocusNode;
  late final FocusNode _deliveryFocusNode;
  late final TextEditingController _pickupTextController;
  late final TextEditingController _deliveryTextController;

  void _listenPickupTextController() {
    final String query = _pickupTextController.text;
    if (query.isNotEmpty) {}
  }

  void _listenDeliveryTextController() {
    final String query = _deliveryTextController.text;
    if (query.isNotEmpty) {}
  }

  @override
  void initState() {
    super.initState();

    /// CustomBottomSheet
    _bottomSheetController = CustomBottomSheetController();
    _bottomSheetController.addListener(_listenBottomSheetController);

    /// Input
    _pickupFocusNode = FocusNode();
    _deliveryFocusNode = FocusNode();
    _pickupTextController = TextEditingController();
    _deliveryTextController = TextEditingController();
    _pickupTextController.addListener(_listenPickupTextController);
    _deliveryTextController.addListener(_listenDeliveryTextController);
  }

  @override
  void dispose() {
    /// CustomBottomSheet
    _bottomSheetController.removeListener(_listenBottomSheetController);

    /// Input
    _pickupTextController.removeListener(_listenPickupTextController);
    _deliveryTextController.removeListener(_listenDeliveryTextController);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: DraggableScrollableSheet(
        snap: true,
        expand: false,
        maxChildSize: 0.9,
        snapSizes: const [0.25, 0.9],
        builder: (context, scrollController) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPinnedHeader(
                child: Column(
                  children: const [
                    CustomBar(),
                    HomeSearchFields(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
