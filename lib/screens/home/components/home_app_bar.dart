import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/provider/product_provider.dart';
import 'package:food_pe/provider/user_provider.dart';
import 'package:food_pe/screens/home/components/location_widget.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:food_pe/utils/routes.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget {
  final bool isSearching;
  const HomeAppBar({Key? key, required this.isSearching}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  void onOpenModal() {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return const LocationWidget();
        },
        fullscreenDialog: true));
  }

  void onClickIcon() {
    if (widget.isSearching) {
      DeviceUtils.hideKeyboard(context);
      return;
    }
    Navigator.of(context).pushNamed(Routes.shoping_list_page);
  }

  Widget _buildTralingContainer() {
    return ClipOval(
      child: Container(
        color: const Color.fromARGB(255, 246, 246, 246),
        padding: const EdgeInsets.all(Dimens.radius / 4),
        child: IconButton(
          onPressed: onClickIcon,
          icon: widget.isSearching
              ? const Icon(Icons.close)
              : Consumer<ProductProvider>(
                  builder: ((context, value, child) {
                    return Stack(
                      children: <Widget>[
                        const Icon(Icons.shopping_cart_outlined),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: value.cartProducts != null
                                ? Text(
                                    value.cartProducts.length.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : const Center(),
                          ),
                        )
                      ],
                    );
                  }),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: onOpenModal,
                child: Row(
                  children: [
                    AutoSizeText(
                      'Your Location',
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const Icon(Icons.arrow_drop_down_outlined)
                  ],
                ),
              ),
              Consumer<UserProvider>(
                builder: ((context, value, child) {
                  return AutoSizeText(
                    value.userAddress != null
                        ? value.userAddress.toString()
                        : '--',
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5,
                  );
                }),
              ),
            ],
          ),
        ),
        _buildTralingContainer()
      ],
    );
  }
}
