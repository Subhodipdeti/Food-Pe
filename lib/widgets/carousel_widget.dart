import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/models/promotion.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWidget extends StatelessWidget {
  final List<Promotion> imageList;
  const CarouselWidget({Key? key, required this.imageList}) : super(key: key);

  Widget _buildPromotionContent(String image) {
    return Image.network(
      image,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.radius),
          child: SizedBox(
            height: DeviceUtils.getScaledHeight(context) / 4.5,
            width: double.infinity,
            // color: Colors.amber,
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(imageList.length, (postion) {
                  return _buildPromotionContent(imageList[postion].image);
                })
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.radius),
          child: SmoothPageIndicator(
            controller: controller,
            count: imageList.length,
            effect: SlideEffect(
                dotWidth: 12.0,
                dotHeight: 12.0,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 0.5,
                dotColor: Colors.white,
                activeDotColor: Theme.of(context).colorScheme.background),
          ),
        )
      ],
    );
  }
}
