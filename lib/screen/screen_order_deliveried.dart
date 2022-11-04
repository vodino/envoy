import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

import '_screen.dart';

class OrderDeliveriedScreen extends StatelessWidget {
  const OrderDeliveriedScreen({super.key});

  static const String path = 'order/deliveried';
  static const String name = 'order/deliveried';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrderDeliveriedAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomListTile(
                height: 70.0,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                title: Text('Delivery Completed', style: context.theme.textTheme.titleLarge),
                trailing: Text(
                  '500 FCFA',
                  style: context.theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('12 Avril 2022'),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: AspectRatio(
                  aspectRatio: 1.7,
                  child: HomeMap(
                    initialCameraPosition: CameraPosition(target: LatLng(0.000, 0.00), zoom: 12.0),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomListTile(
                    leading: Container(
                      width: 40.0,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const Text('De'),
                    ),
                    trailing: Text(
                      '08h00',
                      style: context.theme.textTheme.labelMedium!.copyWith(color: CupertinoColors.systemGrey),
                    ),
                    title: const Text('Quartier Akeikoi'),
                  ),
                  CustomListTile(
                    leading: Container(
                      width: 40.0,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const Text('À'),
                    ),
                    trailing: Text(
                      '10h00',
                      style: context.theme.textTheme.labelMedium!.copyWith(color: CupertinoColors.systemGrey),
                    ),
                    title: const Text('Adjame Liberté'),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CupertinoButton.filled(
                      child: const Text('Repeat Order'),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 6.0),
                    CustomOutlineButton(
                      child: const Text('Save Order'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
