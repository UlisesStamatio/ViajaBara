import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  Widget profilePicture(String profile) {
    try {
      if (profile.contains('<svg')) {
        // Si es un SVG
        return SvgPicture.string(
          profile,
          fit: BoxFit.cover,
        );
      } else {
        // Si es PNG/JPG
        Uint8List bytes = base64.decode(profile);
        return Image.memory(
          bytes,
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      print("Error al decodificar la imagen: $e");
      return const Icon(Icons.error);
    }
  }
}
