import 'package:flutter/cupertino.dart';

import '_widget.dart';

class BusinessAppBar extends DefaultAppBar {
  const BusinessAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      middle: Text('Business'),
      transitionBetweenRoutes: false,
    );
  }
}

class BusinessModal extends StatelessWidget {
  const BusinessModal({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: context.theme.colorScheme.primary,
              size: 60.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text('Nous avons réçu votre requête et nous allons vous revenir dans un bref délai.'),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
