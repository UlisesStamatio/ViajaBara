import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/modules/history/adapters/screens/historyStars.dart';
import 'package:viajabara/providers/driver_provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future<List<DriverTrip>> data = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var tripsData = await DriverProvider().getHistoryTripForDriver();
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
              'Historial',
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
                  return const Center(
                      child: Text('No hay historial disponible'));
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data!
                        .map((trip) => _buildHistoryCard(trip))
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

  Widget _buildHistoryCard(DriverTrip trip) {
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
                      Icon(Icons.location_on, size: 20.0),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Origen',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: ColorsApp.text,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("ViajaBara",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: ColorsApp.text,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Row(
                    children: [
                      Icon(CupertinoIcons.compass_fill, size: 20.0),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Destino',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: ColorsApp.text,
                              fontWeight: FontWeight.bold)),
                    ],
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
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
              height: 70.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${trip.trip?.stopOvers?[0].address?.state}',
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: ColorsApp.text,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: SvgPicture.asset(StuffApp.logoViajabara,
                              height: 15, width: 15),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            '${trip.trip?.stopOvers?.last.address?.state}',
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: ColorsApp.text,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Salida: ${trip.trip?.startTime}',
                        style: const  TextStyle(
                          fontSize: 15.0,
                          color: ColorsApp.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          trip.startDate!,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: ColorsApp.text,
                          ),
                        ),
                      ),
                      Text(
                        'Llegada: ${trip.trip?.time}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: ColorsApp.text,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.75,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryStars(trip: trip,)));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorsApp.primayColor),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.comment,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Comentarios',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
