import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/constant/errors.dart';
import 'package:food_pe/models/order.dart';
import 'package:food_pe/service/product_service.dart';
import 'package:food_pe/utils/loader/order_card_lodaer.dart';
import 'package:food_pe/widgets/custom_text_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      title: const CustomTextWidget(text: "Orders"),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)),
    );
  }

  Widget _buildProductImage(String image) {
    return SizedBox(
      height: Dimens.default_container_height + Dimens.default_container_height,
      width: Dimens.default_container_width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.radius),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: FutureBuilder<List<Order>>(
        future: ProductService().getOrders(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const OrderCardLoader();
          }
          if (snapshot.hasData) {
            return ListView.separated(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.vertical_margin),
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading:
                        _buildProductImage(snapshot.data![index].productImage),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(text: snapshot.data![index].title),
                        CustomTextWidget(
                            text: "Qty. ${snapshot.data![index].qty}"),
                      ],
                    ),
                    trailing: CustomTextWidget(
                        text: "Rs. ${snapshot.data![index].price}"),
                  );
                }),
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
                itemCount: snapshot.data!.length);
          }

          return const Text(GenericError.ERROR);
        }),
      ),
    );
  }
}
