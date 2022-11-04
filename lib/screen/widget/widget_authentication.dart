import 'package:flutter/cupertino.dart';

import '_widget.dart';

class AuthAppBar extends DefaultAppBar {
  const AuthAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      border: Border.fromBorderSide(BorderSide.none),
    );
  }
}
