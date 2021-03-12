import 'package:flutter/material.dart';
import './models/authentication.dart';
import './models/cart.dart';
import './models/orders.dart';
import './models/products.dart';
import './view/cart_screen.dart';
import './view/edit_product_screen.dart';
import './view/orders_screen.dart';
import './view/product_detail_screen.dart';
import './view/user_products_screen.dart';
import 'package:provider/provider.dart';
import './view/product_overview_screen.dart';
import './view/splash_screen.dart';
import './view/authentication_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication()),
        ChangeNotifierProxyProvider<Authentication, Products>(
          create: (_) => Products(),
          update: (ctx, authValue, previousProducts) =>
              previousProducts.getData(
            authValue.token,
            authValue.userId,
            previousProducts == null ? null : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Authentication, Orders>(
          create: (_) => Orders(),
          update: (ctx, authValue, previousOrders) => previousOrders.getData(
            authValue.token,
            authValue.userId,
            previousOrders == null ? null : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Authentication>(
        builder: (ctx, auth, context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.indigo,
            fontFamily: 'lato',
          ),
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, AsyncSnapshot authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthenticationScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
            CartScreen.routeName: (_) => CartScreen(),
            OrdersScreen.routeName: (_) => OrdersScreen(),
            UserProductsScreen.routeName: (_) => UserProductsScreen(),
            EditProductScreen.routeName: (_) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
