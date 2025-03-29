import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clase2_login/main.dart';

class Productos extends StatefulWidget {
  const Productos({super.key});

  @override
  _Productos createState() => _Productos();
}

class _Productos extends State<Productos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildBody(),
          _buildCategories(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  /// AppBar con icono de búsqueda
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF5F5F5),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
        )
      ],
    );
  }

  /// Cuerpo principal con gradiente y productos obtenidos desde la API
  Widget _buildBody() {
    return FutureBuilder<List<Producto>>(
      future: fetchProductos(), // Llamada a la API
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products available'));
        } else {
          // Si los productos están disponibles, los mostramos
          List<Producto> productos = snapshot.data!;

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
              child: Column(
                children: [
                  // No usamos Expanded, solo un ListView normal
                  ListView.builder(
                    shrinkWrap:
                        true, // Esto asegura que el ListView ocupe solo el espacio necesario
                    physics:
                        NeverScrollableScrollPhysics(), // Esto evita el desplazamiento innecesario dentro del ListView
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final producto = productos[index];
                      return ListTile(
                        title: Text(producto.nombre),
                        subtitle: Text('${producto.precio} USD'),
                        onTap: () {
                          // Acción al seleccionar el producto (por ejemplo, ver detalles)
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  /// Sección de categorías con elementos de categoría
  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.local_grocery_store, 'label': 'Hamburguesas'},
      {'icon': Icons.local_pizza, 'label': 'Pizza'},
      {'icon': Icons.local_drink, 'label': 'Refrescos'},
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _buildCategoryRow(categories),
          _buildCategoryRow(categories), // Duplicado de categorías
        ],
      ),
    );
  }

  /// Genera una fila de categorías
  Widget _buildCategoryRow(List<Map<String, dynamic>> categories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categories
          .map((category) => _categoryItem(category['icon'], category['label']))
          .toList(),
    );
  }

  /// Widget individual para un elemento de categoría
  Widget _categoryItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 60, color: Colors.brown),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  /// Navbar inferior con navegación
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      color: const Color(0xFF3F2305),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 15.0, vertical: 10), // Reducir el padding vertical
        child: GNav(
          backgroundColor: const Color(0xFF3F2305),
          color: const Color(0xFFF5F5F5),
          activeColor: const Color(0xFFDFD7BF),
          tabBackgroundColor: const Color.fromARGB(255, 80, 47, 42),
          gap: 8,
          padding: const EdgeInsets.symmetric(
              vertical: 14, horizontal: 16), // Ajuste del padding
          onTabChange: (index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home_page');
                break;
              case 1:
                Navigator.pushNamed(context, '/Productos');
                break;
              case 2:
                Navigator.pushNamed(context, '/Pagos');
                break;
              case 3:
                Navigator.pushNamed(context, '/settings');
                break;
              default:
                break;
            }
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.credit_card,
              text: 'Buscar',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favoritos',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Configuración',
            ),
          ],
        ),
      ),
    );
  }

  /// Función para obtener productos desde la API
  Future<List<Producto>> fetchProductos() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/productos'));

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, decodificamos el JSON
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Producto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

/// Función para obtener productos desde la API
Future<List<Producto>> fetchProductos() async {
  // final response =
  //     await http.get(Uri.parse('http://127.0.0.1:8000/api/productos'));
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/api/productos'));

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa, decodificamos el JSON
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Producto.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

// Clase personalizada para manejar la búsqueda
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Resultados para "$query"',
          style: const TextStyle(fontSize: 24)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Sugerencias para "$query"',
          style: const TextStyle(fontSize: 24)),
    );
  }
}

class Producto {
  final String nombre;
  final double precio;
  final String descripcion;

  // Constructor
  Producto({
    required this.nombre,
    required this.precio,
    required this.descripcion,
  });

  // Método para crear un Producto desde un JSON
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      nombre: json['nombre'],
      precio: json['precio'] is String
          ? double.parse(json['precio'])
          : json['precio'].toDouble(),
      descripcion: json['descripcion'],
    );
  }
}
