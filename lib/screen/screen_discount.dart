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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const DiscountCreateModal();
            },
          );
        },
        child: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return DiscountListTile(
                    title: '50% de réduction',
                    dateTime: DateTime.now(),
                    deliveries: 3,
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
