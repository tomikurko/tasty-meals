import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/providers/recipes_by_name_future_provider.dart';
import 'package:tastymeals/widgets/recipe_preview_card.dart';

class SearchResultsWidget extends ConsumerWidget {
  final String searchString;
  final FutureProvider<List<Recipe>> recipesByNameFutureProvider;

  SearchResultsWidget(this.searchString)
      : recipesByNameFutureProvider =
            getRecipesByNameFutureProvider(searchString);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildRecipes(
        searchString.isEmpty
            ? "All recipes"
            : 'Search results for "$searchString"',
        context,
        ref);
  }

  Widget _buildRecipes(String title, BuildContext context, WidgetRef ref) {
    final recipesFuture = ref.watch(recipesByNameFutureProvider);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      recipesFuture.when(
          loading: () => const Text("Searching recipes..."),
          error: (err, stack) => const Text("Failed to search recipes!"),
          data: (recipes) => recipes.isEmpty
              ? const Text("No recipes found!")
              : Expanded(
                  child: _buildVerticalViewWithShader(
                      _buildRecipesGridView(recipes)))),
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
