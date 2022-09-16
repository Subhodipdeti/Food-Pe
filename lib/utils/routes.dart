import 'package:flutter/material.dart';
import 'package:food_pe/navigation/bottom_navigation.dart';
import 'package:food_pe/screens/orders/order_page.dart';
import 'package:food_pe/screens/payment/payment_page.dart';
import 'package:food_pe/screens/product/product_page.dart';
import 'package:food_pe/screens/profile/profile_page.dart';
import 'package:food_pe/screens/shopping_list/shopping_list_page.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  // ignore: constant_identifier_names
  static const String profile_page = '/profile_page';
  // ignore: constant_identifier_names
  static const String payment_page = '/payment_page';
  // ignore: constant_identifier_names
  static const String product_page = '/product_page';
  // ignore: constant_identifier_names
  static const String orders_page = '/orders_page';
  // ignore: constant_identifier_names
  static const String shoping_list_page = '/shoping_list_page';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => BottomNavigation(),
    product_page: (BuildContext context) => ProductPage(),
    shoping_list_page: (BuildContext context) => ShoopingListPage(),
    profile_page: (BuildContext context) => ProfilePage(),
    payment_page: (BuildContext context) => PaymentPage(),
    orders_page: (BuildContext context) => OrdersPage()
  };
}
