import 'package:flutter/material.dart';
import 'package:viajabara/config/navigation/driver/history_navigation_driver.dart';
import 'package:viajabara/config/navigation/driver/trips_navigation_driver.dart';
import 'package:viajabara/config/navigation/user/history_navigation.dart';
import 'package:viajabara/config/navigation/user/trips_navigation.dart';
import 'package:viajabara/kernel/widgets/custom_bottom_navigation_tab.dart';
import 'package:viajabara/kernel/widgets/custom_bottom_navigation_tab_driver.dart';
import 'package:viajabara/modules/profile/adapters/screens/profile.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectIndex = 0;
  bool _showIndexedStack = true;
  String rol = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    if (arguments != null) {
      setState(() {
        rol = arguments['rol'];
      });
    }
    print(rol);
  }

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
      body: _showIndexedStack
          ? rol == 'ADMIN' || rol == 'COND'
              ? IndexedStack(
                  index: _selectIndex,
                  children: [
                    const TripsNavigationDriver(),
                    const HistoryNavigationDriver(),
                    const Profile(),
                    Container(),
                  ],
                )
              : IndexedStack(
                  index: _selectIndex,
                  children: [
                    const TripsNavigation(),
                    const HistoryNavigation(),
                    const Profile(),
                    Container(),
                  ],
                )
          : null,
      bottomNavigationBar: rol == "ADMIN" || rol == 'COND'
          ? CustomBottomNavigationTabDriver(
              selectedIndex: _selectIndex, onItemTapped: _onItemTapped)
          : CustomBottomNavigationTab(
              selectedIndex: _selectIndex, onItemTapped: _onItemTapped),
    );
  }
}
