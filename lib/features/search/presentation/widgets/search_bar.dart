import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar();

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textFieldController = TextEditingController();
  Timer? _timeHandle;

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardTheme.shadowColor!,
              blurRadius: 5,
            )
          ],
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.search,
              style: Theme.of(context).primaryTextTheme.headline4,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Enter a keyword',
                hintStyle: Theme.of(context).primaryTextTheme.headline4,
                suffixIcon: Consumer(
                  builder: (context, watch, child) {
                    final bool state = watch(searchBarProvider);

                    if (state) {
                      return IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _textFieldController.clear();
                          _timeHandle?.cancel();
                          context
                              .read(searchBarProvider.notifier)
                              .setState(false);
                          context.read(searchProvider.notifier).setInitial();
                        },
                      );
                    } else {
                      return Icon(
                        Icons.search_rounded,
                        color: Theme.of(context).primaryColor,
                      );
                    }
                  },
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: (text) {
                context.read(searchBarProvider.notifier).setState(text != '');

                if (_timeHandle != null) {
                  _timeHandle!.cancel();
                }

                _timeHandle = Timer(
                  const Duration(milliseconds: 1000),
                  () {
                    context.read(searchProvider.notifier).searchQuery = text;
                    context.read(searchProvider.notifier).searchRestos();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
