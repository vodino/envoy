import 'package:flutter/cupertino.dart';

import '_widget.dart';

class OrderFeedbackAppBar extends DefaultAppBar {
  const OrderFeedbackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      middle: Text('Evaluation'),
    );
  }
}
