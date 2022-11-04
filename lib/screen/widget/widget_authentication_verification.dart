import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '_widget.dart';

class AuthVerificationAppBar extends DefaultAppBar {
  const AuthVerificationAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      middle: Text('Verification'),
      border: Border.fromBorderSide(BorderSide.none),
    );
  }
}

class AuthVerificationFields extends StatelessWidget {
  const AuthVerificationFields({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AuthVerificationTextField(),
          SizedBox(width: 8.0),
          AuthVerificationTextField(),
          SizedBox(width: 8.0),
          AuthVerificationTextField(),
          SizedBox(width: 8.0),
          AuthVerificationTextField(),
        ],
      ),
    );
  }
}

class AuthVerificationTextField extends StatelessWidget {
  const AuthVerificationTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      stepWidth: 80.0,
      child: CustomBoxShadow(
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(1),
          ],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: context.theme.textTheme.headline5,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }
}
