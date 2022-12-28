import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '_widget.dart';

class HomeOrderAppBar extends DefaultAppBar {
  const HomeOrderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      middle: Text(localizations.placeorder.capitalize()),
      transitionBetweenRoutes: false,
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
          tileColor: tileColor ?? CupertinoColors.systemGrey5,
          horizontalTitleGap: 12.0,
          subtitle: subtitle,
          title: title,
        ),
      ),
    );
  }
}

class HomeOrderPlaceListTile extends StatelessWidget {
  const HomeOrderPlaceListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    this.onTap,
  });

  final Widget title;
  final Widget? subtitle;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      trailing: const Icon(CupertinoIcons.map, color: CupertinoColors.systemGrey, size: 20.0),
      leading: Icon(CupertinoIcons.circle, color: iconColor, size: 16.0),
      subtitle: subtitle,
      title: title,
      onTap: onTap,
    );
  }
}

class HomeOrderPriceWidget extends StatelessWidget {
  const HomeOrderPriceWidget({
    super.key,
    required this.onChanged,
    required this.amount,
    required this.image,
    required this.title,
    required this.value,
    this.padding = const EdgeInsets.only(left: 8.0),
  });

  final bool value;
  final String title;
  final String image;
  final String? amount;
  final EdgeInsetsGeometry padding;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: Opacity(
        opacity: value ? 1.0 : 0.4,
        child: CustomButton(
          onPressed: onChanged != null ? () => onChanged?.call(!value) : null,
          child: Material(
            color: value ? CupertinoColors.systemGrey5 : CupertinoColors.systemGrey6.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRect(
                    child: Padding(
                      padding: padding,
                      child: Transform.scale(
                        scale: 1.2,
                        child: Lottie.asset(
                          image,
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                          animate: false,
                        ),
                      ),
                    ),
                  ),
                ),
                CustomListTile(
                  height: 40.0,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  title: Text(title, style: const TextStyle(fontSize: 8.0)),
                  subtitle: Visibility(
                    visible: amount != null,
                    replacement: const HomeOrderSchimmer(),
                    child: Builder(builder: (context) {
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          amount!,
                          style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
                            letterSpacing: -2.0,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
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
    final localizations = context.localizations;
    return Column(
      children: [
        CupertinoNavigationBar(
          border: const Border.fromBorderSide(BorderSide.none),
          leading: CustomButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              localizations.cancel.capitalize(),
              style: const TextStyle(color: CupertinoColors.destructiveRed),
            ),
          ),
          middle: Text(localizations.selectdate.capitalize()),
          trailing: CustomButton(
            onPressed: () {
              if (_dateTime != null) {
                Navigator.pop(context, _dateTime);
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              localizations.finished.capitalize(),
              style: const TextStyle(color: CupertinoColors.activeBlue),
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

class HomeOrderSchimmer extends StatelessWidget {
  const HomeOrderSchimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade300,
      child: Container(
        height: 12.0,
        width: 60.0,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: CupertinoColors.systemFill,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
}

class HomeOrderErrorModal extends StatelessWidget {
  const HomeOrderErrorModal({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoAlertDialog(
      content: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Icon(
              CupertinoIcons.lock_shield,
              color: CupertinoColors.systemGrey,
              size: 60.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(text),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(localizations.ok.capitalize()),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
