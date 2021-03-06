import 'package:agri_app/widgets/appbar.dart';
import 'package:agri_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const id = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isinit = true;
  var _isLoading = false;
  Future<void> _refreshOrders() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Orders>(context, listen: false)
        .fetechAndSetOrders()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context).fetechAndSetOrders().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: Topbar('Orders', []),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : orderData.orders.length == 0
              ? LayoutBuilder(
                  builder: (ctx, constraints) {
                    return Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'No Orders yet!',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                              height: constraints.maxHeight * 0.7,
                              child: Image.asset(
                                'assets/images/waiting.png',
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                    );
                  },
                )
              : RefreshIndicator(
                  onRefresh: () => _refreshOrders(),
                  child: Column(
                    children: [
                      Text(
                        'Orders will be delivered to you\'re account address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: orderData.orders.length,
                          itemBuilder: (ctx, i) =>
                              OrderItem(orderData.orders[i]),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
