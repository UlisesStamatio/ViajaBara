import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';
import 'package:viajabara/kernel/blocs/blocs.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/providers/utils/utils.dart';

class MapScreen extends StatefulWidget {
  final DriverTrip trip;
  const MapScreen({Key? key, required this.trip}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;
  Set<Polyline> _polylines = {};
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
    LatLng startPoint = LatLng(
      double.parse(widget.trip.trip!.route!.startAddress?.latitude ?? '0'),
      double.parse(widget.trip.trip!.route!.startAddress?.longitude ?? '0'),
    );
    print('startPoint $startPoint');
    LatLng endPoint = LatLng(
      double.parse(widget.trip.trip!.route!.endAddress?.latitude ?? '0'),
      double.parse(widget.trip.trip!.route!.endAddress?.longitude ?? '0'),
    );
    print('endPoint $endPoint');

    getRouteCoordinates(startPoint, endPoint).then((route) {
      Polyline polyline = Polyline(
        polylineId: PolylineId('route'),
        color: Colors.blueAccent,
        points: route,
        width: 5,
      );
      setState(() {
        _polylines.add(polyline);
        centerCameraOnPolyline(); // Asegúrate de que esta función ajuste la cámara para mostrar toda la ruta
      });
    });
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list,
      {double padding = 0.14}) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    x0 = list.first.longitude - padding;
    x1 = list.first.longitude + padding;
    y0 = list.first.latitude - padding;
    y1 = list.first.latitude + padding;

    for (LatLng latLng in list) {
      if (latLng.longitude - padding < x0) x0 = latLng.longitude - padding;
      if (latLng.longitude + padding > x1) x1 = latLng.longitude + padding;
      if (latLng.latitude - padding < y0) y0 = latLng.latitude - padding;
      if (latLng.latitude + padding > y1) y1 = latLng.latitude + padding;
    }
    return LatLngBounds(southwest: LatLng(y0, x0), northeast: LatLng(y1, x1));
  }

  // Método para centrar la cámara en la polilínea
  void centerCameraOnPolyline() {
    if (_polylines.isNotEmpty && mapController != null) {
      var points = _polylines.first.points; 
      var bounds = boundsFromLatLngList(points);
      mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
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
          CameraPosition(target: state.lastKnownLocation!);

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Salida: ${widget.trip.trip?.startTime}',
                          style: const TextStyle(fontSize: 15.0, color: ColorsApp.text),
                        ),
                        Text(
                          'Llegada: ${Utils().sumarTiempo(widget.trip.trip!.startTime!, widget.trip.trip!.route!.time!)}',
                          style: const TextStyle(fontSize: 15.0, color: ColorsApp.text),
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
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                    centerCameraOnPolyline();
                  },
                  initialCameraPosition: initialCameraPosition,
                  polylines: _polylines,
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

  Future<List<LatLng>> getRouteCoordinates(LatLng l1, LatLng l2) async {
    Dio dio = Dio();
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyB0kxKgHrX2s6oZWkAQ1Im28tkNHbeLXxQ";

    try {
      Response response = await dio.get(url);
      List<LatLng> route = [];
      if (response.data["routes"].isNotEmpty) {
        String encodedPoly =
            response.data["routes"][0]["overview_polyline"]["points"];
        route = decodeEncodedPolyline(encodedPoly);
      }
      return route;
    } catch (e) {
      print(e);
      return []; // Retorna una lista vacía en caso de error
    }
  }

  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      points.add(p);
    }
    return points;
  }
}
