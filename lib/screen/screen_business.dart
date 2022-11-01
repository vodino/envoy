import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  static const String path = 'business';
  static const String name = 'business';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BusinessAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
            const SliverToBoxAdapter(
              child: CustomListTile(
                height: 35.0,
                title: Text('Contact'),
              ),
            ),
            const SliverToBoxAdapter(
              child: CustomTextField(
                hintText: 'Email ou Numéro de téléphone',
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            const SliverToBoxAdapter(
              child: CustomListTile(
                height: 35.0,
                title: Text('Requête'),
              ),
            ),
            const SliverToBoxAdapter(
              child: CustomTextField(
                hintText: 'Selectionner un business',
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            const SliverToBoxAdapter(
              child: CustomListTile(
                height: 35.0,
                title: Text('Message'),
              ),
            ),
            const SliverToBoxAdapter(
              child: CustomTextField(
                hintText: 'Taper ici',
                maxLines: 5,
                minLines: 5,
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
                      child: const Text('Envoyer'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const BusinessModal();
                          },
                        );
                      },
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
