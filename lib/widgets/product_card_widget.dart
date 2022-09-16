import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/models/product.dart';
import 'package:food_pe/utils/device_utils.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  final Function()? press;

  const ProductCardWidget({Key? key, required this.product, this.press})
      : super(key: key);

  Widget _buildImageContainer(BuildContext context) {
    return SizedBox(
      height: DeviceUtils.getScaledHeight(context) / 5.5,
      width: DeviceUtils.getScaledWidth(context) / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.radius),
        child: Image.network(
          product.productImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildInfomtaionContainer(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context) / 2,
      padding: const EdgeInsets.all(Dimens.horizontal_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            product.label,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.button,
          ),
          AutoSizeText(
            product.title,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: Dimens.horizontal_padding,
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange.shade400),
              const SizedBox(
                width: Dimens.vertical_padding,
              ),
              AutoSizeText(
                product.rating,
                style: Theme.of(context).textTheme.button,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimens.radius),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.radius),
            color: Theme.of(context).colorScheme.secondaryContainer),
        child: InkWell(
          onTap: press,
          child: Column(
            children: [
              // Image container here
              _buildImageContainer(context),
              _buildInfomtaionContainer(context)
            ],
          ),
        ),
      ),
    );
  }
}
