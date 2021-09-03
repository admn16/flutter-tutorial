import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../models/tab_page.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen({
    Key? key,
    required this.favoriteMeals,
  }) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<TabPage> _pages = [];

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      new TabPage(
        title: 'Categories',
        page: CategoriesScreen(),
      ),
      new TabPage(
        title: 'Favorites',
        page: FavoritesScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
      ),
    ];

    // TODO: implement initState
    super.initState();
  }

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
        // type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
