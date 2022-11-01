import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  static const String path = 'discount';
  static const String name = 'discount';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DiscountAppBar(),
      floatingActionButton: FloatingActionButton(
        elevation: 0.8,
        onPressed: () {},
        child: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: CustomListTile(
                      height: 80.0,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      tileColor: context.theme.primaryColorDark,
                      textColor: context.theme.colorScheme.onPrimary,
                      iconColor: context.theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      leading: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(CupertinoIcons.tag),
                      ),
                      title: Text(
                        '50% Reductions',
                        style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
                          color: context.theme.colorScheme.onPrimary,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('02 livraisons'),
                            Text('Expire 03 jours'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: 3,
              ),
            ),
          ),
          SliverVisibility(
            visible: false,
            sliver: SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text.rich(
                    const TextSpan(
                      text: "Vous n'avez pas de coupons disponibles. ",
                      children: [
                        TextSpan(text: 'Cliquez le button '),
                        WidgetSpan(child: Icon(CupertinoIcons.add_circled, size: 18.0)),
                        TextSpan(text: ' pour en ajouter.'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: context.mediaQuery.textScaleFactor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
