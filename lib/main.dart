import 'package:agri_app/shop/screens/cart_screen.dart';
import 'package:agri_app/shop/screens/orders_screen.dart';
import 'package:agri_app/login/loginscreen.dart';
import 'package:agri_app/login/welcome.dart';
import 'package:agri_app/shop/screens/products_overview_screen.dart';
import 'package:agri_app/shop/screens/user_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './alarm/screens/alarm_page.dart';
import './pages/picturesearch.dart';
import './alarm/screens/reminderpage.dart';
import './shop/providers/cart.dart';
import './shop/providers/orders.dart';
import './shop/providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Products(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider.value(
            value: Orders(),
          ),
        ],
        child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Agri',
       theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            accentColor: Colors.blueAccent,
          ),
      home: WelcomePage(),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        PictureSearch.id: (context) => PictureSearch(),
        ReminderPage.id: (context) => ReminderPage(),
        AlarmPage.id: (context) => AlarmPage(),
        CartScreen.id:(context) => CartScreen(),
        OrdersScreen.id:(context) => OrdersScreen(),
        ProductsOverviewScreen.id: (context) => ProductsOverviewScreen(),
        UserProductsScreen.id: (context) => UserProductsScreen(),
      },

      ),
    );
  }
}
