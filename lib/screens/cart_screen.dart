import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../provider/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../provider/orders.dart';
import './orders_screen.dart';
import '../widgets/customer_form.dart';

class CartScreen extends StatelessWidget {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_in');
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black54,
          ),
        ),
      ),
      body: Column(
        children: [
          Card(
            elevation: 15,
            margin: EdgeInsets.all(15),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '\₹${myFormat.format(cart.totalAmount)}',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          CustomerForm(),
          SizedBox(height: 10),
          if (cart.items.length == 0)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Cart Empty!",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black54,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(OrdersScreen.routeName),
                    child: Text("Track Orders"),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].imageUrl,
              ),
              itemCount: cart.items.length,
            ),
          ),
          OrderButton()
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return FlatButton(
      child: _isLoading
          ? CircularProgressIndicator()
          : InkWell(
              onTap: (_isLoading || cart.totalAmount <= 0)
                  ? () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Cart Empty!"),
                              content: Text(
                                  "Please add items to cart before placing order!"),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  : () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Place Order?"),
                            content: Text(
                                "Would you like to place order for the items in you cart?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                  child: Text("Yes"),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await Provider.of<Orders>(context,
                                            listen: false)
                                        .addOrders(
                                      cart.items.values.toList(),
                                      cart.totalAmount,
                                    );
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    cart.clear();
                                  })
                            ],
                          );
                        },
                      );
                    },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 103, 0, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_sharp,
                      color: Colors.black,
                    ),
                    Text(
                      "Order Now!",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      textColor: Theme.of(context).primaryColor,
    );
  }
}
