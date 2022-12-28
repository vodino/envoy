import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '_widget.dart';

class HomeOrderSearchAppBar extends DefaultAppBar {
  const HomeOrderSearchAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return CupertinoNavigationBar(
      border: const Border.fromBorderSide(BorderSide.none),
      middle: Text('${localizations.order}s'.capitalize()),
      transitionBetweenRoutes: false,
    );
  }
}

class HomeOrderSearchTextField extends StatelessWidget {
  const HomeOrderSearchTextField({
    super.key,
    this.controller,
  });
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
        child: CustomSearchTextField(
          placeholder: localizations.nameplacephonenumber,
          controller: controller,
          autofocus: true,
        ),
      ),
    );
  }
}

class HomeOrderSearchShimmer extends StatelessWidget {
  const HomeOrderSearchShimmer({super.key});

  Widget _tile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Container(
          //   width: 20.0,
          //   height: 30.0,
          //   decoration: BoxDecoration(
          //     color: CupertinoColors.white,
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          // ),
          // const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 12.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                const SizedBox(height: 4.0),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 12.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        separatorBuilder: (context, index) {
          return const SizedBox(height: 24.0);
        },
        itemBuilder: (context, index) {
          return _tile();
        },
      ),
    );
  }
}
