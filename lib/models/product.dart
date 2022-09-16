import 'package:food_pe/models/topping.dart';

class Product {
  final String prdId;
  final dynamic price;
  final dynamic orginalPrice;
  final String description;
  final String title;
  final String label;
  final String rating;
  final String productImage;
  final bool hasTopping;
  final List<Topping>? toppings;

  Product(
      {required this.prdId,
      required this.title,
      required this.productImage,
      required this.price,
      required this.orginalPrice,
      this.description = '',
      this.hasTopping = false,
      this.toppings,
      this.label = '',
      this.rating = ''});
}
