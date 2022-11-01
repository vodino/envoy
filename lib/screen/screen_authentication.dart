import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const String path = 'auth';
  static const String name = 'auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: Center(
          child: CustomScrollView(
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
              const SliverToBoxAdapter(
                child: CustomListTile(
                  height: 35.0,
                  title: Text('Nom complet'),
                ),
              ),
              const SliverToBoxAdapter(
                child: CustomTextField(),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24.0)),
              const SliverToBoxAdapter(
                child: CustomListTile(
                  height: 35.0,
                  title: Text('Numéro de téléphone'),
                ),
              ),
              const SliverToBoxAdapter(
                child: CustomTextField(),
              ),
              const SliverToBoxAdapter(child: AspectRatio(aspectRatio: 1.8)),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: context.theme.primaryColorDark,
                    child: const Icon(CupertinoIcons.arrow_right),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
