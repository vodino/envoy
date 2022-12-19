import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class ContactsAppBar extends DefaultAppBar {
  const ContactsAppBar({
    super.key,
    required this.title,
  });

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      border: const Border.fromBorderSide(BorderSide.none),
      transitionBetweenRoutes: false,
      middle: title,
    );
  }
}

class ContactsSearchTextField extends StatelessWidget {
  const ContactsSearchTextField({
    super.key,
    this.controller,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
        child: CustomSearchTextField(
          placeholder: 'nom ou numéro de téléphone',
          controller: controller,
        ),
      ),
    );
  }
}

