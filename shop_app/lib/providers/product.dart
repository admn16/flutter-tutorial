import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.title,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();

    final url = Uri.parse(
      'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json',
    );

    final response = await http.patch(
      url,
      body: json.encode(
        {
          'isFavorite': isFavorite,
        },
      ),
    );

    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException('Failed to udate isFavorite value to $isFavorite');
    }
  }
}
