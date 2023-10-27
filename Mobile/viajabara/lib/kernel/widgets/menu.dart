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
  // final homeNavigatorKey = GlobalKey<NavigatorState>();
  // final accountNavigatorKey = GlobalKey<NavigatorState>();
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectIndex,
        children: const [
          TripsNavigation(),
          HistoryNavigation(),
          ProfileNavigation()
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationTab(
          selectedIndex: _selectIndex, onItemTapped: _onItemTapped),
    );
  }
}
