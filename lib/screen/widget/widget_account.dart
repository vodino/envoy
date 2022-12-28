import 'package:flutter/cupertino.dart';

import '_widget.dart';

class AccountAppBar extends DefaultAppBar {
  const AccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      transitionBetweenRoutes: false,
      middle: Text(localizations.profile.capitalize()),
    );
  }
}
