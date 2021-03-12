import 'package:flutter/material.dart';
import '../controller/product_item.dart';
import '../models/products.dart';
import 'package:provider/provider.dart';


class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favoritesItems:productData.items;
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ), itemBuilder: (ctx,i)=>ChangeNotifierProvider.value(value: products[i],
              child: ProductItem(),
            ));
  }
}
