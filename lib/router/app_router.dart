import 'package:flutter/material.dart';
import 'package:flutter_fetchdata/presentation/screens/drink_details_screen.dart';
import 'package:flutter_fetchdata/presentation/screens/list_drink_screen.dart';
import 'package:flutter_fetchdata/presentation/screens/search_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ListDrinksScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/drink/:id',
      builder: (context, state) {
        final drinkId = state.params['id']!;
        return DrinkDetailsScreen(drinkId: drinkId);
      },
    ),
  ],
);
