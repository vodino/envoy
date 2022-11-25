import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';

import '_widget.dart';

class HomeFinderAppBar extends DefaultAppBar {
  const HomeFinderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      border: const Border.fromBorderSide(BorderSide.none),
      middle: const Text("En attente de coursiers..."),
      backgroundColor: context.theme.colorScheme.surface,
      automaticallyImplyLeading: false,
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
