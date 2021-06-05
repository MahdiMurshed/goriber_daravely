import 'package:flutter/material.dart';

class CartProduct extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  CartProduct({
    this.id,this.price,this.quantity,this.title
  });

  

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child:ListTile(
          leading: FittedBox(child: CircleAvatar(child: Text('\$$price'),)),
          title: Text(title),
          subtitle: Text('Total :\$${(price*quantity)}'),
          trailing: Text('x $quantity '),
        ) ,
        ),
      
    );
  }
}