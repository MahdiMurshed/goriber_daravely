import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartProduct extends StatelessWidget {
  final String id;
  final double price;
  final String productId;
  final int quantity;
  final String title;
  CartProduct({this.id,this.productId, this.price, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (d) {
        cart.removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: FittedBox(
                child: CircleAvatar(
              child: Text('\$$price'),
            )),
            title: Text(title),
            subtitle: Text('Total :\$${(price * quantity)}'),
            trailing: Text('x $quantity '),
          ),
        ),
      ),
    );
  }
}
