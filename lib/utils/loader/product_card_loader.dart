import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:skeletons/skeletons.dart';

class ProductCardLoader extends StatelessWidget {
  const ProductCardLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context) / 2,
      padding: const EdgeInsets.only(right: Dimens.big_horizontal_margin),
      color: Colors.white,
      child: SkeletonItem(
          child: Column(
        children: [
          const SizedBox(
            height: Dimens.radius,
          ),
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: DeviceUtils.getScaledWidth(context) / 2,
              height: DeviceUtils.getScaledHeight(context) / 5.5,
            ),
          ),
          const SizedBox(
            height: Dimens.radius,
          ),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 3,
                spacing: Dimens.radius,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: Dimens.radius,
                  borderRadius: BorderRadius.circular(Dimens.radius),
                  minLength: DeviceUtils.getScaledWidth(context) / 4,
                )),
          ),
          const SizedBox(
            width: Dimens.radius,
          )
        ],
      )),
    );
  }
}
