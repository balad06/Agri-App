import 'package:agri_app/account/profilpage.dart';
import 'package:agri_app/picture/picturesearch.dart';
import 'package:agri_app/reminder/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:agri_app/shop/screens/products_overview_screen.dart';
import '../shop/screens/orders_screen.dart';
import 'package:agri_app/shop/screens/user_products_screen.dart';
import 'package:agri_app/login/auth.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool showmore = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          DrawerHeader(
            child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/agrilogo1.jpg",
                )),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.camera,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Picture Search',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(PictureSearch.id);
            },
          ),
          SizedBox(
            height: 13,
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Shop',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewScreen.id);
            },
            trailing: IconButton(
              color: Colors.blueAccent,
              icon: showmore
                  ? Icon(
                      Icons.arrow_back,
                    )
                  : Icon(Icons.arrow_drop_down),
              onPressed: () {
                setState(() {
                  showmore = !showmore;
                });
              },
            ),
          ),
          showmore
              ? ListTile(
                  leading: Icon(
                    Icons.bookmark,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(OrdersScreen.id);
                  },
                )
              : Container(),
          showmore
              ? ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    'Edit Products',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(UserProductsScreen.id);
                  },
                )
              : Container(),
          SizedBox(
            height: 13,
          ),
          ListTile(
            leading: Icon(
              Icons.alarm,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Reminder',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomePage.id);
            },
          ),
          SizedBox(
            height: 13,
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Account',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProfileView.id);
            },
          ),
          SizedBox(
            height: 13,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          SizedBox(
            height: 13,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 25,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Center(
                child: Text(
                  'v1.0.1',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
