import 'package:flutter/material.dart';
import 'package:clase2_login/pages/home_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:clase2_login/pages/register_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  // Función para manejar el login
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    final responseBody = json.decode(response.body);
    debugPrint("Respuesta del backend: $responseBody");

    if (responseBody['message'].toString().startsWith('hi')) {
      return responseBody; // Devuelve toda la respuesta si el inicio de sesión es exitoso
    } else {
      return null; // Devuelve null si hay un error de autenticación
    }
  }

  // Función para validar el formato del correo electrónico
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu correo electrónico';
    }
    // Expresión regular para validar el formato del correo electrónico
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, ingresa un correo electrónico válido';
    }
    return null;
  }

  // Función para validar la contraseña
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu contraseña';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F5F5),
              Color(0xFFF2EAD3),
              Color(0xFFDFD7BF),
              Color(0xFF3F2305)
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(134, 131, 131, 0.8),
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/sinfondo.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ).animate().fadeIn(duration: 1000.ms).scale(
                        begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),

                    const SizedBox(height: 20),
                    Animate(
                      effects: [
                        FadeEffect(duration: 1500.ms),
                      ],
                      child: const Text(
                        "¡Bienvenido!",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 88, 45, 13),
                        ),
                      ),
                    ),

                    Animate(
                      effects: [
                        FadeEffect(delay: 1500.ms, duration: 1500.ms),
                      ],
                      child: const Text(
                        'Inicia sesión para continuar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF3F2305),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const SizedBox(height: 40),
                    // Campo de correo electrónico
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        labelStyle: TextStyle(color: Colors.black87),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF09122C)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue[800]!),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 20),
                    // Campo de contraseña
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(
                          color: Colors.black87,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: _validatePassword, // Valida la contraseña
                    ),
                    const SizedBox(height: 30),
                    // Botón de Ingresar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Valida el formulario
                          if (_formKey.currentState!.validate()) {
                            final response = await login(
                                emailController.text, passwordController.text);

                            if (response != null) {
                              // Extrae el nombre del usuario de la respuesta
                              final userName = response['user']['name'];

                              // Muestra un mensaje de bienvenida
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(
                                    child: Text(
                                      '¡Bienvenido, $userName!',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 170, 162, 137),
                                  behavior: SnackBarBehavior
                                      .floating, // hace que flote la barra
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 30),
                                  duration: Duration(seconds: 3),
                                ),
                              );

                              // Redirige a la página de inicio
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const HomePage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 1000),
                                ),
                              );
                            } else {
                              // Muestra un mensaje de error
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'Usuario o contraseña incorrecta'),
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
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3F2305),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Botón para inicio con google
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // No hace nada, solo es visual
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons8-google-48.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Iniciar sesión con Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_page');
                      },
                      child: Text(
                        '¿No tienes una cuenta? Regístrate',
                        style: TextStyle(
                          color: const Color(0xFF3F2305),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
