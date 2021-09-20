import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

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

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
      'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/products.json',
    );

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          description: prodData['description'],
          title: prodData['title'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: prodData['isFavorite'],
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
      'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/products.json',
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
            'isFavorite': product.isFavorite,
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
      'https://flutter-shop-f137c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json',
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
    // final prodIndex = _items.indexWhere((prod) => prod.id == id);
    // if (prodIndex >= 0) {
    //   _items[prodIndex] = newProduct;
    //   notifyListeners();
    // } else {
    //   print('...');
    // }
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);

    notifyListeners();
  }
}
