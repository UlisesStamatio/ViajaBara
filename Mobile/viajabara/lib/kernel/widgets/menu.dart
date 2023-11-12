import 'package:flutter/material.dart';
import 'package:viajabara/config/navigation/history_navigation%20.dart';
import 'package:viajabara/config/navigation/profile_navigation.dart';
import 'package:viajabara/config/navigation/trips_navigation.dart';
import 'package:viajabara/kernel/widgets/custom_bottom_navigation_tab.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectIndex = 0;
  bool _showIndexedStack = true;

  // final homeNavigatorKey = GlobalKey<NavigatorState>();
  // final accountNavigatorKey = GlobalKey<NavigatorState>();
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
      if (index == 3) {
        _showIndexedStack = false;
        Navigator.pushReplacementNamed(context, "/login");
      }
      print(_selectIndex);
      print(_showIndexedStack);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showIndexedStack
          ? IndexedStack(
              index: _selectIndex,
              children: [
                const TripsNavigation(),
                const HistoryNavigation(),
                const ProfileNavigation(),
                Container(),
              ],
            )
          : null,
      bottomNavigationBar: CustomBottomNavigationTab(
          selectedIndex: _selectIndex, onItemTapped: _onItemTapped),
    );
  }
}
