import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

register(String name, String email, String password) async {
  //const String baseUrl = 'http://localhost:8000/api/register'; //WEB
  const String baseUrl = 'http://10.0.2.2:8000/api/register'; //ANDROID

  var client = http.Client();
  var url = Uri.parse(baseUrl);
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'cache-control': 'no-cache',
  };

  var body = json.encode({'name': name, 'email': email, 'password': password});

  var response = await client.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    //ALERTAS Y SER MOSTRADAS EN EL MODULO DE REGISTRO
    debugPrint(response.body);
  } else {
    debugPrint('Error');
  }

  //WEB
}
