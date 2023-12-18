import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';
import 'package:viajabara/kernel/blocs/blocs.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/modules/passangers/adapters/screens/passengers.dart';
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
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
    LatLng startPoint = LatLng(
      double.parse(widget.trip.trip!.stopOvers![0].address?.latitude ?? '0'),
      double.parse(widget.trip.trip!.stopOvers![0].address?.longitude ?? '0'),
    );
    
    LatLng endPoint = LatLng(
      double.parse(widget.trip.trip!.stopOvers!.last.address?.latitude ?? '0'),
      double.parse(widget.trip.trip!.stopOvers!.last.address?.longitude ?? '0'),
    );

    getRouteCoordinates(widget.trip.trip!.stopOvers!).then((route) {
      Polyline polyline = Polyline(
        polylineId: PolylineId('route'),
        color: Colors.blueAccent,
        points: route,
        width: 5,
      );

      for (var stopOver in widget.trip.trip!.stopOvers!) {
        LatLng stopOverPoint = LatLng(
          double.parse(stopOver.address?.latitude ?? '0'),
          double.parse(stopOver.address?.longitude ?? '0'),
        );
        _addMarker(stopOverPoint, 'stopOver_${stopOver.id}',
            'Parada: ${stopOver.sequence} + ${stopOver.address?.description!}');
      }
      setState(() {
        _polylines.add(polyline);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          centerCameraOnPolyline();
        });
      });
    });
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list,
      {double padding = 0.001}) {
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

  void centerCameraOnPolyline() {
    if (_polylines.isNotEmpty && mapController != null) {
      var points = _polylines.first.points;
      var bounds = boundsFromLatLngList(points);
      mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  @override
  void dispose() {
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

      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Salida: ${widget.trip.trip?.startTime}',
                      style: const TextStyle(
                          fontSize: 15.0, color: ColorsApp.text),
                    ),
                    Text(
                      'Llegada: ${Utils().sumarTiempo(widget.trip.trip!.startTime!, widget.trip.trip!.time!)}',
                      style: const TextStyle(
                          fontSize: 15.0, color: ColorsApp.text),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Passengers(trip: widget.trip)),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorsApp.primayColor),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.people, size: 18),
                      SizedBox(width: 10),
                      Text('Pasajeros', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              polylines: _polylines,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
          ),
        ],
      );
    });
  }

  Future<List<LatLng>> getRouteCoordinates(List<StopOver> stopOvers) async {
    Dio dio = Dio();

    if (stopOvers.length < 2) {
      return [];
    }
    LatLng start = LatLng(
      double.parse(stopOvers.first.address?.latitude ?? '0'),
      double.parse(stopOvers.first.address?.longitude ?? '0'),
    );
    LatLng end = LatLng(
      double.parse(stopOvers.last.address?.latitude ?? '0'),
      double.parse(stopOvers.last.address?.longitude ?? '0'),
    );

    String waypoints = "";
    for (int i = 1; i < stopOvers.length - 1; i++) {
      LatLng point = LatLng(
        double.parse(stopOvers[i].address?.latitude ?? '0'),
        double.parse(stopOvers[i].address?.longitude ?? '0'),
      );
      if (i != 1) waypoints += "|";
      waypoints += "${point.latitude},${point.longitude}";
    }

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&waypoints=$waypoints&key=AIzaSyB0kxKgHrX2s6oZWkAQ1Im28tkNHbeLXxQ";
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
      return [];
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

  void _addMarker(LatLng position, String id, String title) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: position,
          infoWindow: InfoWindow(title: title),
        ),
      );
    });
  }
}
