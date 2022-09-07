import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart' show Orders;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final cartItems = cartData.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Chip(
                    label: Text(
                      '\$${cartData.totalAmount}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  FlatButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false)
                          .addOrder(cartItems, cartData.totalAmount);
                      cartData.clear();
                    },
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItem(
                cartItems[i].id,
                cartData.items.keys.toList()[i],
                cartItems[i].price,
                cartItems[i].quantity,
                cartItems[i].title,
              ),
              itemCount: cartData.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
