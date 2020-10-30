import 'dart:async';
import 'package:agri_app/account/profilpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login/auth.dart';
import 'reminder/ui/homepage.dart';
import 'shop/screens/cart_screen.dart';
import 'shop/screens/orders_screen.dart';
import 'login/loginscreen.dart';
import 'login/welcome.dart';
import 'reminder/global_bloc.dart';
import './picture/picturesearch.dart';
import './shop/providers/cart.dart';
import './shop/providers/products.dart';
import 'package:firebase_core/firebase_core.dart';
import 'shop/screens/edit_product_screen.dart';
import 'shop/screens/product_detail_screen.dart';
import 'shop/providers/orders.dart';
import 'shop/screens/products_overview_screen.dart';
import 'shop/screens/user_products_screen.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp();

  runApp(new MyApp());
}

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
          value: Auth(),
        ),
        ProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(auth.token, auth.userId,
              previousOrders == null ? [] : previousOrders.orders),
        ),
        Provider<GlobalBloc>.value(value: GlobalBloc()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          title: 'Agri',
          theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            accentColor: Colors.blueAccent,
          ),
          home: auth.isAuth
              ? PictureSearch()
              : FutureBuilder(
                  future: auth.tryautoLogin(),
                  builder: (ctx, authResultSnapShots) =>
                      authResultSnapShots.connectionState ==
                              ConnectionState.waiting
                          ? WelcomePage()
                          : LoginPage(),
                ),
          routes: {
            LoginPage.id: (context) => LoginPage(),
            PictureSearch.id: (context) => PictureSearch(),
            CartScreen.id: (context) => CartScreen(),
            OrdersScreen.id: (context) => OrdersScreen(),
            ProductsOverviewScreen.id: (context) => ProductsOverviewScreen(),
            UserProductsScreen.id: (context) => UserProductsScreen(),
            EditProductScreen.id: (context) => EditProductScreen(),
            HomePage.id: (context) => HomePage(),
            ProductDetailScreen.id: (context) => ProductDetailScreen(),
            ProfileView.id: (context) => ProfileView(),
          },
        ),
      ),
    );
  }
}
