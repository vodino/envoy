import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class DiscountAppBar extends DefaultAppBar {
  const DiscountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      transitionBetweenRoutes: false,
      middle: Text('Coupons de réduction'),
    );
  }
}

class DiscountListTile extends StatelessWidget {
  const DiscountListTile({
    super.key,
    this.onTap,
    required this.title,
    required this.dateTime,
    required this.deliveries,
  });

  final String title;
  final int deliveries;
  final DateTime dateTime;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
          title,
          style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${deliveries.toString().padLeft(2, "0")} livraison(s)'),
              Text('Expire ${dateTime.day} jour(s)'),
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
    return CupertinoAlertDialog(
      title: const Text('Entrer un code de réduction'),
      content: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Material(
          color: CupertinoColors.systemFill,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: const TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Code',
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
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
            Navigator.pop(context);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return const DiscountBottomSheet();
              },
            );
          },
        ),
      ],
    );
  }
}

class DiscountBottomSheet extends StatelessWidget {
  const DiscountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(
                  'Code de réduction appliqué avec succès',
                  style: TextStyle(color: CupertinoColors.systemGrey2),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 100.0, child: Text('Reduction: ')),
                  SizedBox(
                    width: 100.0,
                    child: Text(
                      '50%',
                      style: theme.textTheme.headline6!.copyWith(
                        color: context.theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const SizedBox(width: 100.0, child: Text('Expire le: ')),
                    SizedBox(
                      width: 100.0,
                      child: Text(
                        '01/30/22',
                        style: theme.textTheme.headline6!.copyWith(
                          color: context.theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
