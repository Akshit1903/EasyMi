import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartItemQuantity extends StatefulWidget {
  String cartID;
  CartItemQuantity(this.cartID);
  @override
  State<CartItemQuantity> createState() => _CartItemQuantityState();
}

class _CartItemQuantityState extends State<CartItemQuantity> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      width: 120,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        cart.getQuantity(widget.cartID) != 0
            ? IconButton(
                icon: new Icon(Icons.remove),
                onPressed: () {
                  if (cart.getQuantity(widget.cartID) == 1) {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text(
                            'Do you want to remove the item from the cart?'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text('No')),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                setState(() =>
                                    {cart.removeSingleItem(widget.cartID)});
                              },
                              child: Text('OK'))
                        ],
                      ),
                    );
                  } else {
                    setState(() => {cart.removeSingleItem(widget.cartID)});
                  }
                })
            : Container(),
        Text("${cart.getQuantity(widget.cartID)}"),
        IconButton(
            icon: new Icon(Icons.add),
            onPressed: () => setState(() => {
                  cart.addSingleItem(widget.cartID),
                })),
      ]),
    );
  }
}
