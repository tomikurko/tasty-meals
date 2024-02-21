import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/category.dart';
import 'package:tastymeals/services/recipes_service.dart';

FutureProvider<Category> getCategoryFutureProvider(int categoryId) {
  return FutureProvider<Category>((ref) async {
    return await RecipesService().getCategory(categoryId);
  });
}
