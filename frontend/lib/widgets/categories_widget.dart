import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/model/category.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/providers/all_categories_future_provider.dart';
import 'package:tastymeals/providers/category_future_provider.dart';
import 'package:tastymeals/providers/recipes_by_category_future_provider.dart';
import 'package:tastymeals/widgets/breakpoints.dart';
import 'package:tastymeals/widgets/category_list_item.dart';
import 'package:tastymeals/widgets/recipe_preview_card.dart';
import 'package:tastymeals/widgets/responsive_widget.dart';

class CategoriesWidget extends ConsumerWidget {
  final int? selectedCategoryId;
  final FutureProvider<Category>? categoryFutureProvider;
  final FutureProvider<List<Recipe>>? recipesByCategoryFutureProvider;

  CategoriesWidget(this.selectedCategoryId)
      : categoryFutureProvider = selectedCategoryId != null
            ? getCategoryFutureProvider(selectedCategoryId)
            : null,
        recipesByCategoryFutureProvider = selectedCategoryId != null
            ? getRecipesByCategoryFutureProvider(selectedCategoryId)
            : null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ResponsiveWidget(
                desktop: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: _buildCategories(context, ref)),
                      const SizedBox(width: 32),
                      Expanded(
                          flex:
                              MediaQuery.of(context).size.width < Breakpoints.md
                                  ? 1
                                  : 2,
                          child: _buildRecipes("Recipes", context, ref)),
                    ]),
                mobile: selectedCategoryId != null
                    ? _buildRecipesMobile(context, ref)
                    : _buildCategories(context, ref))));
  }

  Widget _buildCategories(BuildContext context, WidgetRef ref) {
    final allCategoriesFuture = ref.watch(allCategoriesFutureProvider);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text("Categories", style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      allCategoriesFuture.when(
          loading: () => const Text("Loading categories..."),
          error: (err, stack) => const Text("Failed to load categories!"),
          data: (categories) => categories.isEmpty
              ? const Text("No categories available")
              : Expanded(child: _buildCategoriesListView(categories))),
    ]);
  }

  Widget _buildCategoriesListView(List<Category> categories) {
    return _buildVerticalViewWithShader(ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(height: 6.0),
        itemBuilder: (BuildContext context, int index) => CategoryListItem(
            categories[index], selectedCategoryId == categories[index].id)));
  }

  Widget _buildRecipesMobile(BuildContext context, WidgetRef ref) {
    final categoryFuture = ref.watch(categoryFutureProvider!);

    final categoryName = categoryFuture.when(
        loading: () => "",
        error: (err, stack) => "Recipes",
        data: (category) => category.name);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      IconButton.filledTonal(
          iconSize: 32.0,
          onPressed: () => context.go("/categories"),
          icon: const Icon(Icons.arrow_back)),
      const SizedBox(height: 32.0),
      Expanded(child: _buildRecipes(categoryName, context, ref))
    ]);
  }

  Widget _buildRecipes(String title, BuildContext context, WidgetRef ref) {
    AsyncValue<List<Recipe>>? recipesFuture;
    if (recipesByCategoryFutureProvider != null) {
      recipesFuture = ref.watch(recipesByCategoryFutureProvider!);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (recipesFuture != null) ...[
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        recipesFuture.when(
            loading: () => const Text("Loading recipes..."),
            error: (err, stack) => const Text("Failed to load recipes!"),
            data: (recipes) => recipes.isEmpty
                ? const Text("No recipes available")
                : Expanded(
                    child: _buildVerticalViewWithShader(
                        _buildRecipesGridView(recipes)))),
      ]
    ]);
  }

  Widget _buildRecipesGridView(List<Recipe> recipes) {
    return GridView.extent(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        maxCrossAxisExtent: 350.0,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        children: recipes
            .map(
              (recipe) => RecipePreviewCard(recipe),
            )
            .toList());
  }

  Widget _buildVerticalViewWithShader(Widget childWidget) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double height = constraints.maxHeight;
      final double shaderStop = min(25.0 / height, 0.25);

      return ShaderMask(
          shaderCallback: (Rect rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [
                Colors.white,
                Colors.transparent,
                Colors.transparent,
                Colors.white
              ],
              stops: [0.0, shaderStop, 1 - shaderStop, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: childWidget);
    });
  }
}
