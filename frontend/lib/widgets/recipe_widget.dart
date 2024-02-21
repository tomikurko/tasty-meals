import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/widgets/responsive_widget.dart';

class RecipeWidget extends ConsumerWidget {
  final AsyncValue<Recipe> recipeFuture;

  RecipeWidget(this.recipeFuture);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(clipBehavior: Clip.none, children: [
      Card(
          child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: _buildRecipeContents(context, ref)))
    ]);
  }

  Widget _buildRecipeContents(BuildContext context, WidgetRef ref) {
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
              Center(
                  child: Text(recipe.name,
                      style: Theme.of(context).textTheme.titleLarge)),
              const SizedBox(height: 32),
              const Placeholder(),
              const SizedBox(height: 32),
              ResponsiveWidget(
                  mobile: Column(children: [
                    _buildTable(context, "Ingredients", recipe.ingredients),
                    const SizedBox(height: 32),
                    _buildTable(context, "Steps", recipe.steps)
                  ]),
                  desktop: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: _buildTable(
                              context, "Ingredients", recipe.ingredients)),
                      const SizedBox(width: 18),
                      Expanded(
                          flex: 3,
                          child: _buildTable(context, "Steps", recipe.steps)),
                    ],
                  ))
            ]));
  }

  Widget _buildTable(BuildContext context, String title, List<String> items) {
    return Table(border: TableBorder.all(), children: <TableRow>[
      TableRow(
          decoration: const BoxDecoration(color: Colors.amber),
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 18.0),
                child: Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)))
          ]),
      ...items.map((item) => TableRow(
              decoration: const BoxDecoration(color: Colors.white70),
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(12.0), child: Text(item))
              ]))
    ]);
  }
}
