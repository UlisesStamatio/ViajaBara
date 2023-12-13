import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:viajabara/domain/entities/book_trip.dart';
import 'package:viajabara/domain/entities/stop_over/stop_over.dart';
import 'package:viajabara/domain/entities/trip/filterType.dart';
import 'package:viajabara/domain/entities/trip/trip.dart';
import 'package:viajabara/domain/entities/visual_config/visual_config.dart';

class Utils {
  String sumarTiempo(String startTime, double time) {
    // Convertir startTime a DateTime
    List<String> parts = startTime.split(":");
    DateTime dateTime =
        DateTime(0, 0, 0, int.parse(parts[0]), int.parse(parts[1]));

    // Crear un objeto Duration con time
    Duration duration = Duration(seconds: (time * 60).round());

    // Sumar la duración a dateTime
    DateTime newTime = dateTime.add(duration);

    // Formatear la nueva hora a una cadena de texto
    String formattedTime =
        "${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}";

    return formattedTime;
  }

  String formatTime(double tiempoEnMinutos) {
    // Redondear el tiempo a un entero
    int tiempoRedondeado = tiempoEnMinutos.round();

    // Calcular horas y minutos
    int horas = tiempoRedondeado ~/ 60; // División entera
    int minutos = tiempoRedondeado % 60; // Resto de la división

    // Crear la cadena resultante
    String resultado = "";
    if (horas > 0) {
      resultado += "${horas}h ";
    }
    if (minutos > 0) {
      resultado += "${minutos}min";
    }

    return resultado
        .trim(); // Elimina los espacios extra al final si solo hay horas
  }

  String formatDate(String timestamp) {
    try {
      final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return 'Agrega tu fecha de nacimiento';
    }
  }

  Widget profilePicture(String profile) {
    try {
      if (profile.contains("<svg")) {
        return SvgPicture.string(
          profile,
          fit: BoxFit.cover,
        );
      } else {
        Uint8List bytes = base64.decode(profile);
        return CircleAvatar(
          radius: 30,
          backgroundImage: MemoryImage(
            bytes,
            scale: 0.1,
          ),
        );
      }
    } catch (e) {
      print("Error al procesar la imagen: $e");
      return const Icon(Icons.error);
    }
  }

  DateTime calculateEndTimeDate(
      DateTime startTime, List<StopOverDto> stopovers) {
    double totalMinutes = 0.0;
    stopovers.forEach((stopover) {
      totalMinutes += stopover.time;
    });

    Duration totalDuration = Duration(minutes: totalMinutes.toInt());
    DateTime endTime = startTime.add(totalDuration);
    return endTime;
  }

  double calculateRoutePriceValue(
      TripDto trip, VisualConfigDto visualConfigDto, BookTrip bookTrip) {
    if (trip.filterType!.value.contains("Parada") &&
        trip.listStopovers != null) {
      double routeMeters =
          sumMetersUntilId(trip.listStopovers!, bookTrip.destinyId!);
      return (routeMeters * 0.001) * visualConfigDto.kilometerPrice!;
    } else {
      double routeMeters = trip.meters ?? 0.0;
      return (routeMeters * 0.001) * visualConfigDto.kilometerPrice!;
    }
  }

  String formatRoutePrice(double routePrice) {
    return '\$ ${routePrice.toStringAsFixed(2)} MXN';
  }

  double sumMetersUntilId(List<StopOverDto> stopovers, int idToSearch) {
    double sumMeters = 0;

    for (StopOverDto stopover in stopovers) {
      sumMeters += stopover.meters;
      if (stopover.id == idToSearch) {
        break;
      }
    }

    return sumMeters;
  }
}
