import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '_screen.dart';

class HomeTrackingScreen extends StatelessWidget {
  const HomeTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.mediaQuery.padding.bottom),
      child: Column(
        children: [
          const HomeTrackingAppBar(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: TrackingListTile(
                    title: 'Allou Coulibaly',
                    onTap: () {
                      context.pushNamed(OrderFeedbackScreen.name);
                    },
                  ),
                ),
                const SliverToBoxAdapter(child: Divider(height: 12.0, thickness: 8.0)),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return const CustomListTile(
                        leading: Icon(CupertinoIcons.circle, color: CupertinoColors.systemFill),
                        title: Text('Pickup Order'),
                      );
                    },
                    childCount: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
