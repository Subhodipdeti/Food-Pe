import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';

class CustomSearchBar extends StatefulWidget {
  final String placeholder;
  final ValueChanged onChanged;
  final Function(bool)? onFocusChange;

  const CustomSearchBar(
      {Key? key,
      this.placeholder = 'Search food',
      this.onFocusChange,
      required this.onChanged})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  Timer? _debounce;
  final FocusNode _focus = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _debounce?.cancel();
    _focus.dispose();
  }

  void _onFocusChange() {
    widget.onFocusChange!(_focus.hasFocus);
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onChanged(query);
      // do something with query
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.big_horizontal_margin / 2,
          vertical: Dimens.vertical_padding / 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 246, 246, 246),
          borderRadius: BorderRadius.circular(Dimens.radius)),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Icon(Icons.search, size: 30),
          const SizedBox(
            width: Dimens.horizontal_padding,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focus,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            width: Dimens.radius,
          ),
        ],
      ),
    );
  }
}
