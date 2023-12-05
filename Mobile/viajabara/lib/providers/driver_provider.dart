import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/config/dio/module_network.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';

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
}
