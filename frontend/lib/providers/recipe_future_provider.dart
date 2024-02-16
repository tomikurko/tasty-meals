import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/services/recipes_service.dart';

FutureProvider<Recipe> getRecipeFutureProvider(int recipeId) {
  return FutureProvider<Recipe>((ref) async {
    return await RecipesService().getRecipe(recipeId);
  });
}
