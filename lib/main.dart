import 'package:clase2_login/pages/favorites.dart';
import 'package:clase2_login/pages/home_page.dart';
import 'package:clase2_login/pages/login_page.dart';
import 'package:clase2_login/pages/pagos.dart';
import 'package:clase2_login/pages/productos.dart';
import 'package:clase2_login/pages/search_page.dart';
import 'package:clase2_login/pages/settings.dart';
import 'package:clase2_login/startPages/st1.dart';
import 'package:clase2_login/startPages/st2.dart';
import 'package:flutter/material.dart';
import 'package:clase2_login/pages/start.dart';
import 'package:clase2_login/pages/register_page.dart';
import 'package:clase2_login/pages/login__page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'login Flutter',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const onBoardingScreen(),
          // '/': (context) => start1(),
          '/start1': (context) => Start1(),
          '/start2': (context) => start2(),
          '/login': (context) => LoginPage(),
          '/home_page': (context) => const HomePage(),
          '/register_page': (context) => RegisterPage(),
          '/search': (context) => search(),
          '/favorites': (context) => Favoritos(),
          '/settings': (context) => UserOption(),
          '/Pagos': (context) => Cart(),
          '/Productos': (context) => Productos(),
        });
  }
}
