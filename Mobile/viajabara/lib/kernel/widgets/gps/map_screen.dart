import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viajabara/kernel/blocs/blocs.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      if (state.lastKnownLocation == null) {
        return Card(
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cargando mapa...",
                  style: TextStyle(color: ColorsApp.text),
                ),
              ],
            ),
          ),
        );
      }

      final CameraPosition initialCameraPosition =
          CameraPosition(target: state.lastKnownLocation!, zoom: 15);

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: ColorsApp.whiteColor,
              pinned: true, // Mantener el encabezado "sticky"
              floating:
                  false, // No permitir que aparezca de nuevo cuando se desplaza hacia arriba
              flexibleSpace: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Salida: 8:30 a.m.",
                          style:
                              TextStyle(fontSize: 15.0, color: ColorsApp.text),
                        ),
                        Text(
                          "Llegada: 12:30 p.m.",
                          style:
                              TextStyle(fontSize: 15.0, color: ColorsApp.text),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/passengers');
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorsApp.primayColor)),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Pasajeros',
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  initialCameraPosition: initialCameraPosition,
                  compassEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: false,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
