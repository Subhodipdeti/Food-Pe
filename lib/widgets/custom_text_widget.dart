import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const CustomTextWidget({
    Key? key,
    required this.text,
    this.style = const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
