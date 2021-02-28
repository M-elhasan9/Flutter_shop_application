import 'package:flutter/material.dart';
import '../controller/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order screen'),
      ),
      body: Center(
        child: Text('Text'),
      ),
      drawer: AppDrawer(),
    );
  }
}
