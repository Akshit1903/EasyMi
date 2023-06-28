import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

import '../widgets/order_item.dart';
import '../provider/orders.dart' show Orders;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetItems();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
          title: Text(
        'Your Orders',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black54,
        ),
      )),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) =>
                    (orderData.orders.length == 0)
                        ? Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.border_color_outlined,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "No orders!",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black54,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacementNamed('/'),
                                  child: Text("Shop now!"),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: orderData.orders.length,
                            itemBuilder: (ctx, i) =>
                                OrderItem(orderData.orders[i])),
              );
            }
          }
        },
      ),
    );
  }
}
