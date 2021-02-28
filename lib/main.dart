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
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: Consumer<Authentication>(
        builder: (ctx, auth, _) => MaterialApp(
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
                          :
                          //TODO: Problem in authentication
                          //AuthenticationScreen(),
                          ProductOverviewScreen(),
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
