import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart' as CI;

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
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
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                var cartItem = cart.items.values.toList()[i];
                var productId = cart.items.keys.toList()[i];

                return CI.CartItem(
                  id: cartItem.id,
                  productId: productId,
                  price: cartItem.price,
                  quantity: cartItem.quantity,
                  title: cartItem.title,
                );
              },
              itemCount: cart.items.length,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _loading = false;

  Future<void> _orderNow(BuildContext ctx) async {
    final cart = Provider.of<Cart>(ctx, listen: false);
    final theme = Theme.of(context);

    try {
      setState(() {
        _loading = true;
      });

      await Provider.of<Orders>(
        context,
        listen: false,
      ).addOrder(
        cart.items.values.toList(),
        cart.totalAmount,
      );

      cart.clear();
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Ordered successfully!'),
          backgroundColor: theme.accentColor,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Failed to submit your order!'),
          backgroundColor: theme.errorColor,
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.cart.totalAmount == 0 || _loading
          ? null
          : () => _orderNow(context),
      child: _loading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
    );
  }
}
