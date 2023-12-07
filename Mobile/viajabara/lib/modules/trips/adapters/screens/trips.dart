import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/details/details_travels.dart';
import 'package:viajabara/modules/trips/adapters/screens/traveling.dart';
import 'package:viajabara/providers/driver_provider.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  Future<List<DriverTrip>> data = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var tripsData = await DriverProvider().getTripsForDriver();
    setState(() {
      data = Future.value(tripsData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Viajes',
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
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SvgPicture.asset(
              StuffApp.bgGeneral,
              fit: BoxFit.cover,
            ),
            FutureBuilder<List<DriverTrip>>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay viajes disponibles'));
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data!
                        .map((trip) => _buildTripCard(trip))
                        .toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCard(DriverTrip trip) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(CupertinoIcons.bus, size: 20.0),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Horario',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: ColorsApp.text,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Tiempo estimado: ${trip.trip?.route?.time}',
                    style: const TextStyle(
                        fontSize: 15.0,
                        color: ColorsApp.primayColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Divider(
              color: ColorsApp.text,
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              height: 60.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Salida: ${trip.trip?.startTime}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: ColorsApp.text,
                        ),
                      ),
                      Text(
                        'Llegada: ${trip.trip?.startTime} + ${trip.trip?.route?.time}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: ColorsApp.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Destino: ${trip.trip?.route?.endAddress?.description}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: ColorsApp.text,
                        ),
                      ),
                      const Text(
                        'Directo - Local',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: ColorsApp.text,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _showModalInfo(context, trip);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorsApp.primayColor)),
                  child: const Row(children: [
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
                  ]),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool success =
                        await DriverProvider().updateTripStatus(trip.id!, 2);

                    if (success) {
                      loadData();
                    }

                    if (trip.status == 2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Traveling(trip: trip )),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorsApp.primayColor),
                  ),
                  child: Row(children: [
                    Icon(
                      _getButtonIcon(trip.status!),
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _getButtonText(trip.status!),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getButtonIcon(int status) {
    switch (status) {
      case 1:
        return Icons.hourglass_empty;
      case 2:
        return Icons.play_arrow;
      default:
        return Icons.done;
    }
  }

  String _getButtonText(int status) {
    switch (status) {
      case 1:
        return 'En espera';
      case 2:
        return 'En curso';
      default:
        return 'Finalizado';
    }
  }

  void _showModalInfo(BuildContext context, DriverTrip trip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return DetailsOfTravels(trip: trip);
      },
    );
  }
}
