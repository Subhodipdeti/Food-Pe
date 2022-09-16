import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/service/product_service.dart';
import 'package:food_pe/utils/device_utils.dart';
import 'package:food_pe/utils/routes.dart';
import 'package:food_pe/widgets/custom_search_bar.dart';
import 'package:food_pe/widgets/custom_text_widget.dart';

class HomeSearchBar extends StatefulWidget {
  final bool isSearching;
  final Function(bool)? onFocusChange;
  const HomeSearchBar({Key? key, required this.isSearching, this.onFocusChange})
      : super(key: key);

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  List searchResult = [];

  _onHandleSearch(value) async {
    if (value.toString().isNotEmpty) {
      try {
        final response = await ProductService().getProduct(value);
        if (response.isNotEmpty) {
          setState(() {
            searchResult = response;
          });
        }
      } catch (e) {
        // print(e);
      }
    } else {
      setState(() {
        searchResult = [];
      });
    }
  }

  _onClickProduct(String pid) {
    Navigator.pushNamed(context, Routes.product_page,
        arguments: {"productId": pid});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: Dimens.radius),
          child: CustomSearchBar(
            onChanged: _onHandleSearch,
            onFocusChange: widget.onFocusChange,
          ),
        ),
        widget.isSearching
            ? InkWell(
                onTap: () {
                  DeviceUtils.hideKeyboard(context);
                },
                child: SizedBox(
                  height: DeviceUtils.getScaledHeight(context),
                  child: ListView.builder(
                    itemCount: searchResult.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: Dimens.radius),
                        // onClickProduct
                        child: InkWell(
                          onTap: () {
                            _onClickProduct(searchResult[index]!.prdId);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(
                                    searchResult[index]!.productImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimens.radius),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextWidget(
                                          text: searchResult[index]!.title),
                                      CustomTextWidget(
                                          text:
                                              searchResult[index]!.description)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              )
            : const Center()
      ],
    );
  }
}
