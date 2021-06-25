import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    print(cart.totalAmount);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    label: Text(cart.totalAmount.toString()),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart, order: order)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (ctx, i) => CartProduct(
                        id: cart.items.values.toList()[i].id,
                        productId: cart.items.keys.toList()[i],
                        title: cart.items.values.toList()[i].title,
                        price: cart.items.values.toList()[i].price,
                        quantity: cart.items.values.toList()[i].quantity ?? 0,
                      )))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
    @required this.order,
  }) : super(key: key);

  final Cart cart;
  final Order order;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cart.totalAmount <= 0 || isLoading)
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });
              await widget.order.addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount);
              setState(() {
                isLoading = false;
              });
              widget.cart.clear();
            },
      child: isLoading ? CircularProgressIndicator() : Text('Order'),
      color: Theme.of(context).primaryColor,
    );
  }
}
