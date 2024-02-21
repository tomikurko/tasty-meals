import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/model/recipe.dart';

class RecipePreviewCard extends StatelessWidget {
  final Recipe recipe;

  RecipePreviewCard(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.amber[50],
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(children: [
              const Expanded(
                  child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Placeholder(
                          fallbackHeight: 100.0, fallbackWidth: 100.0))),
              const SizedBox(height: 12.0),
              TextButton(
                child: Text(recipe.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.amber, fontWeight: FontWeight.bold)),
                onPressed: () => context.go("/recipe/${recipe.id}"),
              )
            ])));
  }
}
