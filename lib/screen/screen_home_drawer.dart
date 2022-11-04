import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 45.0,
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(CupertinoIcons.back),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.person),
                title: const Text('Profil'),
                onTap: () => context.pushNamed(AccountScreen.name),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.cube_box),
                title: const Text('Commandes'),
                onTap: () => context.pushNamed(OrderRecordingScreen.name),
              ),
            ),
            const SliverToBoxAdapter(child: Divider()),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.tag),
                title: const Text('Réductions'),
                onTap: () => context.pushNamed(DiscountScreen.name),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.bag),
                title: const Text('Business'),
                onTap: () => context.pushNamed(BusinessScreen.name),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.info_circle),
                title: const Text('Aide/Faq'),
                onTap: () => context.pushNamed(HelpFaqScreen.name),
              ),
            ),
            const SliverToBoxAdapter(
              child: CustomListTile(
                leading: Icon(CupertinoIcons.info_circle),
                title: Text('Support'),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(),
                  CustomListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    onTap: () => context.pushNamed(SettingsScreen.name),
                    leading: const Icon(CupertinoIcons.gear),
                    title: const Text('Paramètres'),
                    height: 55.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
