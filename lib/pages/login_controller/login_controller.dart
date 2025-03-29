import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> login(String email, String password) async {
  // original const String baseUrl = 'http://127.0.0.1:8000/api/login';
  const String baseUrl = 'http://10.0.2.2:8000/api/login'; // android
  //web const String baseUrl = 'http://localhost:8000/api/login';

  try {
    var url = Uri.parse(baseUrl);
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'cache-control': 'no-cache',
    };
    var body = json.encode({'email': email, 'password': password});

    var response = await http.post(url, headers: headers, body: body);
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var message = json.decode(response.body);

      if (message.containsKey('accessToken')) {
        await saveToken(message['accessToken']);
        return 200; // Login exitoso
      } else {
        return 401; // Token no recibido
      }
    } else {
      return response.statusCode; // Devuelve el código real de error
    }
  } catch (e) {
    debugPrint("Error: $e");
    return 500; // Error interno
  }
}

Future<void> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token_app', token);
}
