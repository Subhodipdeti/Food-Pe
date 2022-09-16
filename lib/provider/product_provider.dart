import 'package:flutter/material.dart';

class CartProduct {
  final String prdId;
  final dynamic price;
  final dynamic orginalPrice;
  final String title;
  final String productImage;
  final String description;
  final int qty;

  CartProduct(
      {required this.qty,
      required this.prdId,
      required this.price,
      required this.orginalPrice,
      required this.title,
      required this.productImage,
      this.description = ""});
}

class ProductProvider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  var _topping_with_price = 0;
  var _total_value = 0;

  // ignore: non_constant_identifier_names
  var _cart_products = [];

  get toppingWithPrice {
    return _topping_with_price;
  }

  get cartProducts {
    return _cart_products;
  }

  get totalValue {
    return _total_value;
  }

  void setToppingWithPrice(toppingPrice) {
    _topping_with_price = toppingPrice;
    notifyListeners();
  }

  CartProduct _addTotalCartItem(product, price, qty) {
    return CartProduct(
        prdId: product.prdId,
        price: price,
        orginalPrice: product.orginalPrice,
        description: product.description,
        productImage: product.productImage,
        qty: qty,
        title: product.title);
  }

  void setTotalValue() {
    var _total_num = 0;
    _cart_products.forEach((element) {
      _total_num += element.price as int;
    });
    _total_value = _total_num;
  }

  void setCartProduct(product) {
    final totalPrice = _topping_with_price > 0
        ? product.price + _topping_with_price
        : product.price;

    // ignore: prefer_collection_literals
    late List mappedCartData = [
      ...cartProducts,
      _addTotalCartItem(product, totalPrice, 1)
    ];

    for (var cp in cartProducts) {
      if (cp.prdId == product.prdId) {
        mappedCartData.remove(cp);
        mappedCartData[mappedCartData
                .indexWhere((element) => element.prdId == product.prdId)] =
            _addTotalCartItem(
                product, product.price * (cp.qty + 1), cp.qty + 1);
      }
    }

    _cart_products = mappedCartData;
    setTotalValue();
    notifyListeners();
  }

  void addCartProduct(prdId) {
    late List addProduct = [...cartProducts];
    final index = addProduct.indexWhere((item) => item.prdId == prdId);
    final dp = addProduct[index];

    addProduct[index] =
        _addTotalCartItem(dp, dp.price + dp.orginalPrice, dp.qty + 1);

    _cart_products = addProduct;
    setTotalValue();
    notifyListeners();
  }

  void removeCartProduct(prdId) {
    late List deletedProduct = [...cartProducts];
    final index = deletedProduct.indexWhere((item) => item.prdId == prdId);
    final dp = deletedProduct[index];

    dp.qty == 1
        ? deletedProduct.removeAt(index)
        : deletedProduct[index] =
            _addTotalCartItem(dp, dp.price - dp.orginalPrice, dp.qty - 1);

    _cart_products = deletedProduct;
    setTotalValue();
    notifyListeners();
  }

  void clearCartProduct() {
    _cart_products = [];
    notifyListeners();
  }
}
