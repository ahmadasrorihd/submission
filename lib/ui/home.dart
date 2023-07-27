import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/ui/favorite.dart';
import 'package:restaurant_api/ui/restaurant_list.dart';
import 'package:restaurant_api/ui/setting.dart';

import '../providers/api_provider.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  void initState() {
    super.initState();

    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.getAllRestaurant();
  }

  static const List<Widget> widgetOption = <Widget>[
    RestaurantList(),
    Favorite(),
    Setting(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: widgetOption.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.deepOrange),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
              backgroundColor: Colors.deepOrange),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
              backgroundColor: Colors.deepOrange)
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
