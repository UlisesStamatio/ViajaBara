import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';
import 'package:viajabara/domain/entities/trip/riders_trip.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/custom_progress_indicator.dart';
import 'package:viajabara/providers/driver_provider.dart';
import 'package:viajabara/providers/utils/utils.dart';

class Passengers extends StatefulWidget {
  final DriverTrip trip;
  const Passengers({Key? key, required this.trip}) : super(key: key);

  @override
  State<Passengers> createState() => _PassengersState();
}

class _PassengersState extends State<Passengers> {
  Future<List<RidersTrip>> data = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var tripsData = await DriverProvider().getRidersForTrip(widget.trip.id!);
    print('tripsData $tripsData');
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
              'Viajar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            FutureBuilder<List<RidersTrip>>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CustomCircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No hay pasajeros disponibles aún'));
                }

                return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return showCardUser(snapshot.data![index]);
                        },
                      ),
                    ]));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget showCardUser(RidersTrip rider) {
    String displayName = '';
    if (rider.client!.name != null && rider.client!.surname != null) {
      displayName = "${rider.client!.name} ${rider.client!.surname}";
    } else if (rider.client!.name != null) {
      displayName = rider.client!.name!;
    } else if (rider.client!.surname != null) {
      displayName = rider.client!.surname!;
    } else {
      displayName = rider.client!.username ?? 'Usuario no disponible';
    }
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 20.0),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: ColorsApp.dangerColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          displayName,
                          style: const TextStyle(
                              color: ColorsApp.blackColor, fontSize: 20),
                        ),
                      ],
                    )),
                const SizedBox(height: 10.0),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.place,
                          color: ColorsApp.dangerColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              rider.startAddress!.description!.substring(0, 28),
                              style: const TextStyle(
                                  color: ColorsApp.blackColor, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 10.0),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.clock,
                          color: ColorsApp.dangerColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          rider.startTime!,
                          style: const TextStyle(
                              color: ColorsApp.blackColor, fontSize: 20),
                        ),
                      ],
                    )),
                const SizedBox(height: 10.0),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.compass,
                          color: ColorsApp.dangerColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              rider.endAddress!.description!.substring(0, 28),
                              style: const TextStyle(
                                  color: ColorsApp.blackColor, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 5.0),
              ],
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Divider(color: ColorsApp.text)),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "¿Asistio?",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(), // Forma circular
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              DriverProvider().checkAsistenceUser(rider.id!, 1);
                            },
                            child: const Icon(Icons.check),
                          ),
                          const SizedBox(width: 5.0),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 15.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              DriverProvider().checkAsistenceUser(rider.id!, 2);
                            },
                            child: const Icon(Icons.cancel),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
