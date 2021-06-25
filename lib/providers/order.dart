import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;
  OrderItem({this.id, this.amount, this.products, this.datetime});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    const url =
        'https://shop-app-914b6-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(Uri.parse(url));
    final List<OrderItem> items = [];
    final extracted = json.decode(response.body) as Map<String, dynamic>;
    if (extracted == null) return;
    extracted.forEach((key, value) {
      items.add(
        OrderItem(
            id: key,
            amount: value['amount'],
            products: (value['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      title: item['title']),
                )
                .toList(),
            datetime: DateTime.parse(value['dateTime'])),
      );
    });
    _orders = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url =
        'https://shop-app-914b6-default-rtdb.firebaseio.com/orders.json';
    final tims = DateTime.now();

    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': tims.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price
                  })
              .toList(),
        }));

    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            datetime: tims));
    notifyListeners();
  }
}
