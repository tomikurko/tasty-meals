import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/services/recipes_service.dart';

FutureProvider<List<Recipe>> getRecipesByNameFutureProvider(String name) {
  return FutureProvider<List<Recipe>>((ref) async {
    return await RecipesService().getRecipesByName(name);
  });
}
