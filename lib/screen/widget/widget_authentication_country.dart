import 'package:flutter/cupertino.dart';

import '_widget.dart';

class AuthCountryAppBar extends DefaultAppBar {
  const AuthCountryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      middle: Text(localizations.selectcountry.capitalize()),
      border: const Border.fromBorderSide(BorderSide.none),
      backgroundColor: context.theme.colorScheme.surface,
      automaticallyImplyLeading: false,
      transitionBetweenRoutes: false,
    );
  }
}
