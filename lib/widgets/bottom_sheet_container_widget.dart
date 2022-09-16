import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';

class BottomSheetContainerWidget extends StatelessWidget {
  final double height;
  final Widget child;

  const BottomSheetContainerWidget(
      {Key? key,
      this.height = Dimens.default_container_height,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.all(Dimens.vertical_padding),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              border: Border(
                  top: BorderSide(
                      width: Dimens.border_width,
                      color:
                          Theme.of(context).colorScheme.secondaryContainer))),
          child: child),
    );
  }
}
