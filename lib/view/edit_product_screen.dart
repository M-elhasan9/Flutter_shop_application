import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = '/edit-product-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product screen'),
      ),
      body: Center(
        child: Text('edit product screen'),
      ),
    );
  }
}
