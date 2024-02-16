import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/category.dart';
import 'package:tastymeals/services/recipes_service.dart';

final topCategoriesFutureProvider = FutureProvider<List<Category>>((ref) async {
  return await RecipesService().getTopCategories();
});
