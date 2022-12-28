import 'package:flutter/cupertino.dart';

import '_widget.dart';

class AuthSignupAppBar extends DefaultAppBar {
  const AuthSignupAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      middle: Text(localizations.accountinfo.capitalize()),
      border: const Border.fromBorderSide(BorderSide.none),
      transitionBetweenRoutes: false,
    );
  }
}

class AuthSignupTitle extends StatelessWidget {
  const AuthSignupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CustomListTile(
      title: Center(
        child: Text(
          localizations.enteraccountinfo.capitalize(),
          style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
            color: CupertinoColors.systemGrey,
            fontWeight: FontWeight.w400,
          ),
          textScaleFactor: context.mediaQuery.textScaleFactor,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          softWrap: true,
        ),
      ),
    );
  }
}

class AuthSignupFullNameLabel extends StatelessWidget {
  const AuthSignupFullNameLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CustomListTile(height: 30.0, title: Text(localizations.fullname.capitalize()));
  }
}

class AuthSignupFullNameTextField extends StatelessWidget {
  const AuthSignupFullNameTextField({
    super.key,
    this.controller,
    this.focusNode,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CustomTextField(
      hintText: localizations.fullname.capitalize(),
      controller: controller,
      focusNode: focusNode,
      autofocus: true,
    );
  }
}
