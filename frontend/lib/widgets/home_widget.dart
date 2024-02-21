import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/model/category.dart';
import 'package:tastymeals/providers/all_categories_future_provider.dart';
import 'package:tastymeals/providers/latest_recipe_future_provider.dart';
import 'package:tastymeals/providers/top_categories_future_provider.dart';
import 'package:tastymeals/widgets/category_preview_card.dart';
import 'package:tastymeals/widgets/recipe_preview_card.dart';

class HomeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(clipBehavior: Clip.none, children: [
      _buildLatestRecipe(context, ref),
      const SizedBox(height: 16),
      _buildTopRecipeCategories(context, ref),
      const SizedBox(height: 16),
      _buildAllRecipeCategories(context, ref),
    ]);
  }

  Widget _buildLatestRecipe(BuildContext context, WidgetRef ref) {
    final latestRecipeFuture = ref.watch(latestRecipeFutureProvider);

    return Card(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Latest recipe",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              latestRecipeFuture.when(
                  loading: () => const Text("Loading latest recipe..."),
                  error: (err, stack) =>
                      const Text("Failed to load latest recipe!"),
                  data: (recipe) => Container(
                      height: 250,
                      alignment: Alignment.center,
                      child: RecipePreviewCard(recipe)))
            ])));
  }

  Widget _buildTopRecipeCategories(BuildContext context, WidgetRef ref) {
    final topCategoriesFuture = ref.watch(topCategoriesFutureProvider);

    return Card(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Top categories",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              topCategoriesFuture.when(
                  loading: () => const Text("Loading top categories..."),
                  error: (err, stack) =>
                      const Text("Failed to load top categories!"),
                  data: (categories) => categories.isEmpty
                      ? const Text("No top categories available")
                      : _buildCategoriesList(categories, 250))
            ])));
  }

  Widget _buildAllRecipeCategories(BuildContext context, WidgetRef ref) {
    final allCategoriesFuture = ref.watch(allCategoriesFutureProvider);

    return Card(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("All categories",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              allCategoriesFuture.when(
                  loading: () => const Text("Loading categories..."),
                  error: (err, stack) =>
                      const Text("Failed to load categories!"),
                  data: (categories) => categories.isEmpty
                      ? const Text("No categories available")
                      : _buildCategoriesList(categories, 200))
            ])));
  }
}

Widget _buildCategoriesList(List<Category> categories, double height) {
  return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: ShaderMask(
          shaderCallback: (Rect rect) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.white,
                Colors.transparent,
                Colors.transparent,
                Colors.white,
              ],
              stops: [0.0, 0.05, 0.95, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 24.0),
              children: categories
                  .expand((category) => [
                        CategoryPreviewCard(category),
                        const SizedBox(width: 24.0)
                      ])
                  .toList())));
}
