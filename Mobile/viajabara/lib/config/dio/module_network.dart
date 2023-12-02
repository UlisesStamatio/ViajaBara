import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/domain/entities/response_message.dart';

class NetworkModule {
  static final NetworkModule _singleton = NetworkModule._internal();

  static Dio? _dio;

  factory NetworkModule() {
    return _singleton;
  }

  NetworkModule._internal() {
    _dio = Dio(_options);
    _initializeInterceptors();
  }

  final BaseOptions _options = BaseOptions(
    baseUrl: 'http://192.168.108.127:8083/api/',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('data');

    if (data == null) {
      return null;
    }

    Map<String, dynamic> jsonData = json.decode(data);
    ResponseMessage responseMessage = ResponseMessage.fromJson(jsonData);
    return responseMessage.token;
  }

  _initializeInterceptors() {
    _dio!.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String? token = await getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    }));
  }

  Dio get instance => _dio!;
}

final dio = NetworkModule().instance;
