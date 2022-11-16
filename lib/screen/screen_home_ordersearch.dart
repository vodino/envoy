import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '_screen.dart';

class HomeOrderSearchScreen extends StatefulWidget {
  const HomeOrderSearchScreen({super.key});

  @override
  State<HomeOrderSearchScreen> createState() => _HomeOrderSearchScreenState();
}

class _HomeOrderSearchScreenState extends State<HomeOrderSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeOrderSearchAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          controller: ModalScrollController.of(context),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverPinnedHeader(
              child: HomeOrderSearchTextField(),
            ),
            const SliverPinnedHeader(child: Divider()),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index.isEven) {
                    index ~/= 2;
                    return CustomListTile(
                      leading: const Icon(CupertinoIcons.cube_box_fill, color: CupertinoColors.systemGrey2),
                      subtitle: const Text('Sanduich avec saucisson, Café sans sucre'),
                      title: const Text("Dejeuner de Mr Allou"),
                      onTap: () {},
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
