import 'package:flutter/material.dart';
import 'package:shop_app/screen/product_detail_screen.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'screen/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.greenAccent,
        fontFamily: 'Lato',
      ),
      home: ProductsOverViewScreen(),
      routes: {
        ProductDetailScreen.routeName:(ctx)=>ProductDetailScreen(),
      },
    );
  }
}


