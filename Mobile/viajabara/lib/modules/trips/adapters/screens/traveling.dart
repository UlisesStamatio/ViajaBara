import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viajabara/config/navigation/general_mechanisms_navigation.dart';
import 'package:viajabara/kernel/blocs/gps/gps_bloc.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/widgets/gps/gps_access_screen.dart';
import 'package:viajabara/kernel/widgets/gps/map_screen.dart';

class Traveling extends StatefulWidget {
  const Traveling({super.key});

  @override
  State<Traveling> createState() => _TravelingState();
}

class _TravelingState extends State<Traveling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Viajando',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        foregroundColor: ColorsApp.muted2,
        actions: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/images/viajabara_logo_purple.png',
              width: 100,
              height: 50,
              color: ColorsApp.muted2,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: ColorsApp.primayColor),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GeneralMechanismsNavigation()),
                (route) => false,
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsApp.primayColor),
          onPressed: () {
            Navigator.of(context).pop(); // Regresar a la página anterior
          },
        ),
        backgroundColor: ColorsApp.whiteColor,
        shadowColor: ColorsApp.blackColor,
        elevation: 2,
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: BlocBuilder<GpsBloc, GpsState>(
                  builder: (context, state) {
                    print('state $state');

                    return state.isAllGranted
                        ? const MapScreen()
                        : const GpsAccessScreen();
                  },
                )
                // child: CheckPermissionLocalization(),
                ),
          ],
        ),
      ),
    );
  }
}
