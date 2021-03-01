import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  String authToken;
  String userId;

  getData(String authToken, String uId, List<OrderItem> orders) {
    authToken = authToken;
    userId = uId;
    _orders = orders;
    notifyListeners();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://shop-project-94eec-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

    try {
      final res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<OrderItem> loadedOrders = [];
      extractedData.forEach(
        (orderId, orderData) {
          loadedOrders.add(
            OrderItem(
              id: orderId,
              amount: orderData['amount'],
              dateTime: DateTime.parse(orderData['dateTime']),
              products: (orderData['product'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      quntity: item['quantity'],
                      title: item['title'],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (e) {
      throw e;
    }

    Future<void> addOrder(List<CartItem> cartProduct, double total) async {
      final url =
          'https://shop-project-94eec-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
      try {
        final timeStamp = DateTime.now();
        final res = await http.post(
          url,
          body: json.encode(
            {
              'amount': total,
              'dateTime': timeStamp.toIso8601String(),
              'products': cartProduct
                  .map(
                    (cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quntity,
                      'price': cp.price,
                    },
                  )
                  .toList(),
            },
          ),
        );

        _orders.insert(
          0,
          OrderItem(
              id: json.decode(res.body)['name'],
              amount: total,
              dateTime: timeStamp,
              products: cartProduct),
        );
        notifyListeners();
      } catch (e) {
        throw e;
      }
    }
  }
}
