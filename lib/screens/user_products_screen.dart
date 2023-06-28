import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: const Text(
            'Your Products',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black54,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Consumer<Products>(
                        builder: (ctx, productsData, _) => Padding(
                          padding: EdgeInsets.all(8),
                          child: (productsData.items.length == 0)
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.browser_not_supported_outlined,
                                        size: 80,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "No products listed by you!",
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
                                  itemBuilder: (_, i) => Column(
                                    children: [
                                      UserProductItem(
                                        productsData.items[i].id,
                                        productsData.items[i].title,
                                        productsData.items[i].imageUrl,
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  itemCount: productsData.items.length,
                                ),
                        ),
                      ),
                    ),
        ));
  }
}
