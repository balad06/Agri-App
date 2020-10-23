import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import 'package:agri_app/widgets/drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const id = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft:Radius.circular(27),
              bottomRight:Radius.circular(27),
            ),
          ),
        ),
        drawer: MainDrawer(),
        body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
        ),
      ),
    );
  }
}
