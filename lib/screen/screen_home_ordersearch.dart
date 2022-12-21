import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '_screen.dart';

class HomeOrderSearchScreen extends StatefulWidget {
  const HomeOrderSearchScreen({super.key});

  @override
  State<HomeOrderSearchScreen> createState() => _HomeOrderSearchScreenState();
}

class _HomeOrderSearchScreenState extends State<HomeOrderSearchScreen> {
  /// Customer
  late final TextEditingController _searchTextController;

  void _listenSearchTextValue(BuildContext context, TextEditingValue value) {
    _getOrderList(true);
  }

  void _openHomeOrder(Order data) {
    Navigator.push<Order>(
      context,
      CupertinoPageRoute(builder: (context) {
        return HomeOrderCreateScreen(
          order: data,
        );
      }),
    );
  }

  /// OrderService
  late final OrderService _orderService;

  Future<void> _getOrderList([bool pending = false]) {
    if (pending) _orderService.value = const PendingOrderState();
    final search = _searchTextController.text;
    return _orderService.handle(GetOrderList(
      search: search.isNotEmpty ? search : null,
    ));
  }

  void _listenOrderState(BuildContext context, OrderState state) {}

  @override
  void initState() {
    super.initState();

    /// Customer
    _searchTextController = TextEditingController();

    /// OrderService
    _orderService = OrderService();
    if (_orderService.value is! OrderItemListState) WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getOrderList(true));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableListener<TextEditingValue>(
      listener: _listenSearchTextValue,
      valueListenable: _searchTextController,
      child: Scaffold(
        appBar: const HomeOrderSearchAppBar(),
        body: BottomAppBar(
          elevation: 0.0,
          color: Colors.transparent,
          child: CustomScrollView(
            controller: ModalScrollController.of(context),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPinnedHeader(child: HomeOrderSearchTextField(controller: _searchTextController)),
              const SliverPinnedHeader(child: Divider()),
              ValueListenableConsumer<OrderState>(
                listener: _listenOrderState,
                valueListenable: _orderService,
                builder: (context, state, child) {
                  if (state is PendingOrderState) {
                    return const SliverFillRemaining(child: HomeOrderSearchShimmer());
                  } else if (state is OrderItemListState) {
                    final items = state.data;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index.isEven) {
                            index ~/= 2;
                            final item = items[index];
                            return CustomListTile(
                              leading: const Icon(CupertinoIcons.cube_box_fill, color: CupertinoColors.systemGrey2),
                              subtitle: Text('De ${item.pickupPlace?.title} à ${item.deliveryPlace?.title}'),
                              title: Text(item.name ?? 'Commande'),
                              onTap: () => _openHomeOrder(item),
                              trailing: Text(
                                '${item.price} F',
                                style: context.cupertinoTheme.textTheme.navTitleTextStyle,
                              ),
                            );
                          }
                          return const Divider(indent: 48.0);
                        },
                        childCount: max(0, items.length * 2 - 1),
                      ),
                    );
                  }
                  return SliverFillRemaining(child: CustomErrorPage(onTap: () => _getOrderList(true)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
