import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class OrderRecordingAppBar extends DefaultAppBar {
  const OrderRecordingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      middle: Text('Mes commandes'),
    );
  }
}

class OrderRecordingTab extends StatelessWidget {
  const OrderRecordingTab({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
  });

  final Widget label;
  final Widget icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = active ? context.theme.colorScheme.primary : CupertinoColors.systemFill;
    Color foregroundColor = context.theme.colorScheme.onSurface;
    if (active) foregroundColor = context.theme.colorScheme.surface;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Card(
        elevation: 0.0,
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: IconTheme(
            data: IconThemeData(color: foregroundColor),
            child: DefaultTextStyle(
              style: TextStyle(color: foregroundColor),
              child: Tab(icon: label, child: icon),
            ),
          ),
        ),
      ),
    );
  }
}
