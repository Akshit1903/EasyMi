import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../provider/product.dart';
import '../provider/cart.dart';
// import '../provider/auth.dart';

class ProductItem extends StatefulWidget {
  // final String id;
  // final String title;
  // final String imgUrl;
  // ProductItem(
  //   this.id,
  //   this.title,
  //   this.imgUrl,
  // );

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Widget build(BuildContext context) {
    // final authData = Provider.of<Auth>(context);
    final product = Provider.of<Product>(
      context,
    );
    final cart = Provider.of<Cart>(context, listen: false);
    return GridTile(
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
        child: Hero(
          tag: product.id,
          child: FadeInImage(
            placeholder: AssetImage('assets/images/product-placeholder.png'),
            image: NetworkImage(
              product.imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        // leading: Consumer<Product>(
        //   builder: (ctx, product, _) => FavoriteButton(product, authData),
        // ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          color: Theme.of(context).accentColor,
          onPressed: () {
            cart.addItems(
                product.id, product.price, product.title, product.imageUrl);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Product added to cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () => cart.removeItem(product.id),
                  )),
            );
          },
        ),
      ),
    );
  }
}
