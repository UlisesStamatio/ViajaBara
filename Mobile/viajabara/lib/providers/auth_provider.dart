import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:viajabara/domain/entities/list_states.dart';
import 'package:viajabara/domain/entities/response_message.dart';
import 'package:viajabara/domain/entities/user_data.dart';

class AuthProvider {
  Dio dio = Dio();

  Future<bool> login(String email, String password) async {
    var dataJson = jsonEncode({'email': email, 'password': password});
    try {
      final response = await dio.post('http://192.168.0.106:8083/api/auth/login', data: dataJson);

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return false;
      }
      throw Exception('Error de inicio de sesión: ${e.message}');
    }
  }

  Future<ResponseMessage> register(UserData userData) async {
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
      final response = await dio.post('http://192.168.0.106:8083/api/auth/register', data: dataJson);
        Map<String, dynamic> data = response.data;
        ResponseMessage responseMessage = ResponseMessage(text: data['text'], type: data['type']);
        return responseMessage;      
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        Map<String, dynamic> data = e.response!.data;
        ResponseMessage responseMessage = ResponseMessage(text: data['text'], type: data['type']);
        return responseMessage;
      }
      throw Exception('Error de inicio de sesión: ${e.message}');
    }
  }

  Future<List<StateItem>> getStates() async {
    final response = await dio.get('http://192.168.0.106:8083/api/lists/states');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      List<dynamic> statesJson = data['result'];
      List<StateItem> states = statesJson.map((state) => StateItem(name: state['name'].toString(), id: state['id'])).toList();
      return states;
    } else {
      throw Exception('Fallo al obtener los registros');
    }
  }
}
