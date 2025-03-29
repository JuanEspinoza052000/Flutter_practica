import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Start1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Imagen en lugar del icono
                Image.asset(
                  'assets/images/sinfondo.png', // Asegúrate de tener esta imagen en tus assets
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
                const SizedBox(height: 20),
                const Text(
                  "Gracias por usar nuestra aplicación",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 131, 114, 96),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/start2');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 88, 45, 13),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Comenzar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFDFD7BF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
