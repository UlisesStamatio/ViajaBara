import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  Dio dio = Dio();
  final url = 'http://192.168.0.101:8083/api/auth/login';

 Future<bool> login(String email, String password) async {
    var dataJson = jsonEncode({'email': email, 'password': password});
    try {
      final response = await dio.post( url, data: dataJson );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return false;
      }
      throw Exception('Error de inicio de sesión: ${e.message}');
    }
  }
}
