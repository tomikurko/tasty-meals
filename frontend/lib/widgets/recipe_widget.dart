import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/recipe.dart';

class RecipeWidget extends ConsumerWidget {
  final AsyncValue<Recipe> recipeFuture;

  RecipeWidget(this.recipeFuture);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return recipeFuture.when(
        loading: () => const Text("Loading recipe..."),
        error: (err, stack) {
          print("Failed to load a recipe!");
          print("err: $err");
          print("stack: $stack");

          return const Text("Failed to load a recipe!");
        },
        data: (recipe) =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(recipe.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 32),
              const Placeholder(),
              const SizedBox(height: 32),
              Text("Ingredients",
                  style: Theme.of(context).textTheme.titleMedium),
              ...recipe.ingredients.expand((ingredient) =>
                  [const SizedBox(height: 10), Text("- $ingredient")]),
              const SizedBox(height: 32),
              Text("Steps", style: Theme.of(context).textTheme.titleMedium),
              ...recipe.steps.expand(
                  (step) => [const SizedBox(height: 10), Text("- $step")])
            ]));
  }
}
