import 'package:go_router/go_router.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/list_drink_screen.dart';
import '../presentation/screens/search_screen.dart';
import '../presentation/screens/drink_details_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/list',
        builder: (context, state) => const ListDrinksScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => SearchScreen(),
      ),
      GoRoute(
        path: '/detail/:id/:drinkName',
        builder: (context, state) {
          final String drinkName = state.pathParameters['drinkName']!;
          final String id = state.pathParameters['id']!;
          return DetailDrinkScreen(drinkName: drinkName);
        },
      ),
    ],
  );
}
