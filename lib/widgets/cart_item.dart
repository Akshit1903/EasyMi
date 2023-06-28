import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../provider/cart.dart';
import './cart_item_quantity.dart';

class CartItem extends StatelessWidget {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_in');
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageURL;
  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageURL,
  );
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) =>
          Provider.of<Cart>(context, listen: false).removeItem(productId),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the item from the cart?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text('No')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text('Yes'))
            ],
          ),
        );
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                // child: FittedBox(child: Text('\₹${price}')),
                child: imageURL != null
                    ? Image.network(
                        imageURL,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      )
                    : Text("P"),
              ),
              title: Text(title),
              subtitle: Text('$quantity X ₹${myFormat.format(price)}'),
              trailing: CartItemQuantity(productId),
            ),
          )),
    );
  }
}
