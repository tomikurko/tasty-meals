import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/services/recipes_service.dart';

FutureProvider<List<Recipe>> getRecipesByCategoryFutureProvider(
    int categoryId) {
  return FutureProvider<List<Recipe>>((ref) async {
    return await RecipesService().getRecipesByCategory(categoryId);
  });
}
