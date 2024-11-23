import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  // Obtener todas las bebidas por categoría
  Future<List<dynamic>> fetchDrinksByCategory(String category) async {
    final url = Uri.parse('$baseUrl/filter.php?c=$category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['drinks'] ?? [];
    } else {
      throw Exception('Failed to load drinks');
    }
  }

  // Obtener detalles de una bebida por ID
  Future<Map<String, dynamic>> fetchDrinkDetails(String id) async {
    final url = Uri.parse('$baseUrl/lookup.php?i=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['drinks'][0] ?? {};
    } else {
      throw Exception('Failed to load drink details');
    }
  }
}
