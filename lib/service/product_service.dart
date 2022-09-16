import 'package:firebase_database/firebase_database.dart';
import 'package:food_pe/constant/errors.dart';
import 'package:food_pe/models/brand.dart';
import 'package:food_pe/models/order.dart';
import 'package:food_pe/models/product.dart';
import 'package:food_pe/models/promotion.dart';
import 'package:food_pe/models/topping.dart';

class ProductService {
  final ref = FirebaseDatabase.instance.ref();

  List<Topping> getToppings(List topping) {
    final List<Topping> topData = [];
    for (final tp in topping) {
      topData.add(Topping(name: tp["name"], price: tp["price"]));
    }
    return topData;
  }

  Future createOrder(product) async {
    try {
      final snapshot = await ref.child('orders').push();
      snapshot.set({
        "prdId": product.prdId,
        "qty": product.qty,
        "title": product.title,
        "description": product.description,
        "price": product.price,
        "productImage": product.productImage
      });
    } catch (e) {
      return throw e;
    }
  }

  Future<List<Order>> getOrders() async {
    try {
      final snapshot = await ref.child('orders').get();
      if (snapshot.exists) {
        final Map ordersData = snapshot.value as Map;
        final List<Order> orders = [];
        ordersData.forEach((key, order) {
          orders.add(Order(
              prdId: order["prdId"].toString(),
              qty: order["qty"].toString(),
              title: order["title"].toString(),
              description: order["description"].toString(),
              price: order["price"].toString(),
              productImage: order["productImage"].toString()));
        });
        return orders;
      }

      return throw GenericError.ERROR;
    } catch (e) {
      return throw e;
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final snapshot = await ref.child('products').get();
      if (snapshot.exists) {
        final Map productData = snapshot.value as Map;
        final List<Product> pd = [];
        productData.forEach((key, pv) {
          pd.add(Product(
              prdId: key,
              title: pv["title"],
              price: pv["price"],
              orginalPrice: pv["price"],
              description: pv["description"],
              productImage: pv["productImage"],
              hasTopping: pv["hasTopping"],
              toppings: pv["hasTopping"] ? getToppings(pv["toppings"]) : [],
              label: pv["label"],
              rating: pv["rating"]));
        });
        return pd;
      }
      return throw GenericError.ERROR;
    } catch (e) {
      return throw e;
    }
  }

  Future<List<Product>> getProduct(String foodName) async {
    try {
      final snapshot = await ref
          .child('products')
          .orderByChild("title")
          .startAt(foodName)
          .get();

      if (snapshot.exists) {
        final Map productData = snapshot.value as Map;
        final List<Product> pd = [];
        productData.forEach((key, pv) {
          pd.add(Product(
              prdId: key,
              title: pv["title"],
              price: pv["price"],
              orginalPrice: pv["price"],
              description: pv["description"],
              productImage: pv["productImage"],
              hasTopping: pv["hasTopping"],
              toppings: pv["hasTopping"] ? getToppings(pv["toppings"]) : [],
              label: pv["label"],
              rating: pv["rating"]));
        });
        return pd;
      }
      return throw GenericError.ERROR;
    } catch (e) {
      return throw e;
    }
  }

  Future<Product> getProductById(String pid) async {
    try {
      final snapshot = await ref.child('products/$pid').get();
      if (snapshot.exists) {
        final Map productData = snapshot.value as Map;

        return Product(
            prdId: pid,
            title: productData["title"],
            price: productData["price"],
            orginalPrice: productData["price"],
            description: productData["description"],
            productImage: productData["productImage"],
            hasTopping: productData["hasTopping"],
            toppings: productData["hasTopping"]
                ? getToppings(productData["toppings"])
                : [],
            label: productData["label"],
            rating: productData["rating"]);
      }
      return throw GenericError.ERROR;
    } catch (e) {
      return throw e;
    }
  }

  Future<List<Brand>> getBrands() async {
    try {
      final snapshot = await ref.child('brands').get();

      if (snapshot.exists) {
        final Map brandData = snapshot.value as Map;
        final List<Brand> bd = [];
        for (var bi in brandData.values) {
          bd.add(Brand(brandImage: bi["brandImage"]));
        }
        return brands;
      }
      return throw GenericError.ERROR;
    } catch (e) {
      return throw e;
    }
  }

  Future<List<Promotion>> getPromotion() async {
    try {
      final snapshot = await ref.child('promotion').get();

      if (snapshot.exists) {
        final Map promotionData = snapshot.value as Map;
        final List<Promotion> pd = [];
        for (var bi in promotionData.values) {
          pd.add(Promotion(image: bi["image"]));
        }
        return pd;
      }
      return throw GenericError.ERROR;
    } catch (e) {
      return throw e;
    }
  }
}
