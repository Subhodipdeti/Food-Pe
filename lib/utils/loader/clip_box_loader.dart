import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:skeletons/skeletons.dart';

class ClipBoxLoader extends StatelessWidget {
  const ClipBoxLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
              borderRadius: BorderRadius.circular(8),
              height: Dimens.default_container_height,
              width: Dimens.default_container_width),
        ),
        const VerticalDivider(),
        const VerticalDivider(),
      ],
    );
  }
}
