import 'package:flutter/cupertino.dart';

import 'internal_basic.dart';

class OrderDeliveriedAppBar extends DefaultAppBar {
  const OrderDeliveriedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      middle: Text('Commande'),
    );
  }
}
