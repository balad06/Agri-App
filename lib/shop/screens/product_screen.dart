import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_gridview.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../providers/products.dart';

enum options {
  Favorites,
  All,
}

class ProductOverviewscreen extends StatefulWidget {
  static const id ='Products';
  @override
  _ProductOverviewscreenState createState() => _ProductOverviewscreenState();
}

class _ProductOverviewscreenState extends State<ProductOverviewscreen> {
  var _showonlyfav = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSet().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (options values) {
              setState(() {
                if (values == options.Favorites) {
                  _showonlyfav = true;
                } else {
                  _showonlyfav = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Favorites'), value: options.Favorites),
              PopupMenuItem(child: Text('Every thing'), value: options.All),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.id);
              },
            ),
          )
        ],
      ), 
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showonlyfav),
    );
  }
}
