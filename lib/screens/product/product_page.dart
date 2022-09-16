import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/constant/errors.dart';
import 'package:food_pe/models/product.dart';
import 'package:food_pe/provider/product_provider.dart';
import 'package:food_pe/screens/product/components/topping_widget.dart';
import 'package:food_pe/service/product_service.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:food_pe/utils/loader/carousel_card_loader.dart';
import 'package:food_pe/utils/loader/product_information_loader.dart';
import 'package:food_pe/utils/routes.dart';
import 'package:food_pe/widgets/batch_bar_widget.dart';
import 'package:food_pe/widgets/bottom_sheet_container_widget.dart';
import 'package:food_pe/widgets/custom_button_widget.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  PreferredSizeWidget _buildAppBar(AsyncSnapshot snapshot) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      title: snapshot.hasData ? Text(snapshot.data.title) : const Center(),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)),
    );
  }

  Widget _buildProductCard(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CarouselCardLoader();
    }
    if (snapshot.hasData) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.radius),
        child: SizedBox(
            height: DeviceUtils.getScaledHeight(context) / 4.5,
            width: double.infinity,
            // color: Colors.amber,
            child: Image.network(
              snapshot.data.productImage,
              fit: BoxFit.cover,
            )),
      );
    }

    return const Text(GenericError.ERROR);
  }

  Widget _buildProductDetails(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const ProductInformationLoader();
    }
    if (snapshot.hasData) {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        snapshot.data.title,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.button,
                      ),
                      AutoSizeText(
                        snapshot.data.label,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange.shade400),
                          const SizedBox(
                            width: Dimens.vertical_padding,
                          ),
                          AutoSizeText(
                            snapshot.data.rating,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.radius),
                    child: Container(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      padding: const EdgeInsets.all(Dimens.horizontal_padding),
                      child: const Icon(
                        Icons.heart_broken,
                        color: Colors.redAccent,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: Dimens.big_horizontal_margin,
              ),
              AutoSizeText(
                snapshot.data.description,
                // softWrap: false,
                // overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          )
        ],
      );
    }
    return const Text(GenericError.ERROR);
  }

  Widget _buildCheckoutContenet(AsyncSnapshot snapshot) {
    final cartProduct = Provider.of<ProductProvider>(context, listen: false);
    void onHandleCheckout() {
      cartProduct.setCartProduct(snapshot.data);
      Navigator.pushNamed(context, Routes.shoping_list_page);
    }

    return BottomSheetContainerWidget(
      child: Row(
        children: [
          Expanded(child: Center(child: Consumer<ProductProvider>(
            builder: ((context, value, child) {
              final totalPrice = snapshot.hasData
                  ? snapshot.data.hasTopping
                      ? snapshot.data.price + value.toppingWithPrice
                      : snapshot.data.price
                  : "--";
              return AutoSizeText(
                'Rs. ${totalPrice.toString()}',
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              );
            }),
          ))),
          Expanded(
              child: CustomButtonWidget(
                  disabled: snapshot.connectionState == ConnectionState.waiting,
                  onPressed: onHandleCheckout,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "Checkout",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(
                        width: Dimens.radius,
                      ),
                      const Icon(Icons.arrow_forward_outlined)
                    ],
                  )))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return FutureBuilder<Product>(
      future: ProductService().getProductById(args["productId"]),
      builder: (BuildContext ctx, snapshot) {
        return Scaffold(
            appBar: _buildAppBar(snapshot),
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width /
                                Dimens.big_horizontal_margin),
                        child: Column(
                          children: [
                            // Product card here
                            _buildProductCard(snapshot),
                            const Divider(height: Dimens.big_horizontal_margin),
                            // Product details area start here
                            _buildProductDetails(snapshot),

                            const Divider(
                              height: Dimens.big_horizontal_margin,
                            ),
                            snapshot.hasData && snapshot.data!.hasTopping
                                ? const BatchBar(
                                    title: "Toppings",
                                    subTitle: "Choose the your best pair",
                                    hasIcon: false,
                                  )
                                : const Center(),
                            const Divider(
                              height: Dimens.big_horizontal_margin,
                            ),
                            // Toppings start here
                            snapshot.hasData && snapshot.data!.hasTopping
                                ? ToppingWidget(snapshot: snapshot)
                                : const Center(),

                            SizedBox(
                              height: DeviceUtils.getScaledHeight(context) / 5,
                            )
                            // const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    )),
                // checkout start here
                _buildCheckoutContenet(snapshot),
              ],
            ));
      },
    );
  }
}
