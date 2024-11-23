import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://www.thecocktaildb.com/api/json/v1/1";

  static Future<List<Map<String, dynamic>>> getCocktails() async {
    final response =
        await http.get(Uri.parse('$baseUrl/filter.php?c=Cocktail'));
    final data = json.decode(response.body);
    return (data['drinks'] as List)
        .map((drink) => {
              'id': drink['idDrink'],
              'name': drink['strDrink'],
              'image': drink['strDrinkThumb'],
            })
        .toList();
  }

  static Future<List<Map<String, dynamic>>> searchCocktailByName(
      String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));
    final data = json.decode(response.body);
    return (data['drinks'] as List)
        .map((drink) => {
              'id': drink['idDrink'],
              'name': drink['strDrink'],
              'image': drink['strDrinkThumb'],
            })
        .toList();
  }

  static Future<Map<String, dynamic>> getDrinkDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    final data = json.decode(response.body);
    return (data['drinks'] as List).first;
  }
}
