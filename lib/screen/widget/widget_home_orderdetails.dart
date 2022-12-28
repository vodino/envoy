import 'package:flutter/cupertino.dart';

import '_widget.dart';

class HomeOrderDetailsAppBar extends DefaultAppBar {
  const HomeOrderDetailsAppBar({super.key, this.onTrailingPressed});

  final VoidCallback? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      automaticallyImplyLeading: false,
      border: const Border.fromBorderSide(BorderSide.none),
      leading: CustomButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(CupertinoIcons.clear_circled_solid, color: CupertinoColors.systemGrey),
      ),
      middle: Text(localizations.orderdetails.capitalize()),
      trailing: CustomButton(
        onPressed: onTrailingPressed,
        child: const Icon(CupertinoIcons.ellipsis_circle_fill, color: CupertinoColors.systemGrey),
      ),
    );
  }
}
