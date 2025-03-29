import 'package:flutter/material.dart';
import 'package:clase2_login/pages/login_controller/login_controller.dart';
import 'package:clase2_login/pages/login_controller/register_controller.dart';
import 'package:clase2_login/pages/home_page.dart';
import 'package:clase2_login/pages/register_page.dart';
import 'package:http/http.dart' as http; // Importa el paquete http
import 'dart:convert'; // Para usar json.decode

class LoginPage1 extends StatelessWidget {
  // DECLARACIÓN DE LAS VARIABLES
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage1({super.key});

  // Función para manejar el login
  Future<int> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'), // Reemplaza con tu URL
      body: {
        'email': email,
        'password': password,
      },
    );

    final responseBody = json.decode(response.body);
    debugPrint("Respuesta del backend: $responseBody");

    // Verifica si la respuesta contiene un campo 'message' y si comienza con 'hi'
    if (responseBody['message'].toString().startsWith('hi')) {
      return 200; // Devuelve 200 si el inicio de sesión es exitoso
    } else {
      return 401; // Devuelve 401 si hay un error de autenticación
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: passwordController,
                obscureText: true, // Para ocultar la contraseña
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final response =
                    await login(emailController.text, passwordController.text);

                debugPrint("Respuesta del backend: $response");

                if (response == 200) {
                  debugPrint("Redirigiendo a HomePage");
                  Navigator.pushNamed(
                      context, '/home_page'); // Redirige a HomePage
                } else {
                  debugPrint("Error en el login");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Usuario o contraseña incorrecta'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text(
                'Ingresar',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
