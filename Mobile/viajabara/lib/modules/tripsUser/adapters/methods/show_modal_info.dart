import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:viajabara/domain/entities/trip/trip.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/providers/utils/utils.dart';

void showModalInfo(BuildContext context, TripDto tripDto) {
  DateTime endTime =
      Utils().calculateEndTimeDate(tripDto.startTime!, tripDto.listStopovers!);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      'Detalles',
                      style: TextStyle(
                        color: ColorsApp.primayColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(color: ColorsApp.text),
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
                                'Origen: ${tripDto.listStopovers!.first.address!.description}',
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
                                'Destino: ${tripDto.listStopovers!.last.address!.description}',
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
                              Icons.timeline,
                              color: ColorsApp.text,
                              size: 35,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Parada(s): ${tripDto.listStopovers!.length}',
                              style: const TextStyle(
                                color: ColorsApp.text,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: tripDto.listStopovers!.length * 35,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: ListView.builder(
                                  itemCount: tripDto.listStopovers!.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(children: [
                                          const Icon(
                                              CupertinoIcons.circle_fill),
                                          Positioned(
                                              top: 5,
                                              right: 8,
                                              child: Text(
                                                tripDto.listStopovers![index]
                                                    .sequence
                                                    .toString(),
                                                style: const TextStyle(
                                                    color:
                                                        ColorsApp.whiteColor),
                                              )),
                                        ]),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            ' ${tripDto.listStopovers![index].address!.description}',
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
                              Icons.date_range,
                              color: ColorsApp.text,
                              size: 35,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Hora: ${formatTime(tripDto.startTime!)} hrs - ${formatTime(endTime)} hrs',
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
                              'Tiempo estimado: ${calculateTime(tripDto.startTime!, endTime)}.',
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
                              Icons.airline_seat_recline_extra,
                              color: ColorsApp.text,
                              size: 35,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Asientos disponibles: ${tripDto.enabledSeats}',
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
    },
  );
}

String formatTime(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}

String calculateTime(DateTime startTime, DateTime endTime) {
  int differenceInMinutes = endTime.difference(startTime).inMinutes;
  int hours = differenceInMinutes ~/ 60;
  int minutes = differenceInMinutes % 60;

  if (hours > 0 && minutes > 0) {
    return '$hours:$minutes hrs ';
  } else if (hours > 0) {
    return '$hours hrs';
  } else {
    return '$minutes mins';
  }
}
