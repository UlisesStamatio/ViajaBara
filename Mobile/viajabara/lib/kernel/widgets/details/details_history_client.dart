import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viajabara/domain/entities/user/user_history_trips.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/providers/utils/utils.dart';

class DetailsHistoryClient extends StatefulWidget {
  HistoryClientTrip trip;

  DetailsHistoryClient({Key? key, required this.trip}) : super(key: key);

  @override
  _DetailsHistoryClient createState() => _DetailsHistoryClient();
}

class _DetailsHistoryClient extends State<DetailsHistoryClient> {
  @override
  Widget build(BuildContext context) {
    String unidad = widget.trip.trip!.bus!.mark!+' '+widget.trip.trip!.bus!.model!;
    int lastPos = widget.trip.trip!.stopOvers!.length - 1;
    String destino = widget.trip.trip!.stopOvers![lastPos].address!.state!;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: 20),
                const Text(
                  'Detalles del viaje',
                  style: TextStyle(
                    color: ColorsApp.text,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Divider(color: ColorsApp.text)),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Origen: ${widget.trip.trip!.stopOvers?[0].address!.state}',
                            style: const TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(
                            Icons.flight_land,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Destino: $destino',
                            style: const TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.bus,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Unidad: $unidad',
                            style: const TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Conductor: ${widget.trip.nameDriver}',
                            style: const TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(
                            Icons.date_range,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                              'Fecha del viaje: ${widget.trip.startDate}',
                              style: const TextStyle(
                                color: ColorsApp.text,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Duración: ${Utils().formatTime(widget.trip.trip!.time!)}',
                            style: const TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(
                            Icons.airline_seat_recline_normal_sharp,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Asientos comprados: ${widget.trip.seatsSelected?.replaceAll('["', '').replaceAll('"]', '')}',
                            style: const TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
