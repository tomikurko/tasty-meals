import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/providers/latest_recipe_future_provider.dart';
import 'package:tastymeals/providers/top_categories_future_provider.dart';

class HomeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _buildLatestRecipe(context, ref),
      const SizedBox(height: 16),
      _buildTopRecipeCategories(context, ref),
      const SizedBox(height: 16),
      _buildAllRecipeCategories(context, ref),
    ]));
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
                  error: (err, stack) {
                    print("Failed to load latest recipe!");
                    print("err: $err");
                    print("stack: $stack");

                    return const Text("Failed to load latest recipe!");
                  },
                  data: (recipe) => TextButton(
                      child: Text(recipe.name),
                      onPressed: () => context.go("/recipe/${recipe.id}"))),
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
              ...topCategoriesFuture.when(
                  loading: () => [const Text("Loading top categories...")],
                  error: (err, stack) =>
                      [const Text("Failed to load top categories!")],
                  data: (categories) => categories.isEmpty
                      ? [const Text("No top categories available")]
                      : categories.expand((category) => [
                            TextButton(
                              child: Text(
                                  "${category.name}: ${category.numRecipes} recipes"),
                              onPressed: () =>
                                  context.go("/category/${category.id}"),
                            ),
                          ]))
            ])));
  }

  Widget _buildAllRecipeCategories(BuildContext context, WidgetRef ref) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("All categories",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextButton(
                child: const Text("Go to categories page"),
                onPressed: () => context.go("/categories"),
              )
            ])));
  }
}
