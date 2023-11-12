import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:viajabara/domain/entities/user_data.dart';

class AuthProvider {
  Dio dio = Dio();

  Future<bool> login(String email, String password) async {
    var dataJson = jsonEncode({'email': email, 'password': password});
    try {
      final response = await dio
          .post('http://192.168.0.104:8083/api/auth/login', data: dataJson);

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return false;
      }
      throw Exception('Error de inicio de sesión: ${e.message}');
    }
  }

  Future<bool> register(UserData userData) async {
    var dataJson = jsonEncode({
      'profile': "Pruebaaaa",
      'username': userData.username,
      'email': userData.email,
      'password': userData.password,
      'person': {
        'name': userData.name,
        'surname': userData.surname,
        'cellphone': userData.cellphone,
        'birthDate': userData.birthDate,
        'sex': userData.sex,
        'state': {'id': 5},
      },
      'roles': [
        {'id': 3}
      ]
    });

    try {
      final response = await dio
          .post('http://192.168.0.104:8083/api/auth/register', data: dataJson);
      print("Si entra aquí");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw Exception('Error al registrar al usuario: ${e.message}');
    }
  }
}
