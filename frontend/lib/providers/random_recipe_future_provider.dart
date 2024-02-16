import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/services/recipes_service.dart';

final randomRecipeFutureProvider = FutureProvider<Recipe>((ref) async {
  return await RecipesService().getRandomRecipe();
});
