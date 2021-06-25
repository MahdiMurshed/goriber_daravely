import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future _ordersFuture;
  Future _obtainedFuture() {
    return Provider.of<Order>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    _ordersFuture = _obtainedFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building orders');
    //final orderdata = Provider.of<Order>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (data.error != null) {
                //error handle
                return Center(
                  child: Text('Error occured'),
                );
              } else {
                return Consumer<Order>(
                  builder: (ctx, data, ch) => ListView.builder(
                    itemCount: data.orders.length,
                    itemBuilder: (ctx, i) => OrderedProduct(data.orders[i]),
                  ),
                );
              }
            }
          },
        ));
  }
}
