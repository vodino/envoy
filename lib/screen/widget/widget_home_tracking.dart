import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      transitionBetweenRoutes: false,
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
    final ThemeData theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomListTile(
        tileColor: context.theme.primaryColorDark,
        textColor: context.theme.colorScheme.onPrimary,
        iconColor: context.theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        leading: CustomCircleAvatar(
          foregroundColor: theme.colorScheme.onPrimary,
          backgroundColor: CupertinoColors.systemGrey,
          child: const Icon(CupertinoIcons.person_crop_circle, size: 22.0),
        ),
        title: Text(
          title,
          style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
        trailing: const RotatedBox(
          quarterTurns: -45,
          child: Icon(CupertinoIcons.phone_fill),
        ),
        onTap: onTap,
      ),
    );
  }
}
