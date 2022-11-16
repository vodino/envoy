import 'package:flutter/cupertino.dart';

import '_widget.dart';

class HomeOrderSearchAppBar extends DefaultAppBar {
  const HomeOrderSearchAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      border: Border.fromBorderSide(BorderSide.none),
      transitionBetweenRoutes: false,
      middle: Text('Mes commandes'),
    );
  }
}

class HomeOrderSearchTextField extends StatelessWidget {
  const HomeOrderSearchTextField({
    super.key,
    this.controller,
  });
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
      child: CustomSearchTextField(
        placeholder: 'nom ou numéro du client',
        controller: controller,
        autofocus: true,
      ),
    );
  }
}
