import 'package:flutter/material.dart';
import 'package:flutter_fetchdata/core/api_service.dart';
import 'package:go_router/go_router.dart';

class ListDrinksScreen extends StatelessWidget {
  const ListDrinksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cocktails")),
      body: FutureBuilder<List<Map<String, String>>>(
        future: ApiService.getCocktails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load cocktails"));
          }
          final drinks = snapshot.data ?? [];
          return ListView.builder(
            itemCount: drinks.length,
            itemBuilder: (context, index) {
              final drink = drinks[index];
              return ListTile(
                leading: Image.network(drink['image'] ?? '', width: 50),
                title: Text(drink['name'] ?? 'No Name'),
                onTap: () {
                  GoRouter.of(context).go('/drink/${drink['id']}');
                },
              );
            },
          );
        },
      ),
    );
  }
}
