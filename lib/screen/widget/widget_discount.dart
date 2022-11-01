import 'package:flutter/cupertino.dart';

import '_widget.dart';

class DiscountAppBar extends DefaultAppBar {
  const DiscountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      middle: Text('Coupons de réduction'),
    );
  }
}
