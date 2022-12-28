import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class BusinessAppBar extends DefaultAppBar {
  const BusinessAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      middle: Text(localizations.business.capitalize()),
      transitionBetweenRoutes: false,
    );
  }
}

class BusinessModal extends StatelessWidget {
  const BusinessModal({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoAlertDialog(
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: context.theme.colorScheme.primary,
              size: 60.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(localizations.receivedrequest),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(localizations.ok),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class BusinessPhoneTextField extends StatelessWidget {
  const BusinessPhoneTextField({
    super.key,
    required this.onControllerCreated,
    required this.optionsBuilder,
  });

  final AutocompleteOptionsBuilder<String> optionsBuilder;
  final ValueChanged<TextEditingController> onControllerCreated;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return ClipRect(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Autocomplete<String>(
          optionsBuilder: optionsBuilder,
          fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
            onControllerCreated(textEditingController);
            return CustomTextField(
              focusNode: focusNode,
              margin: EdgeInsets.zero,
              controller: textEditingController,
              onFieldSubmitted: (_) => onFieldSubmitted(),
              hintText: localizations.emailorphonenumber.capitalize(),
            );
          },
        ),
      ),
    );
  }
}

class BusinessContactLabel extends StatelessWidget {
  const BusinessContactLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CustomListTile(height: 30.0, title: Text(localizations.contact.capitalize()));
  }
}

class BusinessRequestLabel extends StatelessWidget {
  const BusinessRequestLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CustomListTile(height: 30.0, title: Text(localizations.request.capitalize()));
  }
}

class BusinessMessageLabel extends StatelessWidget {
  const BusinessMessageLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CustomListTile(height: 30.0, title: Text(localizations.message.capitalize()));
  }
}

class BusinessRequestDropdownFormField<T> extends StatelessWidget {
  const BusinessRequestDropdownFormField({
    super.key,
    this.value,
    this.onChanged,
    required this.items,
  });

  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<DropdownMenuItem<T>>? items;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      isDense: true,
      isExpanded: true,
      onChanged: onChanged,
      hint: Text(localizations.selectbusiness.capitalize()),
      decoration: InputDecoration(
        filled: true,
        isCollapsed: true,
        fillColor: CupertinoColors.systemGrey5,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
      ),
    );
  }
}

class BusinessMessageTextField extends StatelessWidget {
  const BusinessMessageTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CustomTextField(
      controller: controller,
      hintText: '${localizations.tap.capitalize()}...',
      maxLines: 5,
      minLines: 5,
    );
  }
}
