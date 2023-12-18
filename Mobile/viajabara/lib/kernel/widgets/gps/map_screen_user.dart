import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viajabara/domain/entities/user/user_history_trips.dart';
import 'package:viajabara/kernel/blocs/blocs.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/widgets/details/details_map.dart';

class MapScreenUser extends StatefulWidget {
  final HistoryClientTrip trip;
  MapScreenUser({Key? key, required this.trip}) : super(key: key);

  @override
  State<MapScreenUser> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenUser> {
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
      double.parse(widget.trip.startAddress?.latitude ?? '0'),
      double.parse(widget.trip.startAddress?.longitude ?? '0'),
    );

    LatLng endPoint = LatLng(
      double.parse(widget.trip.endAddress?.latitude ?? '0'),
      double.parse(widget.trip.endAddress?.longitude ?? '0'),
    );

    _addMarker(startPoint, 'startPoint',
        'Parada inicial: ${widget.trip.startAddress?.description}');
    _addMarker(endPoint, 'endPoint',
        'Parada final: ${widget.trip.endAddress?.description}');

    getRouteCoordinates(startPoint, endPoint).then((route) {
      if (!mounted) return;
      Polyline polyline = Polyline(
        polylineId: PolylineId('route'),
        color: Colors.blueAccent,
        points: route,
        width: 5,
      );
      if (mounted) {
        setState(() {
          _polylines.add(polyline);
          centerCameraOnPolyline();
        });
      }
    });
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list,
      {double padding = 0.01}) {
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

  void _addMarker(LatLng position, String markerId, String title) {
    Marker marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(title: title),
    );
    _markers.add(marker);
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

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Conductor: ${widget.trip.nameDriver}",
              style: const TextStyle(fontSize: 18.0, color: ColorsApp.text),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showModalInfo(context, widget.trip);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorsApp.primayColor)),
                child: const Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Detalles',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                centerCameraOnPolyline();
              },
              initialCameraPosition: initialCameraPosition,
              polylines: _polylines,
              markers: _markers,
              compassEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),
          ),
        ],
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

  void _showModalInfo(BuildContext context, HistoryClientTrip trip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return DetailsMap(trip: trip);
      },
    );
  }
}
