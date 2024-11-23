import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drink App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/list-drinks'),
              child: Text('List Drinks'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/search'),
              child: Text('Search Drinks'),
            ),
          ],
        ),
      ),
    );
  }
}
