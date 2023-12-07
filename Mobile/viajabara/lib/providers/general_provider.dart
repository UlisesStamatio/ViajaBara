import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/config/dio/module_network.dart';

class DriverProvider {
  Dio dio = NetworkModule().instance;

  Future<bool> changePassword(String lastPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonData = json.decode(prefs.getString('data')!);
    String email = jsonData['email'];
    try {
      final response =
          await dio.put('general/change-password', data: {'email': email, 'password': lastPassword, 'passwordNew': newPassword});
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Fallo al actualizar la contraseña');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al actualizar la contraseña $e');
    }
  }
}
