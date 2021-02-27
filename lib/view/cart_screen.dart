import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart screen'),
      ),
      body: Center(
        child: Text('Cart screen'),
      ),
    );
  }
}
