import 'package:flutter/cupertino.dart';

import '_widget.dart';

class HomeDeliveryAppBar extends DefaultAppBar {
  const HomeDeliveryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      border: const Border.fromBorderSide(BorderSide.none),
      middle: const Text("Livraisons en cours..."),
      backgroundColor: context.theme.colorScheme.surface,
      automaticallyImplyLeading: false,
    );
  }
}
