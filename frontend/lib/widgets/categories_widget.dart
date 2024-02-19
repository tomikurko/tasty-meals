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
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 1, child: _buildCategories(context, ref)),
              const SizedBox(height: 16),
              Expanded(flex: 2, child: _buildRecipes(context, ref)),
            ])));
  }

  Widget _buildCategories(BuildContext context, WidgetRef ref) {
    final allCategoriesFuture = ref.watch(allCategoriesFutureProvider);

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
    ]);
  }

  Widget _buildRecipes(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Recipe>>? recipesFuture;
    if (recipesByCategoryFutureProvider != null) {
      recipesFuture = ref.watch(recipesByCategoryFutureProvider!);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (recipesFuture != null) ...[
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
