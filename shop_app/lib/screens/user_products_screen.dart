import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './edit_product_screen.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(
            8,
          ),
          child: Consumer<Products>(
            builder: (_, productsData, child) => ListView.builder(
              itemBuilder: (_, i) => Column(
                children: [
                  UserProductItem(
                    id: productsData.items[i].id,
                    title: productsData.items[i].title,
                    imageUrl: productsData.items[i].imageUrl,
                  ),
                  Divider(),
                ],
              ),
              itemCount: productsData.items.length,
            ),
          ),
        ),
      ),
    );
  }
}

// final url = Uri.parse('https://flutter-update.firebaseio.com/products.json')
// http.post(url, ...)