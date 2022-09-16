import 'package:flutter/material.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:skeletons/skeletons.dart';

class CarouselCardLoader extends StatelessWidget {
  const CarouselCardLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAvatar(
      style: SkeletonAvatarStyle(
        width: DeviceUtils.getScaledWidth(context),
        height: DeviceUtils.getScaledHeight(context) / 4.5,
      ),
    );
  }
}
