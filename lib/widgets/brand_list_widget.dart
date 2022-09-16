import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';

class BrandListWidget extends StatelessWidget {
  final Widget child;
  final bool isClicked;
  final Function()? onClick;
  const BrandListWidget(
      {Key? key, required this.child, this.isClicked = false, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: Dimens.big_horizontal_margin),
        child: InkWell(
          onTap: onClick,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.radius),
            child: Container(
              height: Dimens.default_container_height,
              width: Dimens.default_container_width,
              padding:
                  const EdgeInsets.all(Dimens.vertical_padding + Dimens.radius),
              color: isClicked
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.secondaryContainer,
              child: Center(
                child: child,
              ),
            ),
          ),
        ));
  }
}
