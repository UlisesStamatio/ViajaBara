import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:viajabara/domain/entities/list_states.dart';
import 'package:viajabara/domain/entities/login_response.dart';
import 'package:viajabara/domain/entities/response_message.dart';
import 'package:viajabara/domain/entities/roles/roles.dart';
import 'package:viajabara/domain/entities/user_data.dart';

class AuthProvider {
  Dio dio = Dio();

  Map<String, dynamic> data = {};

  Future<LoginResponse> login(String email, String password) async {
    var dataJson = jsonEncode({'email': email, 'password': password});
    try {
      final response = await dio.post('http://192.168.108.128:8083/api/auth/login', data: dataJson);
      data = response.data;
      print(data);
      LoginResponse loginResponse = LoginResponse(
          token: data['token'],
          email: data['email'],
          name: data['name'],
          roles: Roles(
              keyRole: data['roles'][0]['keyRole'],
              name: data['roles'][0]['name'],
              status: data['roles'][0]['status'])); 
      return loginResponse;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        data = e.response!.data;
        LoginResponse loginResponse = LoginResponse(text: data['text'],type: data['type']);
        return loginResponse;
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
      final response = await dio.post('http://192.168.108.128:8083/api/auth/register', data: dataJson);
      data = response.data;
      ResponseMessage responseMessage = ResponseMessage(text: data['text'], type: data['type']);
      return responseMessage;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        data = e.response!.data;
        ResponseMessage responseMessage = ResponseMessage(text: data['text'], type: data['type']);
        return responseMessage;
      }
      throw Exception('Error de inicio de sesión: ${e.message}');
    }
  }

  Future<List<StateItem>> getStates() async {
    final response = await dio.get('http://192.168.108.128:8083/api/lists/states');

    if (response.statusCode == 200) {
      data = response.data;
      List<dynamic> statesJson = data['result'];
      List<StateItem> states = statesJson
          .map((state) =>
              StateItem(name: state['name'].toString(), id: state['id']))
          .toList();
      return states;
    } else {
      throw Exception('Fallo al obtener los registros');
    }
  }
}
