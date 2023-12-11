import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/config/dio/module_network.dart';

class GeneralProvider {
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

  Future<bool> updateUserInfo(String? nombre, String? apellido, String? sex,
      String? birthDate, int? state, String? cellphone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonData = json.decode(prefs.getString('data')!);
    String id = jsonData['id'].toString();

    var requestData = jsonEncode({
      "id": id,
      "person": { 
        "id": id,
        if (nombre != null) "name": nombre,
        if (apellido != null) "surname": apellido,
        if (sex != null) "sex": sex,
        if (birthDate != null) "birthDate": birthDate,
        if (state != null) "state": {"id": state},
        if (cellphone != null) "cellphone": int.parse(cellphone),
        "status": true
      }
    });

    try {
      final response = await dio.put('logged/update-user', data: requestData);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Fallo al actualizar la información del usuario');
      }
    } on DioException catch (e) {
      throw Exception('Fallo al actualizar la información del usuario $e');
    }
  }
}
