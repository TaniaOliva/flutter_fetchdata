// lib/models/drink.dart

class Drink {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;

  Drink(
      {required this.idDrink,
      required this.strDrink,
      required this.strDrinkThumb});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      idDrink: json['idDrink'],
      strDrink: json['strDrink'],
      strDrinkThumb: json['strDrinkThumb'],
    );
  }
}
