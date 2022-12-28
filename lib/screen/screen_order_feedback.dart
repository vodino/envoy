import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '_screen.dart';

class OrderFeedbackScreen extends StatefulWidget {
  const OrderFeedbackScreen({super.key, required this.order});

  final Order order;

  static const String name = 'order_feedback';
  static const String path = 'feedback';

  @override
  State<OrderFeedbackScreen> createState() => _OrderFeedbackScreenState();
}

class _OrderFeedbackScreenState extends State<OrderFeedbackScreen> {
  /// Customer
  late final TextEditingController _messageTextController;

  void _onClose() {
    Navigator.pop(context);
  }

  /// OrderService
  late final OrderService _orderService;

  void _listenOrderState(BuildContext context, OrderState state) {
    if (state is SuccessOrderState) {
      Navigator.pop(context);
    }
  }

  void _rateOrder() {
    _orderService.handle(RateOrder(
      orderId: widget.order.id!,
      riderId: widget.order.rider!.id!,
      feedback: _messageTextController.text,
    ));
  }

  @override
  void initState() {
    super.initState();

    /// Customer
    _messageTextController = TextEditingController();

    /// OrderService
    _orderService = OrderService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderFeedbackAppBar(close: _onClose),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          controller: ModalScrollController.of(context),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              sliver: SliverToBoxAdapter(
                child: AspectRatio(
                  aspectRatio: 4.0,
                  child: CustomCircleAvatar(
                    backgroundColor: CupertinoColors.systemGrey,
                    foregroundImage: widget.order.rider!.avatar != null ? NetworkImage('${RepositoryService.httpURL}/storage/${widget.order.rider!.avatar}') : null,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListTile(
                height: 60.0,
                title: Center(
                  child: Text(
                    widget.order.rider!.fullName!,
                    style: context.cupertinoTheme.textTheme.navTitleTextStyle,
                  ),
                ),
                subtitle: Center(
                  child: Text(
                    "S'il te plait evaluez mon service",
                    style: context.cupertinoTheme.textTheme.textStyle,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: RatingBar.builder(
                  itemCount: 5,
                  minRating: 0,
                  initialRating: 0,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  onRatingUpdate: (rating) {},
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: CustomListTile(height: 35.0, title: Text('Message'))),
            SliverToBoxAdapter(
              child: CustomTextField(
                controller: _messageTextController,
                hintText: 'Ecrire...',
                maxLines: 6,
                minLines: 6,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ValueListenableConsumer<OrderState>(
                      listener: _listenOrderState,
                      valueListenable: _orderService,
                      builder: (context, state, child) {
                        VoidCallback? onPressed = _rateOrder;
                        if (state is PendingOrderState) onPressed = null;
                        return CupertinoButton.filled(
                          padding: EdgeInsets.zero,
                          onPressed: onPressed,
                          child: Visibility(
                            visible: onPressed != null,
                            replacement: const CupertinoActivityIndicator(),
                            child: const Text('Soumettre'),
                          ),
                        );
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
