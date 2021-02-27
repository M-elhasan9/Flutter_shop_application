import 'package:flutter/material.dart';
import 'package:flutter_shop_application/models/authentication.dart';
import 'package:flutter_shop_application/models/cart.dart';
import 'package:flutter_shop_application/models/orders.dart';
import 'package:flutter_shop_application/models/products.dart';
import 'package:flutter_shop_application/view/cart_screen.dart';
import 'package:flutter_shop_application/view/edit_product_screen.dart';
import 'package:flutter_shop_application/view/orders_screen.dart';
import 'package:flutter_shop_application/view/product_detail_screen.dart';
import 'package:flutter_shop_application/view/user_products_screen.dart';
import 'package:provider/provider.dart';
import './view/product_overview_screen.dart';
import 'view/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo,
          accentColor: Colors.pinkAccent,
          fontFamily: 'lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CartScreen.routeName: (_) => CartScreen(),
          OrdersScreen.routeName: (_) => OrdersScreen(),
          UserProductsScreen.routeName: (_) => UserProductsScreen(),
          EditProductScreen.routeName: (_) => EditProductScreen(),
        },
      ),
    );
  }
}
