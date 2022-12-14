import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '_screen.dart';

class AuthSignupScreen extends StatefulWidget {
  const AuthSignupScreen({
    super.key,
    required this.phoneNumber,
    required this.token,
  });

  final String phoneNumber;
  final String token;

  static const String phoneNumberKey = 'phone_number';
  static const String tokenKey = 'token';

  static const String name = 'auth_signup';
  static const String path = 'auth_signup';

  @override
  State<AuthSignupScreen> createState() => _AuthSignupScreenState();
}

class _AuthSignupScreenState extends State<AuthSignupScreen> {
  /// Input
  late final TextEditingController _fullNameTextController;
  late final ValueNotifier<String?> _errorController;
  late final FocusNode _fullNameFocusNode;

  void _listenError(BuildContext context, String? data) {
    if (data != null) HapticFeedback.vibrate();
  }

  /// ClientService
  late final ClientService _clientService;

  void _registerClient() {
    _clientService.handle(RegisterClient(
      fullName: _fullNameTextController.text.trim(),
      phoneNumber: widget.phoneNumber,
      token: widget.token,
    ));
  }

  void _listenClientService(BuildContext context, ClientState state) {
    if (state is ClientItemState) {
      Navigator.popUntil(context, (route) {
        return route is! CupertinoPageRoute;
      });
    } else if (state is FailureClientState) {
      _errorController.value = state.message;
    }
  }

  @override
  void initState() {
    super.initState();

    /// Input
    _fullNameFocusNode = FocusNode();
    _errorController = ValueNotifier(null);
    _fullNameTextController = TextEditingController();

    /// ClientService
    _clientService = ClientService.instance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthSignupAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            const SliverToBoxAdapter(child: AuthSignupTitle()),
            const SliverToBoxAdapter(child: SizedBox(height: 12.0)),
            const SliverToBoxAdapter(child: AuthSignupFullNameLabel()),
            SliverToBoxAdapter(
              child: AuthSignupFullNameTextField(
                controller: _fullNameTextController,
                focusNode: _fullNameFocusNode,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableConsumer<String?>(
                    listener: _listenError,
                    valueListenable: _errorController,
                    builder: (context, data, child) {
                      return Visibility(
                        visible: data != null,
                        child: Builder(
                          builder: (context) {
                            return AuthErrorText(data!);
                          },
                        ),
                      );
                    },
                  ),
                  ValueListenableConsumer<ClientState>(
                    listener: _listenClientService,
                    valueListenable: _clientService,
                    builder: (context, state, child) {
                      VoidCallback? onPressed = _registerClient;
                      if (state is PendingClientState) onPressed = null;
                      return AuthSubmitButton(
                        onPressed: onPressed,
                        child: Visibility(
                          visible: onPressed != null,
                          replacement: const CustomLoading(),
                          child: const Icon(CupertinoIcons.arrow_right),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
