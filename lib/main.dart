import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Models/gif_model.dart';

void main() {
  runApp(MyApp());
}

// Widget principal de la aplicación.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Grid Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GifGridScreen(), // Pantalla principal con GridView
    );
  }
}

/// Pantalla que muestra los GIFs en una cuadrícula (GridView).
class GifGridScreen extends StatefulWidget {
  @override
  _GifGridScreenState createState() => _GifGridScreenState();
}

class _GifGridScreenState extends State<GifGridScreen> {
  bool _isLoading = true; // Controla el estado de carga
  List<GifModel> _gifs = []; // Lista de GIFs
  String _errorMessage = ''; // Mensaje de error (si ocurre)

  @override
  void initState() {
    super.initState();
    _fetchGifs(); // Obtenemos los GIFs al iniciar
  }

  /// Función que consume la API de Giphy para obtener los GIFs en tendencia
  Future<void> _fetchGifs() async {
    final String apiUrl =
        'https://api.giphy.com/v1/gifs/trending?api_key=1wVv3Grzr3KWy923KG1DrlN8fuyquj5n&limit=25&offset=0&rating=g&bundle=messaging_non_clips';

    try {


      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        setState(() {
          _gifs = data.map((json) => GifModel.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error en la petición: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Excepción: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mientras se cargan los GIFs, muestra un indicador de progreso.
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('GIFs en Tendencia')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Si ocurrió un error, muéstralo en pantalla.
    if (_errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('GIFs en Tendencia')),
        body: Center(child: Text(_errorMessage)),
      );
    }

    

    // Muestra los GIFs en un GridView.
    return Scaffold(
      appBar: AppBar(title: Text('GIFs en Tendencia')),
      body: GridView.builder(
        // Ajustamos la cantidad de columnas con gridDelegate
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columnas
          crossAxisSpacing: 8.0, // Espacio horizontal entre celdas
          mainAxisSpacing: 8.0, // Espacio vertical entre celdas
          childAspectRatio: 0.8, // Ajusta la altura/anchura de cada celda
        ),
        itemCount: _gifs.length,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          final gif = _gifs[index];

          // Cada elemento de la cuadrícula será una "tarjeta" que muestre el GIF.
          return Card(
            elevation: 3,
            child: Column(
              children: [
                Expanded(
                  // Muestra el GIF usando Image.network
                  child: Image.network(gif.url, fit: BoxFit.cover),
                ),
                // Muestra el título en la parte inferior
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  child: Text(
                    gif.title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    // Opcional: Limitar el texto a 1 o 2 líneas
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}