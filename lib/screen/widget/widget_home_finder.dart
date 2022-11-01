import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class HomeFinderAppBar extends DefaultAppBar {
  const HomeFinderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      border: const Border.fromBorderSide(BorderSide.none),
      middle: const Text("Recherche de coursiers..."),
      backgroundColor: context.theme.colorScheme.surface,
      automaticallyImplyLeading: false,
    );
  }
}

class HomeFinderLoader extends StatelessWidget {
  const HomeFinderLoader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(60.0),
                child: const CircularProgressIndicator(strokeWidth: 2.0),
              ),
            ),
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}

class HomeFinderCanceller extends StatelessWidget {
  const HomeFinderCanceller({
    super.key,
    this.onPressed,
    required this.child,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        side: const BorderSide(color: CupertinoColors.systemGrey, width: 0.8),
      ),
      child: DefaultTextStyle(
        style: context.cupertinoTheme.textTheme.actionTextStyle,
        child: child,
      ),
    );
  }
}
