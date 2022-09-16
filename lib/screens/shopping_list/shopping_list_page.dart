import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/provider/product_provider.dart';
import 'package:food_pe/screens/shopping_list/components/shopping_card_widget.dart';
import 'package:food_pe/service/product_service.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:food_pe/utils/routes.dart';
import 'package:food_pe/widgets/bottom_sheet_container_widget.dart';
import 'package:food_pe/widgets/custom_button_widget.dart';
import 'package:food_pe/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';

class ShoopingListPage extends StatefulWidget {
  const ShoopingListPage({Key? key}) : super(key: key);

  @override
  State<ShoopingListPage> createState() => _ShoopingListPageState();
}

class _ShoopingListPageState extends State<ShoopingListPage> {
  late bool isLoading = false;

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: const Text("Shopping List"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)));
  }

  Widget _buildCouponArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          child: Container(
            padding: const EdgeInsets.all(Dimens.radius),
            margin: const EdgeInsets.only(right: Dimens.horizontal_margin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.radius),
              color: const Color.fromARGB(255, 244, 244, 244),
            ),
            child: const Icon(
              Icons.percent_sharp,
              color: Colors.green,
            ),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
                text: "Feedling Frenzy",
                style: Theme.of(context).textTheme.headline5),
            CustomTextWidget(
              text: "Cashback Paytm offres.",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        )),
        CustomTextWidget(
          text: "3,24",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Widget _buildPaymentProceeing() {
    final products = Provider.of<ProductProvider>(context, listen: true);
    final subTotal = products.totalValue + 40;

    void onCreateProduct() async {
      setState(() {
        isLoading = true;
      });
      try {
        for (var prd in products.cartProducts) {
          await ProductService().createOrder(prd);
        }

        Future.delayed(const Duration(seconds: 3), () {
          // ignore: use_build_context_synchronously
          setState(() {
            isLoading = false;
          });
          products.clearCartProduct();
          Navigator.pushNamed(context, Routes.payment_page, arguments: {
            "amount": subTotal.toString(),
          });
        });
      } catch (e) {
        print(e);
      }
    }

    return BottomSheetContainerWidget(
        height: DeviceUtils.getScaledHeight(context) / 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                  text: "Subtotal",
                  style: Theme.of(context).textTheme.headline5,
                ),
                CustomTextWidget(text: "Rs. ${subTotal.toString()}")
              ],
            ),
            CustomButtonWidget(
                isLoading: isLoading,
                disabled: isLoading,
                onPressed: onCreateProduct,
                child: CustomTextWidget(
                  text: "Proceed to Pay",
                  style: Theme.of(context).textTheme.caption,
                ))
          ],
        ));
  }

  Widget _buildCartCard(cartProducts) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cartProducts!.length,
      itemBuilder: ((context, index) {
        return Column(
          children: [
            ShoppingCardWidget(
              prdId: cartProducts[index].prdId,
              title: cartProducts[index].title,
              qty: cartProducts[index].qty.toString(),
              subTitle: cartProducts[index].description,
              price: "Rs. ${cartProducts[index].price.toString()}",
              image: cartProducts[index].productImage,
            ),
            const SizedBox(height: Dimens.vertical_margin),
          ],
        );
      }),
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  Widget _buildPaymentSummaryArea(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(text: title),
        CustomTextWidget(text: value),
      ],
    );
  }

  Widget _buildMainContent(productsData) {
    if (productsData.cartProducts.length > 0) {
      return AbsorbPointer(
        absorbing: isLoading,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width /
                      Dimens.big_horizontal_margin),
                  child: Column(
                    children: [
                      // Topbar goes here
                      // shopping card list here
                      _buildCartCard(productsData.cartProducts),
                      const SizedBox(
                        height: Dimens.big_horizontal_margin,
                      ),
                      // coupon area goes here
                      _buildCouponArea(),
                      const Divider(
                        height: Dimens.big_horizontal_margin,
                      ),

                      const SizedBox(
                        height: Dimens.vertical_margin,
                      ),

                      _buildPaymentSummaryArea("Item Total",
                          "Rs. ${productsData.totalValue.toString()}"),

                      const SizedBox(
                        height: Dimens.vertical_margin,
                      ),
                      _buildPaymentSummaryArea("Delivery Charge", "Rs. 40"),

                      const SizedBox(
                        height: Dimens.vertical_margin,
                      ),

                      SizedBox(
                        height: DeviceUtils.getScaledHeight(context) / 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // proceee container is here
            _buildPaymentProceeing()
          ],
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: const CustomTextWidget(text: "Add Something to your cart"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = Provider.of<ProductProvider>(context, listen: true);
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        body: _buildMainContent(cartProducts));
  }
}
