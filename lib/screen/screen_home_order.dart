import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '_screen.dart';

class HomeOrderScreen extends StatelessWidget {
  const HomeOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeOrderAppBar(),
      body: BottomAppBar(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: ModalScrollController.of(context),
          slivers: [
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.circle, color: CupertinoColors.activeBlue, size: 16.0),
                trailing: const Icon(CupertinoIcons.map, color: CupertinoColors.systemGrey, size: 20.0),
                title: const Text("Quartier Akeikoi"),
                onTap: () {},
              ),
            ),
            const SliverToBoxAdapter(child: Divider(indent: 40.0)),
            SliverToBoxAdapter(
              child: CustomListTile(
                leading: const Icon(CupertinoIcons.circle, color: CupertinoColors.activeOrange, size: 16.0),
                trailing: const Icon(CupertinoIcons.map, color: CupertinoColors.systemGrey, size: 20.0),
                title: const Text("Quartier Akeikoi"),
                onTap: () {},
              ),
            ),
            const SliverToBoxAdapter(child: Divider(thickness: 6.0, height: 6.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100.0,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Material(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: CupertinoColors.activeOrange, width: 2.0),
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
                                  animate: true,
                                ),
                              ),
                            ),
                          ),
                          CustomListTile(
                            height: 40.0,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                            title: const Text('À Moto', style: TextStyle(fontSize: 8.0)),
                            subtitle: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '5000 F',
                                style: context.cupertinoTheme.textTheme.navTitleTextStyle.copyWith(
                                  letterSpacing: -2.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomTextField(
                    hintText: 'Numéro de chargement',
                    readOnly: true,
                  ),
                  const SizedBox(height: 12.0),
                  const CustomTextField(
                    hintText: 'Numéro de livraison',
                    readOnly: true,
                  ),
                  const SizedBox(height: 12.0),
                  const Expanded(
                    child:  CustomTextField(
                      hintText: 'Description',
                      maxLines: null,
                      minLines: null,
                      expands: true,
                    ),
                  ),
                  CustomListTile(
                    leading: CupertinoSwitch(value: true, onChanged: (value) {}),
                    title: const Text('Commande immediate'),
                  ),
                  CustomListTile(
                    leading: CupertinoSwitch(value: true, onChanged: (value) {}),
                    title: const Text('Paiement à la livraison'),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: CupertinoButton.filled(
                      child: const Text('Terminer'),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
