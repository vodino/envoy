import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String path = 'settings';
  static const String name = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(),
      body: BottomAppBar(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomListTile(
                height: 60.0,
                title: const Text('Notifications'),
                trailing: CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                ),
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                height: 60.0,
                title: const Text("Reception d'appels"),
                trailing: CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                ),
                onTap: () {},
              ),
            ),
            const SliverToBoxAdapter(child: Divider(indent: 16.0, endIndent: 16.0)),
            SliverToBoxAdapter(
              child: CustomListTile(
                height: 65.0,
                title: const Text('Langages'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Français',
                      style: TextStyle(color: CupertinoColors.systemGrey),
                    ),
                    Icon(CupertinoIcons.forward, color: CupertinoColors.systemFill),
                  ],
                ),
                onTap: () {},
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(indent: 16.0, endIndent: 16.0),
                  CupertinoButton(
                    child: const Text(
                      'Deconnexion',
                      style: TextStyle(color: CupertinoColors.destructiveRed),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
