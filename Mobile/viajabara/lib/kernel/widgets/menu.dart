import 'package:flutter/material.dart';
import 'package:viajabara/config/navigation/driver/history_navigation_driver.dart';
import 'package:viajabara/config/navigation/driver/trips_navigation_driver.dart';
import 'package:viajabara/config/navigation/profile_navigation.dart';
import 'package:viajabara/config/navigation/user/history_navigation.dart';
import 'package:viajabara/config/navigation/user/trips_navigation.dart';
import 'package:viajabara/kernel/widgets/custom_bottom_navigation_tab.dart';
import 'package:viajabara/kernel/widgets/custom_bottom_navigation_tab_driver.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectIndex = 0;
  bool _showIndexedStack = true;
  String email = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map;
      if (arguments != null) {
        setState(() {
          email = arguments['email'];
        });
      }
    });
  }

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
          ? email == "20203tn159@utez.edu.mx"
              ? IndexedStack(
                  index: _selectIndex,
                  children: [
                    const TripsNavigationDriver(),
                    const HistoryNavigationDriver(),
                    const ProfileNavigation(),
                    Container(),
                  ],
                )
              : IndexedStack(
                  index: _selectIndex,
                  children: [
                    const TripsNavigation(),
                    const HistoryNavigation(),
                    const ProfileNavigation(),
                    Container(),
                  ],
                )
          : null,
      bottomNavigationBar: email == "20203tn159@utez.edu.mx"
          ? CustomBottomNavigationTabDriver(
              selectedIndex: _selectIndex, onItemTapped: _onItemTapped)
          : CustomBottomNavigationTab(
              selectedIndex: _selectIndex, onItemTapped: _onItemTapped),
    );
  }
}
