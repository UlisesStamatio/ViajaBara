import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viajabara/kernel/colors/colors_app.dart';

class CustomBottomNavigationTab extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationTab(
      {Key? key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bus), label: 'Viajes'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled), label: 'Perfil')
      ],
      currentIndex: selectedIndex,
      selectedItemColor: ColorsApp.primayColor,
      onTap: onItemTapped,
    );
  }
}
