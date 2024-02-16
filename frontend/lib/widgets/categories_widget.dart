import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/providers/all_categories_future_provider.dart';
import 'package:tastymeals/providers/recipes_by_category_future_provider.dart';

class CategoriesWidget extends ConsumerWidget {
  final int? selectedCategoryId;
  final FutureProvider<List<Recipe>>? recipesByCategoryFutureProvider;

  CategoriesWidget(this.selectedCategoryId)
      : recipesByCategoryFutureProvider = selectedCategoryId != null
            ? getRecipesByCategoryFutureProvider(selectedCategoryId)
            : null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCategoriesFuture = ref.watch(allCategoriesFutureProvider);

    AsyncValue<List<Recipe>>? recipesFuture;
    if (recipesByCategoryFutureProvider != null) {
      recipesFuture = ref.watch(recipesByCategoryFutureProvider!);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Categories", style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      ...allCategoriesFuture.when(
          loading: () => [const Text("Loading categories...")],
          error: (err, stack) => [const Text("Failed to load categories!")],
          data: (categories) => categories.isEmpty
              ? [const Text("No categories available")]
              : categories.expand((category) => [
                    TextButton(
                      child: Text(category.name),
                      onPressed: () => context.go("/category/${category.id}"),
                    ),
                  ])),
      if (recipesFuture != null) ...[
        const SizedBox(height: 32),
        Text("Recipes", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ...recipesFuture.when(
            loading: () => [const Text("Loading recipes...")],
            error: (err, stack) => [const Text("Failed to load recipes!")],
            data: (recipes) => recipes.isEmpty
                ? [const Text("No recipes available")]
                : recipes.expand((recipe) => [
                      TextButton(
                        child: Text(recipe.name),
                        onPressed: () => context.go("/recipe/${recipe.id}"),
                      ),
                    ])),
      ]
    ]);
  }
}
