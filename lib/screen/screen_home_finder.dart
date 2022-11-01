import 'package:flutter/cupertino.dart';

import '_screen.dart';

class HomeFinderScreen extends StatelessWidget {
  const HomeFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.mediaQuery.padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HomeFinderAppBar(),
          const Expanded(
            child: HomeFinderLoader(child: Icon(CupertinoIcons.car_detailed, size: 28.0)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: HomeFinderCanceller(
              child: Text(
                'Annuler',
                style: context.cupertinoTheme.textTheme.actionTextStyle.copyWith(
                  color: CupertinoColors.destructiveRed,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
