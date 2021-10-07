import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/order_screen.dart';
import './screens/auth_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(
            token: '',
            productItems: [],
            user: '',
          ),
          update: (ctx, authModel, previousProducts) => Products(
            // authModel.token as String,
            // previousProducts == null ? [] : previousProducts.items,
            token: authModel.token,
            productItems:
                previousProducts == null ? [] : previousProducts.items,
            user: authModel.userId,
          ),
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        // ChangeNotifierProvider(create: (_) => Orders()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(
            authToken: null,
            orderItems: [],
            userId: null,
          ),
          update: (ctx, authModel, previousOrders) => Orders(
            authToken: authModel.token,
            orderItems: previousOrders == null ? [] : previousOrders.orders,
            userId: authModel.userId,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
