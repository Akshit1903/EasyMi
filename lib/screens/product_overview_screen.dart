import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './cart_screen.dart';
import '../provider/cart.dart';
import '../widgets/products_grid.dart';
import 'products_grid_favorite.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';
import '../provider/products.dart';
import '../widgets/quick_mi.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Welcome to EasyMi',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black54,
          ),
        ),
        actions: [
          // PopupMenuButton(
          //   onSelected: (FilterOptions selectedValue) {
          //     // setState(() {
          //     //   if (selectedValue == FilterOptions.Favorites) {
          //     //     setState(() {
          //     //       _showOnlyFavorites = true;
          //     //     });
          //     //   } else {
          //     //     setState(() {
          //     //       _showOnlyFavorites = false;
          //     //     });
          //     //   }
          //     // });
          //     if (selectedValue == FilterOptions.Favorites) {
          //       Navigator.of(context).pushNamed(ProductsGridFavorite.routeName);
          //     }
          //   },
          //   icon: Icon(Icons.more_vert),
          //   itemBuilder: (_) => [
          //     PopupMenuItem(
          //       child: Text('Show Favorites'),
          //       value: FilterOptions.Favorites,
          //     ),
          //     PopupMenuItem(
          //       child: Text('Show all'),
          //       value: FilterOptions.All,
          //     ),
          //   ],
          // ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          )
        ],
      ),
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                QuickMi(context),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: ProductsGrid()),
              ],
            ),
    );
  }
}
