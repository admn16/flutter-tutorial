import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../models/tab_page.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<TabPage> _pages = [
    new TabPage(
      title: 'Categories',
      page: CategoriesScreen(),
    ),
    new TabPage(
      title: 'Favorites',
      page: FavoritesScreen(),
    ),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedPage = _pages[_selectedPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPage.title),
      ),
      body: selectedPage.page,
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _selectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
