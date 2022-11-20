import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '_screen.dart';

class OrderFeedbackScreen extends StatelessWidget {
  const OrderFeedbackScreen({super.key});

  static const String name = 'order_feedback';
  static const String path = 'feedback';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrderFeedbackAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              sliver: SliverToBoxAdapter(
                child: AspectRatio(
                  aspectRatio: 4.0,
                  child: CircleAvatar(backgroundColor: CupertinoColors.systemGrey),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                height: 60.0,
                title: Center(
                  child: Text(
                    'Allou Coulibaly',
                    style: context.cupertinoTheme.textTheme.navTitleTextStyle,
                  ),
                ),
                subtitle: Center(
                  child: Text(
                    "S'il te plait evaluez mon service",
                    style: context.cupertinoTheme.textTheme.textStyle,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: RatingBar.builder(
                  itemCount: 5,
                  minRating: 1,
                  initialRating: 3,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  onRatingUpdate: (rating) {},
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: CustomListTile(height: 35.0, title: Text('Message'))),
            const SliverToBoxAdapter(
              child: CustomTextField(
                hintText: 'Ecrire...',
                maxLines: 6,
                minLines: 6,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoButton.filled(
                      child: const Text('Soumettre'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
