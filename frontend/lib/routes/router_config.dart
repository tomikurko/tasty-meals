import 'package:go_router/go_router.dart';
import 'package:tastymeals/screens/categories_screen.dart';
import 'package:tastymeals/screens/explore_screen.dart';
import 'package:tastymeals/screens/home_screen.dart';
import 'package:tastymeals/screens/recipe_screen.dart';
import 'package:tastymeals/screens/search_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: HomeScreen())),
  GoRoute(
      path: '/categories',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: CategoriesScreen(null))),
  GoRoute(
      path: '/category/:categoryId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
          child: CategoriesScreen(
              int.parse(state.pathParameters['categoryId']!)))),
  GoRoute(
      path: '/explore',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: ExploreScreen())),
  GoRoute(
      path: '/recipe/:recipeId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
          child: RecipeScreen(int.parse(state.pathParameters['recipeId']!)))),
  GoRoute(
      path: '/search',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: SearchScreen(""))),
  GoRoute(
      path: '/search/:searchString',
      pageBuilder: (context, state) => NoTransitionPage<void>(
          child: SearchScreen(state.pathParameters['searchString']!))),
]);
