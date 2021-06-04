import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum FilterOption { Favorite, All }

class ProductsOverViewScreen extends StatefulWidget {
  @override
  _ProductsOverViewScreenState createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var showFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              onSelected: (FilterOption slv) {
                if (slv == FilterOption.Favorite) {
                  setState(() {
                                      showFav = true;
                                    });
                } else {
                  setState(() {
                                      showFav = false;
                                    });
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: FilterOption.Favorite,
                    ),
                    PopupMenuItem(
                      child: Text('Show ALl'),
                      value: FilterOption.All,
                    ),
                  ]),
                  Consumer<Cart>(
                    builder: (_,cartData,ch)=> Badge(
                      child: ch,
                      value: cartData.itemCount.toString(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: (){},
                      ),
                  )
        ],
      ),
      body: ProductGrid(showFav),
    );
  }
}
