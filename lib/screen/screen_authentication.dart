import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const String path = 'auth';
  static const String name = 'auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  /// AuthService
  late final AuthService _authService;

  void _listenAuthService(BuildContext context, AuthState state) {
    if (state is SmsCodeSentState) {
    } else if (state is FailureAuthState) {}
  }

  @override
  void initState() {
    super.initState();

    /// AuthService
    _authService = AuthService.instance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: 4.5,
                child: Center(child: Assets.images.envoyIcon.svg()),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
            SliverToBoxAdapter(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: IntrinsicWidth(
                    child: CustomListTile(
                      title: Text(
                        'Saisissez les informations du compte',
                        style: context.cupertinoTheme.textTheme.navTitleTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: CustomListTile(height: 30.0, title: Text('Nom complet')),
            ),
            const SliverToBoxAdapter(
              child: CustomTextField(
                hintText: 'nom complet',
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SizedBox(
                    width: 100.0,
                    child: Column(
                      children: [
                        const CustomListTile(height: 30.0, title: Text('Indicatif')),
                        CustomTextField(
                          readOnly: true,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('${CustomString.toFlag('ci')} +225'),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: const [
                        CustomListTile(height: 30.0, title: Text('Numéro de téléphone')),
                        CustomTextField(
                          hintText: 'numéro de téléphone',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
            SliverToBoxAdapter(
              child: CheckboxListTile(
                value: true,
                onChanged: (value) {},
                activeColor: CupertinoColors.activeGreen,
                controlAffinity: ListTileControlAffinity.leading,
                subtitle: const Text(
                  "En continuant, vous acceptez les conditions d'utilisation et consentez aux informations personnelles conformes aux Politiques de confidentialité",
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    context.pushNamed(AuthVerificationScreen.name);
                  },
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
