import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '_screen.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  void _checkBeforeGoToPage(BuildContext context, String pageName, {bool close = false}) async {
    if (ClientService.authenticated != null) {
      context.pushNamed(pageName);
    } else if (!close) {
      await Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) {
          return const AuthScreen();
        }),
      );
      if (mounted) _checkBeforeGoToPage(context, pageName, close: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
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
                title: Text(localizations.profile.capitalize()),
                onTap: () => _checkBeforeGoToPage(context, AccountScreen.name),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.cube_box),
                title: Text('${localizations.order.capitalize()}s'),
                onTap: () => _checkBeforeGoToPage(context, OrderRecordingScreen.name),
              ),
            ),
            const SliverToBoxAdapter(child: Divider()),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.tag),
                title: Text('${localizations.discount.capitalize()}s'),
                onTap: () => _checkBeforeGoToPage(context, DiscountScreen.name),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.bag),
                title: Text(localizations.business.capitalize()),
                onTap: () => _checkBeforeGoToPage(context, BusinessScreen.name),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.info_circle),
                title: Text(localizations.faq.capitalize()),
                onTap: () => _checkBeforeGoToPage(context, HelpFaqScreen.name),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.heart),
                title: Text(localizations.support.capitalize()),
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
                    onTap: () => _checkBeforeGoToPage(context, SettingsScreen.name),
                    title: Text(localizations.settings.capitalize()),
                    leading: const Icon(CupertinoIcons.gear),
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
