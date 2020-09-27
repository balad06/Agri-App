import 'package:agri_app/alarm/screens/reminderpage.dart';
import 'package:agri_app/alarmm/home.dart';
import 'package:agri_app/pages/picturesearch.dart';
import 'package:agri_app/shop/screens/products_overview_screen.dart';
import 'package:agri_app/shop/screens/user_products_screen.dart';
import 'package:flutter/material.dart';

import '../shop/screens/orders_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildTile(String name, IconData icon, Function onTap) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 35.0,
        child: InkWell(
          onTap: onTap,
          child: Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.w300, color: Color(0xFF707070)),
          ),
        ),
      ),
    );
  }

  Widget subTile(String name, Function onTap) {
    return Padding(
      padding: EdgeInsets.only(left: 30.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 30.0,
          child: InkWell(
            onTap: onTap,
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Color(0xFF707070),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Colors.black87,
          child: Text(
            'Welcome ',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).primaryColor),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        buildTile('Plant Search', Icons.camera, () {
          Navigator.of(context).pushReplacementNamed(PictureSearch.id);
        }),
        buildTile('Shop', Icons.shop, () {
          Navigator.of(context).pushReplacementNamed(ProductsOverviewScreen.id);
        }),
        subTile(
          'Orders',
          () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.id);
          },
        ),
        subTile(
          'Edit Products',
          () {
            Navigator.of(context).pushReplacementNamed(UserProductsScreen.id);
          },
        ),
        buildTile('Alarm', Icons.alarm, () {
          Navigator.of(context).pushReplacementNamed(ReminderPage.id);
        }),
        buildTile('Alarm', Icons.alarm, () {
          Navigator.of(context).pushReplacementNamed(Home.id);
        }),
         buildTile('Exit', Icons.shop, () {
          // Navigator.of(context).pushReplacementNamed(ProductsOverviewScreen.id);
        }),
      ]),
    );
  }
}
