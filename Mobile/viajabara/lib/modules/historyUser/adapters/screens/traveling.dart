import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/blocs/gps/gps_bloc.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/gps/gps_access_screen.dart';
import 'package:viajabara/kernel/widgets/gps/map_screen_user.dart';

class TravelingUser extends StatefulWidget {
  const TravelingUser({super.key});

  @override
  State<TravelingUser> createState() => _TravelingState();
}

class _TravelingState extends State<TravelingUser> {
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
        foregroundColor: ColorsApp.muted,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.asset(StuffApp.logoViajabara, height: 35),
          ),
        ],
        backgroundColor: ColorsApp.whiteColor,
        shadowColor: ColorsApp.blackColor,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsApp.primayColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SvgPicture.asset(
              StuffApp.bgGeneral,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(child: BlocBuilder<GpsBloc, GpsState>(
              builder: (context, state) {
                print('state $state');

                return state.isAllGranted
                    ? const MapScreenUser()
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
