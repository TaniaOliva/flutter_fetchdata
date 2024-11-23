import 'package:flutter/material.dart';
import 'package:flutter_fetchdata/core/api_service.dart';
import 'package:go_router/go_router.dart';

class DetailDrinkScreen extends StatelessWidget {
  final String drinkName;

  DetailDrinkScreen({required this.drinkName});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> pathParameters =
        GoRouterState.of(context).pathParameters;
    final String id = pathParameters['id'] ?? '';

    return FutureBuilder<Map<String, dynamic>>(
      future: ApiService().fetchDrinkDetails(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('Loading...')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          final drink = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(drinkName),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop(); // Navegar hacia atrás
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(drink['strDrinkThumb'] ?? ''),
                  SizedBox(height: 20),
                  Text(
                    'Name: ${drink['strDrink']}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Category: ${drink['strCategory']}'),
                  SizedBox(height: 10),
                  Text('Instructions: ${drink['strInstructions']}'),
                  SizedBox(height: 10),
                  Text('Ingredients:'),
                  for (int i = 1; i <= 15; i++)
                    if (drink['strIngredient$i'] != null &&
                        drink['strIngredient$i'].toString().isNotEmpty)
                      Text('- ${drink['strIngredient$i']}'),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
