import 'package:flutter/cupertino.dart';

import '_widget.dart';

class HomeSearchOrderAppBar extends DefaultAppBar {
  const HomeSearchOrderAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      transitionBetweenRoutes: false,
      automaticallyImplyLeading: false,
      middle: const CustomSearchTextField(
        autofocus: true,
        placeholder: 'nom ou numéro du client',
      ),
      trailing: CustomButton(
        onPressed: () => Navigator.pop(context),
        padding: const EdgeInsets.only(left: 12.0),
        child: const Text(
          'Annuler',
          style: TextStyle(color: CupertinoColors.destructiveRed),
        ),
      ),
    );
  }
}
