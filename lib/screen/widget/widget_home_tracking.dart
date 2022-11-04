import 'package:flutter/cupertino.dart';

import '_widget.dart';

class HomeTrackingAppBar extends DefaultAppBar {
  const HomeTrackingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      border: const Border.fromBorderSide(BorderSide.none),
      middle: const Text("Suivi de Commande Pizza..."),
      backgroundColor: context.theme.colorScheme.surface,
      automaticallyImplyLeading: false,
    );
  }
}

class TrackingListTile extends StatelessWidget {
  const TrackingListTile({
    super.key,
    this.onTap,
    required this.title,
  });

  final String title;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: CustomListTile(
        height: 60.0,
        tileColor: context.theme.primaryColorDark,
        textColor: context.theme.colorScheme.onPrimary,
        iconColor: context.theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        leading: const CustomCircleAvatar(backgroundColor: CupertinoColors.systemGrey),
        title: Text(
          title,
          style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
        trailing: const RotatedBox(
          quarterTurns: -45,
          child: Icon(CupertinoIcons.phone),
        ),
        onTap: onTap,
      ),
    );
  }
}
