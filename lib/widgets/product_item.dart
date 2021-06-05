import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final pr = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetailScreen.routeName, arguments: pr.id);
            },
            child: Image.network(
              pr.imageUrl,
              fit: BoxFit.cover,
            )),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(pr.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              pr.toggleFav();
            },
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            pr.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(pr.id, pr.price , pr.title);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
