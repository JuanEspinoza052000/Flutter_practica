import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UserOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  // Función para construir el AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text("Configuración"),
    );
  }

  // Función para construir el cuerpo de la página
  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF5F5F5),
            Color(0xFFF2EAD3),
            Color(0xFFDFD7BF),
            Color(0xFF3F2305),
          ],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildProfileImage(),
              SizedBox(height: 20), // Espacio
              _buildUserName(),
              SizedBox(height: 30), // Espacio
              _buildMenuList(context),
            ],
          ),
        ),
      ),
    );
  }

  // Función para mostrar la imagen de perfil
  Widget _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50), // Borde redondeado
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Color de la sombra
            blurRadius: 8, //blur
            offset: Offset(0, 4), // Desplazamiento de la sombra
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 50, // Tamano del circulo
        backgroundImage: NetworkImage('https://link-a-tu-imagen.com/foto.jpg'),
      ),
    );
  }

  // Función para mostrar el nombre de usuario con sombra
  Widget _buildUserName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'admin', // Nombre de usuario
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(1, 1),
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
  }

  // Función para construir el menú de opciones
  Widget _buildMenuList(BuildContext context) {
    return Column(
      children: [
        _buildListTile(
          context,
          icon: Icons.person,
          title: 'Perfil',
          route: '/profile',
        ),
        _buildListTile(
          context,
          icon: Icons.notifications,
          title: 'Notificaciones',
          route: '/notifications',
        ),
        _buildListTile(
          context,
          icon: Icons.lock,
          title: 'Cambiar contraseña',
          route: '/change_password',
        ),
        _buildListTile(
          context,
          icon: Icons.exit_to_app,
          title: 'Cerrar sesión',
          route: '/login',
        ),
        _buildListTile(
          context,
          icon: Icons.dark_mode,
          title: 'Modo oscuro',
          route: '',
        ),
      ],
    );
  }

  // Función
  Widget _buildListTile(BuildContext context,
      {required IconData icon, required String title, required String route}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          if (route.isNotEmpty) {
            Navigator.pushNamed(context, route);
          }
        },
      ),
    );
  }
}
