import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '_widget.dart';

class CustomBar extends StatelessWidget {
  const CustomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: FractionallySizedBox(
          widthFactor: 0.15,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: const Divider(
              color: CupertinoColors.systemFill,
              thickness: 5.0,
              height: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.maxLines = 1,
    this.minLines,
    this.focusNode,
    this.initalValue,
    this.controller,
    this.enabled,
    this.label,
    this.onTap,
    this.onFieldSubmitted,
    this.keyboardType,
    this.expands = false,
    this.readOnly = false,
    this.alignLabelWithHint,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.margin = const EdgeInsets.symmetric(horizontal: 12.0),
  });

  final String? initalValue;
  final String? hintText;
  final String? labelText;
  final int? minLines;
  final int? maxLines;
  final bool expands;
  final bool? enabled;
  final bool readOnly;
  final bool autofocus;

  final Widget? label;
  final Widget? prefixIcon;
  final bool? alignLabelWithHint;

  final VoidCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextInputType? keyboardType;

  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: ShapeDecoration(
        color: CupertinoColors.systemGrey5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: TextFormField(
        onTap: onTap,
        autofocus: autofocus,
        keyboardType: keyboardType,
        textAlign: textAlign,
        enabled: enabled,
        readOnly: readOnly,
        expands: expands,
        minLines: minLines,
        maxLines: maxLines,
        focusNode: focusNode,
        controller: controller,
        initialValue: initalValue,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          label: label,
          isDense: true,
          isCollapsed: true,
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: kMinInteractiveDimension - 6.0,
            minHeight: kMinInteractiveDimension,
          ),
          alignLabelWithHint: alignLabelWithHint,
          hintStyle: const TextStyle(color: CupertinoColors.tertiaryLabel),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
        ),
      ),
    );
  }
}

class CustomBoxShadow extends StatelessWidget {
  const CustomBoxShadow({
    super.key,
    required this.child,
    this.color,
  });

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(spreadRadius: -14.0, blurRadius: 16.0)],
        border: Border.all(color: CupertinoColors.systemFill),
        borderRadius: BorderRadius.circular(12.0),
        color: color ?? theme.colorScheme.surface,
      ),
      child: Material(
        color: color ?? theme.colorScheme.surface,
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

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingIndicator(
      colors: [CupertinoColors.systemGrey],
      indicatorType: Indicator.ballClipRotateMultiple,
    );
  }
}

class CustomTextFieldModal extends StatefulWidget {
  const CustomTextFieldModal({
    super.key,
    this.value,
    required this.hint,
    required this.title,
  });

  final String hint;
  final String? value;
  final String title;

  @override
  State<CustomTextFieldModal> createState() => _CustomTextFieldModalState();
}

class _CustomTextFieldModalState extends State<CustomTextFieldModal> {
  /// Customer
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _valueTextController;

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ ne peut être vide';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    /// Customer
    _formKey = GlobalKey();
    _valueTextController = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title),
      content: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Form(
          key: _formKey,
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: TextFormField(
              autofocus: true,
              validator: _validator,
              controller: _valueTextController,
              decoration: InputDecoration(
                filled: true,
                hintText: widget.hint,
                fillColor: CupertinoColors.systemFill,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Terminer'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, _valueTextController.text);
            }
          },
        ),
      ],
    );
  }
}

class CustomCheckListTile extends StatelessWidget {
  const CustomCheckListTile({
    super.key,
    this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final Widget? title;
  final Widget? subtitle;

  final bool? value;
  final ValueChanged<bool?>? onChanged;

  void _onTap() {
    if (value != null) {
      onChanged?.call(!(value!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: title,
      onTap: _onTap,
      subtitle: subtitle,
      trailing: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: CupertinoColors.activeGreen,
        visualDensity: const VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity,
        ),
        side: const BorderSide(color: CupertinoColors.systemFill),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }
}

class CustomErrorPage extends StatelessWidget {
  const CustomErrorPage({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.clear_circled, size: 60.0, color: CupertinoColors.destructiveRed),
          const SizedBox(height: 16.0),
          Text(
            "Une erreur s'est produite",
            style: context.cupertinoTheme.textTheme.navTitleTextStyle,
          ),
          const SizedBox(height: 8.0),
          const Text("Cliquer ici pour réessayer"),
        ],
      ),
    );
  }
}