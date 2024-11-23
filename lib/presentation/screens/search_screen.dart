import 'package:flutter/material.dart';
import 'package:flutter_fetchdata/core/api_service.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  Future<List<Map<String, String>>>? searchResults;

  void _search(String query) {
    setState(() {
      this.query = query;
      searchResults = ApiService.searchCocktailByName(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Drinks")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: _search,
              decoration: InputDecoration(
                labelText: "Enter cocktail name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: searchResults == null
                ? const Center(child: Text("Search for a drink"))
                : FutureBuilder<List<Map<String, String>>>(
                    future: searchResults,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text("Search failed"));
                      }
                      final drinks = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: drinks.length,
                        itemBuilder: (context, index) {
                          final drink = drinks[index];
                          return ListTile(
                            leading:
                                Image.network(drink['image'] ?? '', width: 50),
                            title: Text(drink['name'] ?? 'No Name'),
                            onTap: () {
                              GoRouter.of(context).go('/drink/${drink['id']}');
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
