import 'dart:convert';

import 'package:http/http.dart' as http;

sealed class GifDatasource {
  Future<Map<String, dynamic>> getGifs();
}

class IGifDatasource implements GifDatasource {
  @override
  Future<Map<String, dynamic>> getGifs() async {
    final String apiUrl =
        'https://api.giphy.com/v1/gifs/trending?api_key=1wVv3Grzr3KWy923KG1DrlN8fuyquj5n&limit=25&offset=0&rating=g&bundle=messaging_non_clips';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error en la petición: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Excepción: $e');
    }
  }
}
