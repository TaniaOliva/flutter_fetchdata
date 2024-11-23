import 'package:flutter/material.dart';
import 'package:flutter_fetchdata/core/api_service.dart';
import 'package:go_router/go_router.dart';

class ListDrinksScreen extends StatefulWidget {
  const ListDrinksScreen({Key? key}) : super(key: key);

  @override
  _ListDrinksScreenState createState() => _ListDrinksScreenState();
}

class _ListDrinksScreenState extends State<ListDrinksScreen> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> drinks;

  @override
  void initState() {
    super.initState();
    drinks = apiService.fetchDrinksByCategory('Cocktail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Drinks'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: drinks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No drinks found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final drink = snapshot.data![index];
                return ListTile(
                  title: Text(drink['strDrink']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    context.go(
                      '/detail/${drink['idDrink']}/${drink['strDrink']}',
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
