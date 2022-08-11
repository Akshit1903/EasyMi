import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './cart_screen.dart';
import '../provider/cart.dart';
import '../widgets/products_grid.dart';
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
  var _showOnlyFavorites = false;
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
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
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
        title: Text('Welcome to EasyMi'),
        actions: [
          // PopupMenuButton(
          //   onSelected: (FilterOptions selectedValue) {
          //     setState(() {
          //       if (selectedValue == FilterOptions.Favorites) {
          //         _showOnlyFavorites = true;
          //       } else {
          //         _showOnlyFavorites = false;
          //       }
          //     });
          //   },
          //   icon: Icon(Icons.more_vert),
          //   itemBuilder: (_) => [
          //     PopupMenuItem(
          //       child: Text('Only Favorites'),
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
                Expanded(child: ProductsGrid(_showOnlyFavorites)),
              ],
            ),
    );
  }
}
