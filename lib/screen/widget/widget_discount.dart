import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class DiscountAppBar extends DefaultAppBar {
  const DiscountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      transitionBetweenRoutes: false,
      middle: Text(localizations.discountcoupons.capitalize()),
    );
  }
}

class DiscountListTile extends StatelessWidget {
  const DiscountListTile({
    super.key,
    this.onTap,
    required this.percent,
    required this.dateTime,
    required this.deliveries,
  });

  final int percent;
  final int deliveries;
  final DateTime dateTime;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: CustomListTile(
        height: 80.0,
        tileColor: context.theme.primaryColorDark,
        textColor: context.theme.colorScheme.onPrimary,
        iconColor: context.theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        leading: const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(CupertinoIcons.tag),
        ),
        title: Text(
          localizations.percentdiscount(percent),
          style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${deliveries.toString().padLeft(2, "0")} ${localizations.deliveries}'),
              Text(localizations.expiresdays(dateTime.day)),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

class DiscountCreateModal extends StatelessWidget {
  const DiscountCreateModal({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CustomTextFieldModal(
      title: localizations.enterdiscount.capitalize(),
      hint: localizations.code.capitalize(),
    );
  }
}

class DiscountBottomSheet extends StatelessWidget {
  const DiscountBottomSheet({
    super.key,
    required this.percent,
    required this.dateTime,
    required this.deliveries,
  });

  final int percent;
  final int deliveries;
  final DateTime dateTime;

  Widget _itemWidget({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    final theme = context.theme;
    return Row(
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 100.0, child: Text('$label ')),
        SizedBox(
          width: 100.0,
          child: Text(
            value,
            style: theme.textTheme.headline6!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    final localizations = context.localizations;
    return Container(
      color: context.theme.colorScheme.primary,
      padding: EdgeInsets.only(bottom: context.mediaQuery.padding.bottom),
      child: IconTheme(
        data: IconThemeData(color: theme.colorScheme.onPrimary),
        child: DefaultTextStyle(
          style: const TextStyle(color: CupertinoColors.systemGrey3),
          child: Column(
            textBaseline: TextBaseline.alphabetic,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Icon(CupertinoIcons.check_mark_circled_solid, size: 60.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(
                  localizations.discountsuccessfully.capitalize(),
                  style: const TextStyle(color: CupertinoColors.systemGrey2),
                ),
              ),
              const SizedBox(height: 16.0),
              _itemWidget(
                context: context,
                value: '$percent%',
                label: localizations.discount.capitalize(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: _itemWidget(
                  context: context,
                  label: localizations.expiresin.capitalize(),
                  value: '${MaterialLocalizations.of(context).formatCompactDate(dateTime)} à ${TimeOfDay.fromDateTime(dateTime).format(context)}',
                ),
              ),
              _itemWidget(
                context: context,
                value: '$deliveries',
                label: localizations.deliveries.capitalize(),
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscountEmptyMessage extends StatelessWidget {
  const DiscountEmptyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text.rich(
          TextSpan(
            text: '${localizations.nodiscountcoupons.capitalize()} .',
            children: [
              TextSpan(text: '${localizations.clickbutton} '),
              const WidgetSpan(child: Icon(CupertinoIcons.add_circled, size: 18.0)),
              TextSpan(text: ' ${localizations.toadd}.'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
