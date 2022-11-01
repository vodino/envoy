import 'package:flutter/cupertino.dart';

import '_widget.dart';

class SettingsAppBar extends DefaultAppBar {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      middle: Text('Paramètres'),
    );
  }
}
