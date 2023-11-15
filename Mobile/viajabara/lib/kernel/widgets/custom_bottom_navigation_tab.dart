import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

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
            icon: Icon(CupertinoIcons.bus),
            label: 'Viajar',
            backgroundColor: ColorsApp.whiteColor),
        BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
            backgroundColor: ColorsApp.whiteColor),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle_fill),
            label: 'Perfil',
            backgroundColor: ColorsApp.whiteColor),
        BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Cerrar sesión',
            backgroundColor: ColorsApp.whiteColor),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: ColorsApp.dangerColor,
      onTap: onItemTapped,
      unselectedItemColor: ColorsApp.text,
    );
  }
}
