import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/products_grid_favorite.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../provider/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: FittedBox(
            child: Text(
              'EasyMi: shopping made easier!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.black54,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Shop'),
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shopping_bag_sharp),
          title: Text('Cart'),
          onTap: () => Navigator.of(context).pushNamed(CartScreen.routeName),
        ),
        Divider(),
        ListTile(
          leading: Icon(CupertinoIcons.heart_fill),
          title: Text('Favorites'),
          onTap: () {
            if (ModalRoute.of(context).settings.name ==
                ProductsGridFavorite.routeName) {
              return;
            }
            Navigator.of(context)
                .pushReplacementNamed(ProductsGridFavorite.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Orders'),
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(OrdersScreen.routeName),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Products'),
          onTap: () => Navigator.of(context)
              .pushReplacementNamed(UserProductsScreen.routeName),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ],
    ));
  }
}
