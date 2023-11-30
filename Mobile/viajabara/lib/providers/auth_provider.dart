import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/config/dio/module_network.dart';
import 'package:viajabara/domain/entities/address.dart';
import 'package:viajabara/domain/entities/book_trip.dart';
import 'package:viajabara/domain/entities/list_states.dart';
import 'package:viajabara/domain/entities/resMsg.dart';
import 'package:viajabara/domain/entities/roles/roles.dart';
import 'package:viajabara/domain/entities/state/state_list.dart';
import 'package:viajabara/domain/entities/trip/trip.dart';
import 'package:viajabara/domain/entities/user_data.dart';
import 'package:viajabara/modules/tripsUser/adapters/entities/list_drivers.dart';

class AuthProvider {
  Dio dio = NetworkModule().instance;

  Map<String, dynamic> data = {};

  Future<ResMsg> login(String email, String password) async {
    var dataJson = jsonEncode({'email': email, 'password': password});
    try {
      final response = await dio.post('auth/login', data: dataJson);
      return _parseLoginResponse(response);
    } on DioException catch (e) {
      return _handleLoginError(e);
    }
  }

  Future<ResMsg> register(UserData userData) async {
    var dataJson = jsonEncode({
      'username': userData.username,
      'profile': "Pruebaaaa",
      'email': userData.email,
      'password': userData.password,
      'person': {
        'cellphone': userData.cellphone,
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

  Future<List<StateList>> getStatesForTrip(String date) async {
    final response =
        await dio.post('trips/states-for-filters-by-date', data: date);

    if (response.statusCode == 200) {
      data = response.data;
      List<dynamic> statesJson = data['result'];

      List<StateList> states = statesJson.map((state) {
        List<dynamic> addressesJson = state['addresses'];
        List<Address> addresses = addressesJson
            .map((address) => Address(
                  description: address['description'],
                  id: address['id'],
                ) as Address) // Conversión explícita
            .toList();

        return StateList(
          name: state['name'],
          id: state['id'],
          addresses: addresses,
        );
      }).toList();

      return states;
    } else {
      throw Exception('Fallo al obtener los estados de origen');
    }
  }

  Future<List<TripDto>> getTripsByFiltersClient(BookTrip bookTrip) async {
    try {
      final response = await dio.post(
        'trips/find-by-filters-client',
        data: jsonEncode(bookTrip),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            response.data as Map<String, dynamic>;

        if (responseBody.containsKey('result')) {
          final List<Map<String, dynamic>> tripsJson =
              List<Map<String, dynamic>>.from(responseBody['result']);

          List<TripDto> trips = tripsJson.map((tripJson) {
            return TripDto.fromJson(tripJson);
          }).toList();

          print(trips);
          return trips;
        } else {
          throw Exception('La respuesta no contiene la clave "result".');
        }
      } else {
        throw Exception('Fallo al obtener los estados de origen');
      }
    } catch (e) {
      print(e.toString());
    }
    return List.empty();
  }

  Future<List<DriverItem>> getDriversEnabled() async {
    final response = await dio.get('user/all-drivers-enabled');

    if (response.statusCode == 200) {
      data = response.data;
      List<dynamic> driversJson = data['result'];
      List<DriverItem> drivers = driversJson
          .map((item) => DriverItem(
              id: item['id'],
              name: '${item['person']['name']} ${item['person']['surname']}'))
          .toList();
      return drivers;
    } else {
      throw Exception('Fallo al obtener los registros');
    }
  }

  ResMsg _parseLoginResponse(Response response) {
    data = response.data;

    if (data['token'] == null) {
      return ResMsg(text: data['text'], type: data['type']);
    }

    ResMsg responseMessage = ResMsg(
        token: data['token'],
        email: data['email'],
        roles: Roles(keyRole: data['roles'][0]['keyRole']));

    saveData(responseMessage, 'data');

    return responseMessage;
  }

  Future<ResMsg> getInfoUser(email) async {
    var dataJson = jsonEncode({'email': email});

    final response = await dio.put('logged/get-user', data: dataJson);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data['result'];
      ResMsg responseMessage = ResMsg(
          profile: data['profile'],
          name: data['person']['name'] + ' ' + data['person']['surname'],
          email: data['email'],
          cellphone: data['person']['cellphone'],
          birthDate: data['person']['birthDate'].toString(),
          sex: data['person']['sex'],
          state: data['person']?['state']?['name']);

      saveData(responseMessage, 'info');
      return responseMessage;
    } else {
      throw Exception('Fallo al obtener los registros');
    }
  }

  ResMsg _handleLoginError(DioException e) {
    if (e.response?.statusCode == 400) {
      var data = e.response!.data;
      return ResMsg(text: data['text'], type: data['type']);
    }
    throw Exception('Error de inicio de sesión: ${e.message}');
  }

  Future<void> saveData(ResMsg responseMessage, name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(responseMessage.toJson());
    await prefs.setString(name, data);
  }
}
