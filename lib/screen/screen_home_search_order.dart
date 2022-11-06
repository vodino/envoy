import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '_screen.dart';

class HomeSearchOrderScreen extends StatelessWidget {
  const HomeSearchOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeSearchOrderAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          controller: ModalScrollController.of(context),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index.isEven) {
                    index ~/= 2;
                    return CustomListTile(
                      subtitle: const Text('Sanduich avec saucisson, Café sans sucre'),
                      leading: const Icon(CupertinoIcons.cube_box),
                      title: const Text("Dejeuner de Mr Allou"),
                      onTap: () {
                        showCupertinoModalBottomSheet<bool>(
                          bounce: false,
                          context: context,
                          builder: (context) {
                            return const HomeOrderScreen();
                          },
                        );
                      },
                    );
                  }
                  return const Divider(indent: 48.0);
                },
                childCount: max(0, 3 * 2 - 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
