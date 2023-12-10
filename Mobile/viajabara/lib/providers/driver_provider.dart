import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/config/dio/module_network.dart';
import 'package:viajabara/domain/entities/qualifications/qualifications.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';
import 'package:viajabara/domain/entities/trip/riders_trip.dart';

class DriverProvider {
  Dio dio = NetworkModule().instance;

  Future<List<DriverTrip>> getTripsForDriver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonData = json.decode(prefs.getString('data')!);
    int id = jsonData['id'];

    try {
      final response = await dio.put('driver/findAllToday', data: {'driver': {'id': id}});
      if (response.statusCode == 200) {
        List<dynamic> tripsJson = response.data['result'];
        return tripsJson.map((json) => DriverTrip.fromJson(json)).toList();
      } else {
        throw Exception('Fallo al obtener los registros');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al obtener los registros $e');
    }
  }

  Future<bool> updateTripStatus(int id, int status) async {
    try {
      final response = await dio.put('driver/tripChangeStatus', data: {'id': id, 'status': status});
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Fallo al actualizar el registro');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al actualizar el registro $e');
    }
  }

  Future<List<DriverTrip>> getHistoryTripForDriver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonData = json.decode(prefs.getString('data')!);
    int id = jsonData['id'];

    try {
      final response = await dio.put('driver/tripHistory', data: {'driver': {'id': id}});
      if (response.statusCode == 200) {
        List<dynamic> tripsJson = response.data['result'];
        return tripsJson.map((json) => DriverTrip.fromJson(json)).toList();
      } else {
        throw Exception('Fallo al obtener el historial para el conductor');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al obtener el historial para el conductor $e');
    }
  }

  Future<List<Qualifications>> getQualificationsAboutTravel(int id) async {
    try {
      final response = await dio.put('driver/findQualifications', data: {'id': id});
      if (response.statusCode == 200) {
        List<dynamic> tripsJson = response.data['result'];
        return tripsJson.map((json) => Qualifications.fromJson(json)).toList();
      } else {
        throw Exception('Fallo al obtener los comentarios');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al obtener los comentario $e');
    }
  }

  Future<List<RidersTrip>> getRidersForTrip(int id) async {
    try {
      final response = await dio.put('driver/allRiders', data: {"openTrips": {"id": id}});
      if (response.statusCode == 200) {
        List<dynamic> tripsJson = response.data['result'];
        return tripsJson.map((json) => RidersTrip.fromJson(json)).toList();
      } else {
        throw Exception('Fallo al obtener los pasajeros');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al obtener los pasajeros $e');
    }
  }

  Future<bool> checkAsistenceUser(int id, int checked) async {
    try {
      final response = await dio.put('driver/checkAssist', data: {'id': id, 'checked': checked});
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Fallo al actualizar la asistencia del usuario');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al actualizar la asistencia del usuario $e');
    }
  }
}
