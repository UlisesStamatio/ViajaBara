import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/providers/utils/utils.dart';

class DetailsOfTravels extends StatefulWidget {
  final DriverTrip trip;

  const DetailsOfTravels({Key? key, required this.trip}) : super(key: key);

  @override
  _DetailsOfTravels createState() => _DetailsOfTravels();
}

class _DetailsOfTravels extends State<DetailsOfTravels> {
  @override
  Widget build(BuildContext context) {
    int lastPos = widget.trip.trip!.stopOvers!.length - 1;
    String destino = widget.trip.trip!.stopOvers![lastPos].address!.description!;
    int numParadas = widget.trip.trip!.stopOvers!.length - 2;
    String textoParadas;
    if (numParadas <= 0) {
      textoParadas = 'Directo - Local';
    } else {
      textoParadas = '$numParadas parada${numParadas > 1 ? 's' : ''}';
    }
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
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Origen: ${widget.trip.trip!.stopOvers?[0].address!.description}',
                              style: const TextStyle(
                                color: ColorsApp.text,
                                fontSize: 16.0,
                              ),
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
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Destino: $destino',
                              style: const TextStyle(
                                color: ColorsApp.text,
                                fontSize: 16.0,
                              ),
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
                            'Fecha: ${widget.trip.startDate}',
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
                            Icons.timeline,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Parada(s): $textoParadas',
                            style: const TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: widget.trip.trip!.stopOvers!.length > 2
                              ? 100
                              : 50,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: ListView.builder(
                                itemCount: widget.trip.trip?.stopOvers!.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(children: [
                                        const Icon(CupertinoIcons.circle_fill),
                                        Positioned(
                                            top: 5,
                                            right: 8,
                                            child: Text(
                                              widget.trip.trip!.stopOvers![index]
                                                  .sequence
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: ColorsApp.whiteColor),
                                            )),
                                      ]),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          ' ${widget.trip.trip?.stopOvers![index].address!.description}',
                                          style: const TextStyle(
                                            color: ColorsApp.text,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          )),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Hora de salida: ${widget.trip.trip?.startTime} - ${Utils().sumarTiempo(widget.trip.trip!.startTime!, widget.trip.trip!.time!)}',
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
                            Icons.person,
                            color: ColorsApp.text,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Pasajeros: ${widget.trip.enableSeats}',
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
