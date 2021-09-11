import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    var dateTimeNow = DateTime.now();

    _orders.insert(
      0,
      OrderItem(
        amount: total,
        dateTime: dateTimeNow,
        id: dateTimeNow.toString(),
        products: cartProducts,
      ),
    );

    notifyListeners();
  }
}
