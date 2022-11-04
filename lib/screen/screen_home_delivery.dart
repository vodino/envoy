import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class HomeDeliveryScreen extends StatelessWidget {
  const HomeDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.mediaQuery.padding.bottom),
      child: Column(
        children: [
          const HomeDeliveryAppBar(),
          Expanded(
            child: ListView.separated(
              itemCount: 2,
              separatorBuilder: (context, index) {
                return const Divider(indent: 16.0, endIndent: 20.0);
              },
              itemBuilder: (context, index) {
                return CustomListTile(
                  height: 60.0,
                  leading: CustomCircleAvatar(
                    radius: 18.0,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Icon(Icons.motorcycle),
                  ),
                  trailing: const Icon(CupertinoIcons.forward, color: CupertinoColors.systemGrey),
                  title: const Text('Ma pizza'),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const HomeTrackingScreen();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
