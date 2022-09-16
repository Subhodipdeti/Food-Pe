import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/provider/product_provider.dart';
import 'package:food_pe/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';

class ShoppingCardWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String price;
  final String? image;
  final String qty;
  final String prdId;

  const ShoppingCardWidget(
      {Key? key,
      required this.prdId,
      required this.title,
      this.subTitle,
      required this.price,
      this.image,
      required this.qty})
      : super(key: key);

  Widget _buildIconButton(BuildContext context, Icon icon, String type) {
    final pv = Provider.of<ProductProvider>(context, listen: false);
    return ClipRect(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(Dimens.radius)),
      child: IconButton(
        onPressed: () {
          if (type == "remove") {
            pv.removeCartProduct(prdId);
          } else {
            pv.addCartProduct(prdId);
          }
        },
        icon: icon,
      ),
    ));
  }

  Widget _buildProductImage() {
    return Expanded(
        child: InkWell(
      child: SizedBox(
        height: Dimens.default_container_height + Dimens.button_height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.radius),
          child: Image.network(
            image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }

  Widget _buildActionArea(BuildContext context) {
    return Row(
      children: [
        _buildIconButton(context, const Icon(Icons.remove), "remove"),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.big_horizontal_margin),
          child: CustomTextWidget(
              text: qty, style: Theme.of(context).textTheme.subtitle2),
        ),
        _buildIconButton(context, const Icon(Icons.add), "add"),
      ],
    );
  }

  Widget _buildInformationArea(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
              text: title, style: Theme.of(context).textTheme.headline5),
          CustomTextWidget(
              text: subTitle!, style: Theme.of(context).textTheme.subtitle2),
          const SizedBox(
            height: Dimens.horizontal_margin,
          ),
          // add / remove area is here
          _buildActionArea(context)
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
          height: Dimens.default_container_height + Dimens.button_height,
          padding: const EdgeInsets.only(left: Dimens.horizontal_padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Information here
              _buildInformationArea(context),
              const SizedBox(
                width: Dimens.radius,
              ),
              CustomTextWidget(
                  text: price, style: Theme.of(context).textTheme.bodyText2)
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildProductImage(),
        _buildMainContent(context),
      ],
    );
  }
}
