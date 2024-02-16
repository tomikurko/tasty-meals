import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/providers/latest_recipe_future_provider.dart';
import 'package:tastymeals/providers/top_categories_future_provider.dart';

class HomeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestRecipeFuture = ref.watch(latestRecipeFutureProvider);
    final topCategoriesFuture = ref.watch(topCategoriesFutureProvider);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Latest recipe: "),
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
      const SizedBox(height: 16),
      const Text("Top recipe categories: "),
      ...topCategoriesFuture.when(
          loading: () => [const Text("Loading top categories...")],
          error: (err, stack) => [const Text("Failed to load top categories!")],
          data: (categories) => categories.isEmpty
              ? [const Text("No top categories available")]
              : categories.expand((category) => [
                    TextButton(
                      child: Text(
                          "${category.name}: ${category.numRecipes} recipes"),
                      onPressed: () => context.go("/category/${category.id}"),
                    ),
                  ])),
      const SizedBox(height: 16),
      TextButton(
        child: const Text("All recipe categories"),
        onPressed: () => context.go("/categories"),
      ),
    ]);
  }
}
