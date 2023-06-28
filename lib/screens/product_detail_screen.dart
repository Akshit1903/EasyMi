import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../widgets/badge.dart';
import './cart_screen.dart';
import '../provider/products.dart';
import '../provider/product.dart';
import '../provider/auth.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    // final product = Provider.of<Product>(
    //   context,
    //   listen: false,
    // );
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context);
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              Consumer<Cart>(
                builder: (_, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString(),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(CartScreen.routeName),
                ),
              )
            ],
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(255, 103, 0, 0.5)),
                child: Text(
                  loadedProduct.title,
                  style: TextStyle(),
                ),
              ),
              background: Hero(
                tag: loadedProduct.id,
                child: Container(
                  color: Colors.white,
                  child: Image.network(
                    loadedProduct.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Xiaomi',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loadedProduct.title,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '\₹${loadedProduct.price}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      loadedProduct.description,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Similar This',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Image.network(
                              loadedProduct.imageUrl,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: FavoriteButton(loadedProduct, authData),

              // Icon(
              //   CupertinoIcons.heart,
              //   size: 30,
              //   color: Colors.grey,
              // ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Buy ${loadedProduct.title}?"),
                        content: Text(
                            "Would you like to add this item to the cart?"),
                        actions: [
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              cart.addItems(
                                  loadedProduct.id,
                                  loadedProduct.price,
                                  loadedProduct.title,
                                  loadedProduct.imageUrl);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 103, 0, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_outlined,
                        color: Colors.black,
                      ),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  FavoriteButton(this.product, this.authData);

  Product product;
  Auth authData;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isLoading
          ? CircularProgressIndicator()
          : Icon(
              widget.product.isFavorite ? Icons.favorite : CupertinoIcons.heart,
              size: 30,
              color: widget.product.isFavorite
                  ? Color.fromRGBO(255, 103, 0, 1)
                  : Colors.grey,
            ),
      color: Theme.of(context).accentColor,
      onPressed: () async {
        setState(() {
          _isLoading = true;
          // print(_isLoading);
        });
        await widget.product.toggleFavoriteStatus(
            widget.product.id, widget.authData.token, widget.authData.userId);
        setState(() {
          _isLoading = false;
          // print(_isLoading);
        });
      },
    );
  }
}
