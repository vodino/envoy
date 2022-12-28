import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';

import '_widget.dart';

class HomeFinderAppBar extends DefaultAppBar {
  const HomeFinderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      middle: Text("${localizations.waitingcouriers.capitalize()}..."),
      border: const Border.fromBorderSide(BorderSide.none),
      backgroundColor: context.theme.colorScheme.surface,
      automaticallyImplyLeading: false,
      transitionBetweenRoutes: false,
    );
  }
}

class HomeFinderLoader extends StatelessWidget {
  const HomeFinderLoader({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: LoadingIndicator(
                colors: [CupertinoColors.systemFill],
                indicatorType: Indicator.ballRotateChase,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(52.0),
            child: Center(
              child: Lottie.asset(
                Assets.images.motorbike,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                animate: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeFinderError extends StatelessWidget {
  const HomeFinderError({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.clear_circled,
            color: CupertinoColors.destructiveRed,
            size: 70.0,
          ),
          const SizedBox(height: 8.0),
          Text(localizations.nocouriers.capitalize())
        ],
      ),
    );
  }
}
