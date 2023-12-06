import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';
import 'package:viajabara/kernel/blocs/gps/gps_bloc.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/gps/gps_access_screen.dart';
import 'package:viajabara/kernel/widgets/gps/map_screen.dart';
import 'package:viajabara/modules/trips/adapters/screens/trips.dart';
import 'package:viajabara/providers/driver_provider.dart';

class Traveling extends StatefulWidget {
  final DriverTrip trip;
  const Traveling({Key? key, required this.trip}) : super(key: key);

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
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            if (state.isAllGranted) {
              return _buildSlidingUpPanelWithMap();
            } else {
              return const GpsAccessScreen();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSlidingUpPanelWithMap() {
    double screenHeight = MediaQuery.of(context).size.height;
    double panelMaxHeight = screenHeight * 0.4;
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return SlidingUpPanel(
      panel: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.black, size: 40),
                const SizedBox(width: 8),
                Text(
                    'Origen: ${widget.trip.trip?.route?.startAddress?.description}',
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.flight_land, color: Colors.black, size: 40),
                const SizedBox(width: 8),
                Text(
                    'Destino: ${widget.trip.trip?.route?.endAddress?.description}',
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Icon(Icons.timeline, color: Colors.black, size: 40),
                SizedBox(width: 8),
                Text('Paradas: 1', style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                bool success =
                    await DriverProvider().updateTripStatus(widget.trip.id!, 3);
                if (success) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Trips()),
                  );
                }
              },
              icon: const Icon(CupertinoIcons.bus, color: Colors.white),
              label: const Text('Finalizar viaje'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50), // set the size
              ),
            ),
          ],
        ),
      ),
      collapsed: Container(
        decoration:
            BoxDecoration(color: Colors.redAccent, borderRadius: radius),
        child: Center(
          child: Container(
            width: 200.0,
            height: 5.0,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
        ),
      ),
      body: MapScreen(trip: widget.trip), // Aquí se coloca MapScreen
      borderRadius: radius,
      minHeight: 40,
      maxHeight: panelMaxHeight,
    );
  }
}
