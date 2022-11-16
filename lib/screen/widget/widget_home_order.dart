import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '_widget.dart';

class HomeOrderAppBar extends DefaultAppBar {
  const HomeOrderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      middle: Text('Effectuer une commande'),
    );
  }
}

class HomeOrderContactListTile extends StatelessWidget {
  const HomeOrderContactListTile({
    super.key,
    this.subtitle,
    this.title,
    this.tileColor,
    this.onTap,
  });

  final Widget? title;
  final Widget? subtitle;
  final Color? tileColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: CustomButton(
        onPressed: onTap,
        child: CustomListTile(
          leading: const Icon(CupertinoIcons.phone_fill, size: 18.0, color: CupertinoColors.systemGrey2),
          trailing: const Icon(CupertinoIcons.forward, size: 18.0, color: CupertinoColors.systemGrey2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          tileColor: tileColor ?? CupertinoColors.systemFill,
          horizontalTitleGap: 12.0,
          subtitle: subtitle,
          title: title,
        ),
      ),
    );
  }
}

class HomeOrderAmountModal extends StatefulWidget {
  const HomeOrderAmountModal({super.key, this.amount});

  final String? amount;

  @override
  State<HomeOrderAmountModal> createState() => _HomeOrderAmountModalState();
}

class _HomeOrderAmountModalState extends State<HomeOrderAmountModal> {
  /// Customer
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _amountTextController;

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
    _amountTextController = TextEditingController(text: widget.amount);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Entrer le montant à payer'),
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
              controller: _amountTextController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Montant',
                fillColor: CupertinoColors.systemFill,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                border: OutlineInputBorder(
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
              Navigator.pop(context, _amountTextController.text);
            }
          },
        ),
      ],
    );
  }
}

class HomeOrderPlaceListTile extends StatelessWidget {
  const HomeOrderPlaceListTile({
    super.key,
    required this.title,
    required this.iconColor,
    this.onTap,
  });

  final Widget title;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      trailing: const Icon(CupertinoIcons.map, color: CupertinoColors.systemGrey, size: 20.0),
      leading: Icon(CupertinoIcons.circle, color: iconColor, size: 16.0),
      title: title,
      onTap: onTap,
    );
  }
}

class HomeOrderPriceWidget extends StatelessWidget {
  const HomeOrderPriceWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String amount;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: CustomButton(
        onPressed: () => onChanged?.call(!value),
        child: Material(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: value ? CupertinoColors.systemRed : CupertinoColors.systemFill, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRect(
                  child: Transform.scale(
                    scale: 1.2,
                    child: Lottie.asset(
                      Assets.images.motorbike,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                      animate: false,
                    ),
                  ),
                ),
              ),
              CustomListTile(
                height: 40.0,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                title: Text(title, style: const TextStyle(fontSize: 8.0)),
                subtitle: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    amount,
                    style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
                      letterSpacing: -2.0,
                    ),
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

class HomeOrderSwitchListTile extends StatelessWidget {
  const HomeOrderSwitchListTile({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTrailingPressed,
    required this.value,
    required this.onChanged,
  });

  final Widget? title;
  final Widget? subtitle;
  final String? trailing;
  final VoidCallback? onTrailingPressed;

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: title,
      subtitle: subtitle,
      trailing: Visibility(
        visible: value,
        child: OutlinedButton(
          onPressed: onTrailingPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            visualDensity: VisualDensity.compact,
          ),
          child: Builder(
            builder: (context) {
              return Text(
                trailing!,
                style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
                  color: CupertinoColors.activeBlue,
                  letterSpacing: -2.0,
                ),
              );
            },
          ),
        ),
      ),
      leading: CupertinoSwitch(value: value, onChanged: onChanged),
    );
  }
}

class HomeOrderDateTimeBottomSheet extends StatefulWidget {
  const HomeOrderDateTimeBottomSheet({super.key, this.dateTime});

  final DateTime? dateTime;

  @override
  State<HomeOrderDateTimeBottomSheet> createState() => _HomeOrderDateTimeBottomSheetState();
}

class _HomeOrderDateTimeBottomSheetState extends State<HomeOrderDateTimeBottomSheet> {
  DateTime? _dateTime;
  late final DateTime _minimumDate;

  @override
  void initState() {
    super.initState();
    _minimumDate = DateUtils.dateOnly(DateTime.now());
    _dateTime = widget.dateTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoNavigationBar(
          border: const Border.fromBorderSide(BorderSide.none),
          leading: CustomButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Annuler',
              style: TextStyle(color: CupertinoColors.destructiveRed),
            ),
          ),
          middle: const Text('Selectionner une date'),
          trailing: CustomButton(
            onPressed: () {
              if (_dateTime != null) {
                Navigator.pop(context, _dateTime);
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Terminer',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
          ),
        ),
        Expanded(
          child: CupertinoDatePicker(
            onDateTimeChanged: (value) => _dateTime = value,
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: _dateTime,
            minimumDate: _minimumDate,
            use24hFormat: true,
          ),
        ),
      ],
    );
  }
}
