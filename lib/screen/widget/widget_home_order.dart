import 'package:flutter/cupertino.dart';

import '_widget.dart';

class HomeOrderAppBar extends DefaultAppBar {
  const HomeOrderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      automaticallyImplyLeading: false,
      middle: const Text('Commande'),
      leading: CustomButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(
          'Annuler',
          style: TextStyle(color: CupertinoColors.destructiveRed),
        ),
      ),
    );
  }
}
