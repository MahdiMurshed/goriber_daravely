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
      body: Column(
        children:[ 
          Container(
          height: 300,
          width: double.infinity,
          child: Image.network(
            loadedItem.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10,),
        Text(loadedItem.price.toString(),style: TextStyle(color: Colors.grey,fontSize: 20),),
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Text(
            loadedItem.description,
            textAlign: TextAlign.center,
            softWrap: true,
            ),
        )

        ]
      ),
    );
  }
}
