import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/config/dio/module_network.dart';
import 'package:viajabara/domain/entities/address.dart';
import 'package:viajabara/domain/entities/book_trip.dart';
import 'package:viajabara/domain/entities/list_states.dart';
import 'package:viajabara/domain/entities/response_message.dart';
import 'package:viajabara/domain/entities/roles/roles.dart';
import 'package:viajabara/domain/entities/state/state_list.dart';
import 'package:viajabara/domain/entities/trip/trip.dart';
import 'package:viajabara/domain/entities/user_data.dart';
import 'package:viajabara/domain/entities/visual_config/visual_config.dart';
import 'package:viajabara/modules/tripsUser/adapters/entities/list_drivers.dart';

class AuthProvider {
  Dio dio = NetworkModule().instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Map<String, dynamic> data = {};

  Future<ResponseMessage> login(String email, String password) async {
    var dataJson = jsonEncode({'email': email, 'password': password});
    try {
      final response = await dio.post('auth/login', data: dataJson);
      await _getInfoUser(email);
      await getVisualConfigurations();
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

  Future<void> getVisualConfigurations() async {
    try {
      SharedPreferences prefs = await _prefs;

      final response = await dio.get('visual-config');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            response.data as Map<String, dynamic>;
        print("response");
        print(responseBody);

        if (responseBody.containsKey('result')) {
          final Map<String, dynamic> result =
              responseBody['result'] as Map<String, dynamic>;
          print("result");
          print(result);

          if (result.containsKey('content')) {
            final List<dynamic> contentList =
                result['content'] as List<dynamic>;

            if (contentList.isNotEmpty) {
              final Map<String, dynamic> tripsJson =
                  Map<String, dynamic>.from(contentList[0]);
              print("content");
              print(tripsJson);

              VisualConfigDto visualConfigDto =
                  VisualConfigDto.fromJson(tripsJson);
              prefs.setString(
                  "visualConfig", jsonEncode(visualConfigDto.toJson()));
              print(visualConfigDto);
            } else {
              throw Exception('La lista "content" está vacía.');
            }
          } else {
            throw Exception('La respuesta no contiene la clave "content".');
          }
        } else {
          throw Exception('La respuesta no contiene la clave "result".');
        }
      } else {
        throw Exception('Fallo al obtener las configuraciones visuales');
      }
    } catch (e) {
      print(e.toString());
    }
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
