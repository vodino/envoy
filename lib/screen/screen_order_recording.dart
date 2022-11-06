import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '_screen.dart';

class OrderRecordingScreen extends StatelessWidget {
  const OrderRecordingScreen({super.key});

  static const String name = 'order_recording';
  static const String path = 'recording';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrderRecordingAppBar(),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        onPressed: () {},
                        child: OrderRecordingTab(
                          label: const Text('Active orders'),
                          icon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(CupertinoIcons.cube_box, size: 30.0),
                              SizedBox(width: 8.0),
                              Text('10', style: TextStyle(fontSize: 30.0)),
                            ],
                          ),
                          active: true,
                        ),
                      ),
                      CustomButton(
                        onPressed: () {},
                        child: OrderRecordingTab(
                          label: const Text('Active orders'),
                          icon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(CupertinoIcons.cube_box, size: 30.0),
                              SizedBox(width: 8.0),
                              Text('10', style: TextStyle(fontSize: 30.0)),
                            ],
                          ),
                          active: false,
                        ),
                      ),
                      CustomButton(
                        onPressed: () {},
                        child: OrderRecordingTab(
                          label: const Text('Active orders'),
                          icon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(CupertinoIcons.cube_box, size: 30.0),
                              SizedBox(width: 8.0),
                              Text('10', style: TextStyle(fontSize: 30.0)),
                            ],
                          ),
                          active: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: BottomAppBar(
                elevation: 0.0,
                color: Colors.transparent,
                child: CustomScrollView(
                  slivers: [
                    MultiSliver(
                      pushPinnedChildren: true,
                      children: [
                        const SliverToBoxAdapter(),
                        SliverPinnedHeader.builder((context, overlap) {
                          return CustomListTile(
                            tileColor: overlap ? context.theme.colorScheme.surface : null,
                            title: const Text(
                              'Commandes en cours',
                              style: TextStyle(color: CupertinoColors.systemGrey),
                            ),
                          );
                        }),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return CustomListTile(
                                leading: CustomCircleAvatar(
                                  radius: 18.0,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                  child: const Icon(Icons.motorcycle),
                                ),
                                trailing: const Icon(CupertinoIcons.forward, color: CupertinoColors.systemGrey),
                                title: const Text('Ma Commande de pizza'),
                                onTap: () {},
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
                        SliverPinnedHeader.builder((context, overlap) {
                          return CustomListTile(
                            tileColor: overlap ? context.theme.colorScheme.surface : null,
                            title: const Text(
                              'Commandes planifiées',
                              style: TextStyle(color: CupertinoColors.systemGrey),
                            ),
                          );
                        }),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return CustomListTile(
                                leading: CustomCircleAvatar(
                                  radius: 18.0,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                  child: const Icon(Icons.motorcycle),
                                ),
                                trailing: const Icon(CupertinoIcons.forward, color: CupertinoColors.systemGrey),
                                title: const Text('Ma Commande de pizza'),
                                onTap: () {
                                  context.pushNamed(OrderDeliveriedScreen.name);
                                },
                              );
                            },
                            childCount: 5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
