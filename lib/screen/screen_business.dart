import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_screen.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  static const String path = 'business';
  static const String name = 'business';

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  /// Customer
  late TextEditingController _phoneTextController;
  late final TextEditingController _messageTextController;

  void _onDropDownChanged(RequestSchema? data) {
    if (data != null) {
      _requestItem.value = data;
    }
  }

  void _openSuccessModal() {
    showDialog(
      context: context,
      builder: (context) {
        return const BusinessModal();
      },
    );
  }

  /// BusinessService
  late final ValueNotifier<RequestSchema?> _requestItem;
  late final BusinessService _instanceBusinessService;
  late final BusinessService _businessService;

  void _listenBusinessState(BuildContext context, BusinessState state) {
    if (state is MessageSended) {
      _openSuccessModal();
      _requestItem.value = null;
      _phoneTextController.clear();
      _messageTextController.clear();
    }
  }

  void _listenInstanceBusinessState(BuildContext context, BusinessState state) {
    if (state is FailureBusinessState) {}
  }

  void _queryBusinessRequestList() {
    _instanceBusinessService.handle(const QueryBusinessRequestList());
  }

  void _sendBusinessMessage() {
    _businessService.handle(SendBusinessMessage(
      phoneNumber: _phoneTextController.text,
      message: _messageTextController.text,
      requestId: _requestItem.value!.id!,
    ));
  }

  @override
  void initState() {
    super.initState();

    /// Customer
    _phoneTextController = TextEditingController();
    _messageTextController = TextEditingController();

    /// BusinessService
    _requestItem = ValueNotifier(null);
    _businessService = BusinessService();
    _instanceBusinessService = BusinessService.instance();
    if (_instanceBusinessService.value is! RequestItemListBusinessState) WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _queryBusinessRequestList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BusinessAppBar(),
      body: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
            const SliverToBoxAdapter(
              child: CustomListTile(height: 30.0, title: Text('Contact')),
            ),
            SliverToBoxAdapter(
              child: ClipRect(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Autocomplete<String>(
                    optionsBuilder: (textValue) {
                      final phones = [ClientService.authenticated!.phoneNumber!];
                      return phones.where((item) => textValue.text.isNotEmpty ? item.contains(textValue.text): true);
                    },
                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                      _phoneTextController = textEditingController;
                      return CustomTextField(
                        focusNode: focusNode,
                        margin: EdgeInsets.zero,
                        controller: textEditingController,
                        hintText: 'Email ou Numéro de téléphone',
                        onFieldSubmitted: (_) => onFieldSubmitted(),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
            const SliverToBoxAdapter(
              child: CustomListTile(height: 30.0, title: Text('Requête')),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ValueListenableConsumer<BusinessState>(
                  listener: _listenInstanceBusinessState,
                  valueListenable: _instanceBusinessService,
                  builder: (context, state, child) {
                    List<RequestSchema>? items;
                    ValueChanged<RequestSchema?>? onChanged = _onDropDownChanged;
                    if (state is PendingBusinessState) {
                      onChanged = null;
                    } else if (state is RequestItemListBusinessState) {
                      items = state.data;
                    }
                    return ValueListenableBuilder<RequestSchema?>(
                      valueListenable: _requestItem,
                      builder: (context, value, child) {
                        return DropdownButtonFormField<RequestSchema>(
                          value: value,
                          isDense: true,
                          isExpanded: true,
                          onChanged: onChanged,
                          hint: const Text("Selectionner un business"),
                          items: items?.map((e) => DropdownMenuItem<RequestSchema>(value: e, child: Text(e.title!))).toList(),
                          decoration: InputDecoration(
                            filled: true,
                            isCollapsed: true,
                            fillColor: CupertinoColors.systemGrey5,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8.0)),
            const SliverToBoxAdapter(
              child: CustomListTile(height: 30.0, title: Text('Message')),
            ),
            SliverToBoxAdapter(
              child: CustomTextField(
                controller: _messageTextController,
                hintText: 'Ecrire...',
                maxLines: 5,
                minLines: 5,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(),
                    const SizedBox(height: 8.0),
                    ValueListenableBuilder<RequestSchema?>(
                      valueListenable: _requestItem,
                      builder: (context, value, child) {
                        return ValueListenableConsumer<BusinessState>(
                          listener: _listenBusinessState,
                          valueListenable: _businessService,
                          builder: (context, state, child) {
                            VoidCallback? onPressed = _sendBusinessMessage;
                            if (state is PendingBusinessState || value == null) onPressed = null;
                            final style = TextStyle(color: onPressed == null ? CupertinoColors.systemGrey2 : null);
                            return CupertinoButton.filled(
                              padding: EdgeInsets.zero,
                              onPressed: onPressed,
                              child: Visibility(
                                visible: value == null || onPressed != null,
                                replacement: const CupertinoActivityIndicator(),
                                child: Text('Envoyer', style: style),
                              ),
                            );
                          },
                        );
                      },
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
