import 'package:agri_app/reminder/global_bloc.dart';
import 'package:agri_app/reminder/ui/homepage.dart';
import 'package:agri_app/shop/screens/cart_screen.dart';
import 'package:agri_app/shop/screens/edit_product_screen.dart';
import 'package:agri_app/shop/screens/orders_screen.dart';
import 'package:agri_app/login/loginscreen.dart';
import 'package:agri_app/login/welcome.dart';
import 'package:agri_app/shop/screens/products_overview_screen.dart';
import 'package:agri_app/shop/screens/user_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'reminder/global_bloc.dart';
import './picture/picturesearch.dart';
import './shop/providers/cart.dart';
import './shop/providers/orders.dart';
import './shop/providers/products.dart';
import 'dart:async';
import 'package:camera/camera.dart';
// import 'home.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}
// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        Provider<GlobalBloc>.value(
          value: GlobalBloc()
          ),
      ],
      child: MaterialApp(
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
          PictureSearch.id: (context) => PictureSearch(cameras),
          CartScreen.id: (context) => CartScreen(),
          OrdersScreen.id: (context) => OrdersScreen(),
          ProductsOverviewScreen.id: (context) => ProductsOverviewScreen(),
          UserProductsScreen.id: (context) => UserProductsScreen(),
          EditProductScreen.id: (context) => EditProductScreen(),
          HomePage.id:(context) => HomePage(),
        },
      ),
    );
  }
}
