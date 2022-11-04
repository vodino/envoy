import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class AuthVerificationScreen extends StatelessWidget {
  const AuthVerificationScreen({super.key});

  static const String name = 'auth_verification';
  static const String path = 'verification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthVerificationAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverToBoxAdapter(
              child: Center(
                child: IntrinsicWidth(
                  child: CustomListTile(
                    title: Text(
                      'Entrez le code réçu par le numéro de téléphone +225 0749414602.',
                      style: context.cupertinoTheme.textTheme.navTitleTextStyle,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
            const SliverToBoxAdapter(
              child: AuthVerificationFields(),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
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
    );
  }
}
