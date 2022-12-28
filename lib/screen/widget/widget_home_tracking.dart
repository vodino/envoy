import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class HomeTrackingAppBar extends DefaultAppBar {
  const HomeTrackingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      middle: Text("${localizations.trackingorder.capitalize()}..."),
      border: const Border.fromBorderSide(BorderSide.none),
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
    this.onLeadingTap,
    required this.title,
    this.foregroundImage,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onLeadingTap;
  final ImageProvider<Object>? foregroundImage;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomListTile(
        height: 60.0,
        tileColor: context.theme.primaryColorDark,
        textColor: context.theme.colorScheme.onPrimary,
        iconColor: context.theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        leading: CustomButton(
          onPressed: onLeadingTap,
          child: CustomCircleAvatar(
            foregroundImage: foregroundImage,
            foregroundColor: theme.colorScheme.onPrimary,
            backgroundColor: CupertinoColors.systemGrey,
            child: const Icon(CupertinoIcons.person_crop_circle, size: 33.0),
          ),
        ),
        title: Text(
          title,
          style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: const RotatedBox(
          quarterTurns: -45,
          child: Icon(CupertinoIcons.phone_fill),
        ),
        onTap: onTap,
      ),
    );
  }
}
