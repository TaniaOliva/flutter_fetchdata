import 'package:flutter/material.dart';
import 'package:flutter_fetchdata/core/api_service.dart';

class DrinkDetailsScreen extends StatelessWidget {
  final String drinkId;
  const DrinkDetailsScreen({Key? key, required this.drinkId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drink Details")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService.getDrinkDetails(drinkId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load drink details"));
          }
          final drink = snapshot.data ?? {};
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(drink['strDrinkThumb'] ?? '', height: 200),
                  const SizedBox(height: 16),
                  Text(
                    drink['strDrink'] ?? 'No Name',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Category: ${drink['strCategory'] ?? 'Unknown'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Instructions: ${drink['strInstructions'] ?? 'No instructions provided'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
