import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class LocationMapAppBar extends DefaultAppBar {
  const LocationMapAppBar({
    super.key,
    this.onLeadingPressed,
  });

  final ValueChanged<BuildContext>? onLeadingPressed;

  @override
  Size get preferredSize => super.preferredSize * 1.2;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [BoxShadow(spreadRadius: -12.0, blurRadius: 20.0)],
            borderRadius: BorderRadius.circular(8.0),
            color: theme.colorScheme.surface,
          ),
          child: ClipOval(
            child: CustomButton(
              minSize: 40.0,
              padding: EdgeInsets.zero,
              backgroundColor: context.theme.colorScheme.surface,
              onPressed: () => Navigator.pop(context),
              child: Icon(CupertinoIcons.back, color: context.theme.colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}
