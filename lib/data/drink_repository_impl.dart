import 'dart:convert';
import '../core/api_service.dart';
import '../domain/drink.dart';

class DrinkRepositoryImpl {
  final ApiService apiService;

  DrinkRepositoryImpl(this.apiService);

  Future<List<Drink>> fetchDrinks() async {
    final response =
        await apiService.get('/api/json/v1/1/filter.php?c=Cocktail');
    final List drinks = jsonDecode(response.body)['drinks'];
    return drinks.map((drink) => Drink.fromJson(drink)).toList();
  }
}
