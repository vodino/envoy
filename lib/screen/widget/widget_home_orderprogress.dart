import 'package:flutter/cupertino.dart';

import '_widget.dart';

class HomeOrderProgressAppBar extends DefaultAppBar {
  const HomeOrderProgressAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      middle:  Text("${localizations.pendingorder.capitalize()}..."),
      border: const Border.fromBorderSide(BorderSide.none),
      backgroundColor: context.theme.colorScheme.surface,
      automaticallyImplyLeading: false,
      transitionBetweenRoutes: false,
    );
  }
}
