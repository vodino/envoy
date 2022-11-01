import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Material(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: CupertinoColors.systemFill),
                        borderRadius: BorderRadius.circular(8.0),
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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: ShapeDecoration(
                      color: CupertinoColors.systemFill,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Numéro de chargement',
                        hintText: 'Tapez le numéro du client à appeler',
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: ShapeDecoration(
                      color: CupertinoColors.systemFill,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Numéro de livraison',
                        hintText: 'Tapez le numéro du client à appeler',
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: ShapeDecoration(
                        color: CupertinoColors.systemFill,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: const TextField(
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        ),
                      ),
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
