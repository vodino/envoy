import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.maxLines = 1,
    this.minLines,
    this.focusNode,
    this.initalValue,
    this.controller,
    this.enabled,
    this.label,
    this.expands = false,
    this.readOnly = false,
    this.alignLabelWithHint,
    this.textAlign = TextAlign.start,
  });

  final String? initalValue;
  final String? hintText;
  final String? labelText;
  final int? minLines;
  final int? maxLines;
  final bool expands;
  final bool? enabled;
  final bool readOnly;

  final Widget? label;
  final bool? alignLabelWithHint;


  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: ShapeDecoration(
        color: CupertinoColors.systemFill,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: TextFormField(
        textAlign: textAlign,
        enabled: enabled,
        readOnly: readOnly,
        expands: expands,
        minLines: minLines,
        maxLines: maxLines,
        focusNode: focusNode,
        controller: controller,
        initialValue: initalValue,
        decoration: InputDecoration(
          label: label,
          hintText: hintText,
          labelText: labelText,
          alignLabelWithHint: alignLabelWithHint,
          hintStyle: const TextStyle(color: CupertinoColors.tertiaryLabel),
          contentPadding: const EdgeInsets.all(12.0),
        ),
      ),
    );
  }
}

class CustomBoxShadow extends StatelessWidget {
  const CustomBoxShadow({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    return Material(
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(spreadRadius: -14.0, blurRadius: 16.0)],
          borderRadius: BorderRadius.circular(12.0),
          color: theme.colorScheme.surface,
        ),
        child: child,
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    this.onPressed,
    required this.child,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        side: const BorderSide(color: CupertinoColors.systemGrey, width: 0.8),
      ),
      child: DefaultTextStyle(
        style: context.cupertinoTheme.textTheme.actionTextStyle,
        child: child,
      ),
    );
  }
}
