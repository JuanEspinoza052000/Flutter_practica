import 'package:flutter/material.dart';
import 'package:clase2_login/pages/login_page.dart';
import 'package:clase2_login/pages/register_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ignore: camel_case_types
class start2 extends StatelessWidget {
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
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Animate(
                  effects: [
                    FadeEffect(duration: 1500.ms),
                    SlideEffect(duration: 1000.ms),
                  ],
                  child: const Text(
                    "Ventajas Exclusivas",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F2305),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                _buildFeature(
                  icon: Icons.local_offer,
                  title: "Descuentos Todos los Días",
                  description:
                      "Disfruta de descuentos exclusivos en tus productos favoritos.",
                ),
                const SizedBox(height: 35),
                _buildFeature(
                  icon: Icons.local_shipping,
                  title: "Envíos Rápidos y Seguros",
                  description:
                      "Recibe tus pedidos en tiempo récord con total seguridad.",
                ),
                const SizedBox(height: 35),
                _buildFeature(
                  icon: Icons.payment,
                  title: "Pagos Seguros",
                  description:
                      "Realiza tus pagos con métodos seguros y confiables.",
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3F2305),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Siguiente",
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

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 40,
          color: Color(0xFF3F2305),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F2305),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 5, 5, 3),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
