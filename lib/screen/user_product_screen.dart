//3.For showing all product of user

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screen/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProduct extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshedProduct(BuildContext context) async {
    await Provider.of<Products>(context,listen: false).fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: ()=>_refreshedProduct(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: products.items.length,
              itemBuilder: (_, i) => Column(
                    children: [
                      UserProductItem(products.items[i].id,
                          products.items[i].title, products.items[i].imageUrl),
                      Divider(),
                    ],
                  )),
        ),
      ),
    );
  }
}
