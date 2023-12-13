import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/config/dio/module_network.dart';
import 'package:viajabara/domain/entities/book_trip.dart';
import 'package:viajabara/domain/entities/payment_method/payment_method.dart';
import 'package:viajabara/domain/entities/user/user_history_trips.dart';

class ClientProvider {
  Dio dio = NetworkModule().instance;

  Future<List<HistoryClientTrip>> getHistoryTrips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonData = json.decode(prefs.getString('data')!);
    int id = jsonData['id'];

    try {
      final response = await dio.put('client/all-by-client', data: {
        'client': {'id': id}
      });
      if (response.statusCode == 200) {
        List<dynamic> tripsJson = response.data['result'];
        return tripsJson
            .map((json) => HistoryClientTrip.fromJson(json))
            .toList();
      } else {
        throw Exception('Fallo al obtener el historial para el cliente');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al obtener el historial para el cliente $e');
    }
  }

  Future<List<PaymentMethodDart>> getPaymentMethods() async {
    try {
      final response = await dio.get('payment-methods/all-enabled');
      if (response.statusCode == 200) {
        List<dynamic> paymentMethodsJson = response.data['result'];
        return paymentMethodsJson
            .map((json) => PaymentMethodDart.fromJson(json))
            .toList();
      } else {
        throw Exception('Fallo al obtener los metodos de pago');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al obtener los metodos de pago $e');
    }
  }

  Future<bool> saveSeatingSales(BookTrip bookTrip) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> jsonData = json.decode(prefs.getString('data')!);
      int id = jsonData['id'];
      bookTrip.clientId = id;
      final response = await dio.post('open-trips/save-seating-sales',
          data: bookTrip.toJson());
      print(response);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw Exception('Fallo al obtener guardar los asientos $e');
    }
  }

  Future<bool> registerQualification(
      int id, double score, String comments) async {
    try {
      final response = await dio.post('client/register-qualification', data: {
        'seatingSales': {'id': id},
        'comments': comments,
        'score': score
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Fallo al registrar la calificación');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al registrar la calificación $e');
    }
  }
}
