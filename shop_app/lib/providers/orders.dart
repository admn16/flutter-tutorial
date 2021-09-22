import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try {
      final url = Uri.parse(
        'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json',
      );

      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];

      extractedData.forEach((orderId, orderData) {
        final List<CartItem> cartItems = [];
        final List products = [...orderData['products']];
        products.forEach((element) {
          cartItems.add(
            CartItem(
              id: element['id'],
              title: element['title'],
              price: element['price'],
              quantity: element['quantity'],
            ),
          );
        });

        loadedOrders.add(OrderItem(
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          id: orderId,
          products: cartItems,
        ));
      });

      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
      'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json',
    );
    var dateTimeNow = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': total,
            'dateTime': dateTimeNow.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          },
        ),
      );

      if (response.statusCode >= 400) {
        throw HttpException('Failed to add order');
      }

      final newOrder = OrderItem(
        amount: total,
        dateTime: dateTimeNow,
        id: json.decode(response.body)['name'],
        products: cartProducts,
      );

      _orders.insert(
        0,
        newOrder,
      );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
