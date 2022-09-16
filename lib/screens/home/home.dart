// ignore_for_file: deprecated_member_use, unnecessary_new, avoid_print
import 'package:flutter/material.dart';
import 'package:food_pe/constant/dimens.dart';
import 'package:food_pe/constant/errors.dart';
import 'package:food_pe/models/brand.dart';
import 'package:food_pe/models/product.dart';
import 'package:food_pe/models/promotion.dart';
import 'package:food_pe/provider/user_provider.dart';
import 'package:food_pe/screens/home/components/home_app_bar.dart';
import 'package:food_pe/screens/home/components/home_search_bar.dart';
import 'package:food_pe/service/location_service.dart';
import 'package:food_pe/service/product_service.dart';
import 'package:food_pe/utils/loader/carousel_card_loader.dart';
import 'package:food_pe/utils/loader/product_card_loader.dart';
import 'package:food_pe/utils/location.dart';
import 'package:food_pe/utils/routes.dart';
import 'package:food_pe/widgets/batch_bar_widget.dart';
import 'package:food_pe/widgets/brand_list_widget.dart';
import 'package:food_pe/widgets/product_card_widget.dart';
import 'package:food_pe/widgets/carousel_widget.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location location = Location();
  String address = "";
  bool isSearching = false;

  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    try {
      final location = await DeviceLocation().askLocation();
      _getAddress(location);
    } catch (e) {
      print(e);
    }
  }

  _getAddress(location) async {
    final addressStore = Provider.of<UserProvider>(context, listen: false);
    try {
      final response = await LocationService.getAddressByLoc(
          location.latitude, location.longitude);
      addressStore.setAddress(response.address);
    } catch (e) {
      print(e);
    }
  }

  _onFocusChange(focus) {
    setState(() {
      isSearching = focus;
    });
  }

  _onClickProduct(String pid) {
    Navigator.pushNamed(context, Routes.product_page,
        arguments: {"productId": pid});
  }

  Widget _buildBrandList() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(brands.length, (index) {
              return BrandListWidget(
                  child: Image.asset(brands[index].brandImage));
            })
          ],
        ));
  }

  Widget _buildProductList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List<Product>>(
        future: ProductService().getProducts(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
              children: [
                ...List.generate(2, (index) {
                  return const ProductCardLoader();
                })
              ],
            );
          }
          if (snapshot.hasData) {
            return Row(
              children: [
                ...List.generate(snapshot.data!.length, (index) {
                  return ProductCardWidget(
                    product: snapshot.data![index],
                    press: () => _onClickProduct(snapshot.data![index].prdId),
                  );
                })
              ],
            );
          }
          return const Text("Something wen wrong");
        },
      ),
    );
  }

  Widget _buildPromotionList() {
    return FutureBuilder<List<Promotion>>(
      future: ProductService().getPromotion(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CarouselCardLoader();
        }
        if (snapshot.hasData) {
          return CarouselWidget(imageList: snapshot.data as List<Promotion>);
        }
        return const Text(GenericError.ERROR);
      },
    );
  }

  Widget _buildContentList() {
    if (isSearching) {
      return const Placeholder();
    }
    return Column(
      children: [
        const Divider(height: Dimens.big_horizontal_margin),

        // Brand list here
        _buildBrandList(),
        const Divider(height: Dimens.big_horizontal_margin),

        const BatchBar(
            title: "Trending, Now",
            subTitle: "The food menu based on our data"),
        const Divider(height: Dimens.big_horizontal_margin),

        // Food's list here
        _buildProductList(),
        const Divider(height: Dimens.big_horizontal_margin),

        const BatchBar(
            title: "Promotion", subTitle: "All best deal only for you"),
        const Divider(height: Dimens.big_horizontal_margin),

        // Promotion list here
        _buildPromotionList()
      ],
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: EdgeInsets.all(
          MediaQuery.of(context).size.width / Dimens.big_horizontal_margin),
      child: Column(
        children: [
          // App Bar here
          HomeAppBar(isSearching: isSearching),

          const SizedBox(
            height: Dimens.big_horizontal_margin,
          ),
          // Search bar here
          HomeSearchBar(
              isSearching: isSearching, onFocusChange: _onFocusChange),

          _buildContentList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: SafeArea(
        child: SingleChildScrollView(child: _buildMainContent()),
        // child: ItemsExamplePage(),
      ),
    );
  }
}
