import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  String? authToken;
  String? userId;
  List<Product> _items = [];

  Products({
    String? token,
    required List<Product> productItems,
    String? user,
  }) {
    this._items = productItems;
    this.authToken = token;
    this.userId = user;
  }

  // Returned a copy so that the `_items` property won't be modifiable outside of this class
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts({bool filterByUser = false}) async {
    final filterString =
        filterByUser ? '&orderBy="userId"&equalTo="$userId"' : '';
    final url = Uri.parse(
      'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken$filterString',
    );

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;

      if (extractedData == null) {
        return;
      }

      final favoriteUrl = Uri.parse(
        'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken',
      );
      final favoriteResponse = await http.get(favoriteUrl);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          description: prodData['description'],
          title: prodData['title'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
      'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'userId': userId,
          },
        ),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
      );

      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final url = Uri.parse(
      'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken',
    );
    final prodIndex = _items.indexWhere((element) => element.id == id);

    await http.patch(
      url,
      body: json.encode(
        {
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        },
      ),
    );

    _items[prodIndex] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
      'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken',
    );
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct as Product);
      notifyListeners();
      throw HttpException('Could not delete product w/ id $id');
    }
    existingProduct = null;
  }
}
