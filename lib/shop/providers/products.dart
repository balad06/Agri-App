import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
  ];
  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSet([bool filterByUser = false]) async {
    var url =
        'https://agricappback.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://agricappback.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      var favoriteData = json.decode(favoriteResponse.body);
      if (favoriteData == null) {
        favoriteData = {};
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        if (filterByUser) {
          if (prodData['creatorId'] == userId) {
            loadedProducts.add(Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              isFavorite: favoriteData[prodId] == null
                  ? false
                  : favoriteData[prodId] ?? false,
              imageUrl: prodData['imageUrl'],
            ));
          }
        } else {
          loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: favoriteData[prodId] == null
                ? false
                : favoriteData[prodId] ?? false,
            imageUrl: prodData['imageUrl'],
          ));
        }
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://agricappback.firebaseio.com/products.json?auth=$authToken';
    print(product.title);
    try {
      print('post');
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId
        }),
      );
      print(response.body);
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://agricappback.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'imageUrl': newProduct.imageUrl,
            'description': newProduct.description,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
    } else {
      print('...');
    }
    notifyListeners();
  }

  void deleteProduct(String id) async {
    final url =
        'https://agricappback.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    print(response.body);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw 'Could not delete';
    }
    existingProduct = null;
  }

  notifyListeners();
}
