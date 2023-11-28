import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/config/dio/module_network.dart';
import 'package:viajabara/domain/entities/list_states.dart';
import 'package:viajabara/domain/entities/response_message.dart';
import 'package:viajabara/domain/entities/roles/roles.dart';
import 'package:viajabara/domain/entities/user_data.dart';

class AuthProvider {
  Dio dio = NetworkModule().instance;

  Map<String, dynamic> data = {};

  Future<ResponseMessage> login(String email, String password) async {
    var dataJson = jsonEncode({'email': email, 'password': password});
    try {
      final response = await dio.post('auth/login', data: dataJson);
      _getInfoUser(email);
      return _parseLoginResponse(response);
    } on DioException catch (e) {
      return _handleLoginError(e);
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
      final response = await dio.post('auth/register', data: dataJson);
      return _parseLoginResponse(response);
    } on DioException catch (e) {
      return _handleLoginError(e);
    }
  }

  Future<List<StateItem>> getStates() async {
    final response = await dio.get('lists/states');

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

  ResponseMessage _parseLoginResponse(Response response) {
    data = response.data;

    if (data['token'] == null) {
      return ResponseMessage(text: data['text'], type: data['type']);
    }

    ResponseMessage responseMessage = ResponseMessage(
        token: data['token'],
        email: data['email'],
        roles: Roles(keyRole: data['roles'][0]['keyRole']));

    saveData(responseMessage, 'data');

    return responseMessage;
  }

  Future<ResponseMessage> _getInfoUser(email) async {
    var dataJson = jsonEncode({'email': email});

    final response = await dio.put('logged/get-user', data: dataJson);

    Map<String, dynamic> data = response.data;
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data['result']; 
      ResponseMessage responseMessage = ResponseMessage(
        profile: data['profile'],
        name: data['person']['name'] + ' ' + data['person']['surname'],
        email: data['email'],
        cellphone: data['person']['cellphone'], // Ahora esto debería funcionar
        birthDate: data['person']['birthDate'].toString(),
        sex: data['person']['sex'],
        state: data['person']['state']['name']);

      saveData(responseMessage, 'info');
      return responseMessage;
    } else {
      throw Exception('Fallo al obtener los registros');
    }
  }

  ResponseMessage _handleLoginError(DioException e) {
    if (e.response?.statusCode == 400) {
      var data = e.response!.data;
      return ResponseMessage(text: data['text'], type: data['type']);
    }
    throw Exception('Error de inicio de sesión: ${e.message}');
  }

  Future<void> saveData(ResponseMessage responseMessage, name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(responseMessage.toJson());
    await prefs.setString(name, data);
  }
}
