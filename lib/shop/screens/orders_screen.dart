import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const id = 'Order-Screen';
  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('You\'re Orders'),
        ),
        drawer: MainDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetechAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(child: Text('Error'));
              } else {
                return Consumer<Orders>(builder:(ctx,orderData,child) => ListView.builder(
                    itemBuilder: (ctx, i) => OrderItems(orderData.orders[i]),
                    itemCount: orderData.orders.length),);
              }
            }
          },
        ));
  }
}
