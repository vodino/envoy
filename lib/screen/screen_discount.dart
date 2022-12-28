import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  static const String path = 'discount';
  static const String name = 'discount';

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
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
                    dateTime: DateTime.now(),
                    deliveries: 3,
                    percent: 50,
                  );
                },
                childCount: 3,
              ),
            ),
          ),
          const SliverVisibility(
            visible: false,
            sliver: SliverFillRemaining(child: DiscountEmptyMessage()),
          ),
        ],
      ),
    );
  }
}
