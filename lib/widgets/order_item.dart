import 'package:flutter/material.dart';
import 'package:shop_app/providers/order.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderedProduct extends StatefulWidget {
  final OrderItem orders;
  OrderedProduct(this.orders);

  @override
  _OrderedProductState createState() => _OrderedProductState();
}

class _OrderedProductState extends State<OrderedProduct> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orders.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.orders.datetime)),
            trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              height: min(widget.orders.products.length * 20.0 + 15, 100),
              child: ListView(
                children: widget.orders.products
                    .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('${e.quantity} x ${e.price}',style: TextStyle(fontSize: 18,color: Colors.grey),)
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
