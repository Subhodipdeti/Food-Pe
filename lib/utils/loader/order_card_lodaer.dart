import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:skeletons/skeletons.dart';

class OrderCardLoader extends StatelessWidget {
  const OrderCardLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(5, (index) {
          return Container(
            padding: const EdgeInsets.all(Dimens.radius),
            color: Colors.white,
            child: SkeletonItem(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: Dimens.default_container_width,
                    height: Dimens.default_container_height / 1.5,
                  ),
                ),
                const SizedBox(
                  width: Dimens.radius,
                ),
                Expanded(
                  child: SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                        lines: 2,
                        spacing: Dimens.radius,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: Dimens.radius,
                          borderRadius: BorderRadius.circular(Dimens.radius),
                          minLength: DeviceUtils.getScaledWidth(context),
                        )),
                  ),
                ),
                const SizedBox(
                  width: Dimens.radius,
                )
              ],
            )),
          );
        })
      ],
    );
  }
}
