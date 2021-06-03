import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final loadedItem = Provider.of<Products>(context).getItemById(id);
    //...State management
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedItem.title),
        centerTitle: true,
      ),
    );
  }
}
