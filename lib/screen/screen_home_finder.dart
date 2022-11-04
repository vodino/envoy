import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '_screen.dart';

class HomeFinderScreen extends StatelessWidget {
  const HomeFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1.0,
      minChildSize: 1.0,
      initialChildSize: 1.0,
      builder: (context, scrollController) {
        return SafeArea(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const HomeFinderAppBar(),
                    Expanded(
                      child: HomeFinderLoader(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      child: CustomOutlineButton(
                        child: const Text('Annuler'),
                        onPressed: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const HomeDeliveryScreen();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
