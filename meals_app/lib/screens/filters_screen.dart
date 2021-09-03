import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  Widget _buildSwitchListTile(
      {required String title,
      required String description,
      required bool currentValue,
      required Function(bool) updateValue}) {
    return SwitchListTile(
      title: Text(
        title,
      ),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                    title: 'Gluten-free',
                    description: 'Only includes gluten-free meals',
                    currentValue: _glutenFree,
                    updateValue: (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    title: 'Vegetarian',
                    description: 'Only includes vegetarian meals',
                    currentValue: _vegetarian,
                    updateValue: (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    title: 'Vegan',
                    description: 'Only includes vegan meals',
                    currentValue: _vegan,
                    updateValue: (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    title: 'Lactose-free',
                    description: 'Only includes lactose-free meals',
                    currentValue: _lactoseFree,
                    updateValue: (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
