import 'package:flutter/material.dart';
import 'package:flutter_shop_application/view/cart_screen.dart';
import 'package:flutter_shop_application/view/edit_product_screen.dart';
import 'package:flutter_shop_application/view/orders_screen.dart';
import 'package:flutter_shop_application/view/product_detail_screen.dart';
import 'package:flutter_shop_application/view/user_products_screen.dart';
import './view/product_overview_screen.dart';
import 'view/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
        CartScreen.routeName: (_) => CartScreen(),
        OrdersScreen.routeName: (_) => OrdersScreen(),
        UserProductsScreen.routeName: (_) => UserProductsScreen(),
        EditProductScreen.routeName: (_) => EditProductScreen(),
      },
    );
  }
}
