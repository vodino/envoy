import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
  });

  final String? hintText;
  final String? labelText;
  final int? minLines;
  final int? maxLines;
  final bool expands;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: ShapeDecoration(
        color: CupertinoColors.systemFill,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: TextFormField(
        expands: expands,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        ),
      ),
    );
  }
}
