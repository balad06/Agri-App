import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Fertilizer',
      description: 'A Fertilizer!',
      price: 29.99,
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-plants-1582229387.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Seed',
      description: 'Seed packets',
      price: 59.99,
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-plants-1582229387.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Soil',
      description: ' Red Soil',
      price: 19.99,
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-plants-1582229387.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Gardening tool.',
      description: 'A Equipment.',
      price: 49.99,
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/indoor-plants-1582229387.jpg',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
