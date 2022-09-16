import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:skeletons/skeletons.dart';

class ProductInformationLoader extends StatelessWidget {
  const ProductInformationLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 3,
                    spacing: Dimens.radius,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: Dimens.radius,
                      borderRadius: BorderRadius.circular(Dimens.radius),
                      minLength: DeviceUtils.getScaledWidth(context) / 5,
                    )),
              ),
            ),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  borderRadius: BorderRadius.circular(8),
                  height: Dimens.default_container_height / 2,
                  width: Dimens.default_container_width / 2),
            ),
          ],
        ),
        const SizedBox(
          height: Dimens.horizontal_margin,
        ),
        SkeletonParagraph(
          style: SkeletonParagraphStyle(
              lines: 3,
              spacing: Dimens.radius,
              lineStyle: SkeletonLineStyle(
                randomLength: true,
                height: Dimens.radius,
                borderRadius: BorderRadius.circular(Dimens.radius),
                minLength: DeviceUtils.getScaledWidth(context),
              )),
        ),
      ],
    );
  }
}
