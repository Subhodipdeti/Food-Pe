import 'package:flutter/material.dart';
import 'package:food_pe/widgets/custom_text_widget.dart';

class BatchBar extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool hasIcon;
  const BatchBar(
      {Key? key, required this.title, this.subTitle = "", this.hasIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
                text: title, style: Theme.of(context).textTheme.headline5),
            CustomTextWidget(
              text: subTitle,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        )),
        hasIcon ? const Icon(Icons.arrow_right_outlined) : const Center()
      ],
    );
  }
}
