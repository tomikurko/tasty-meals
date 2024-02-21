import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/model/category.dart';

class CategoryPreviewCard extends StatelessWidget {
  final Category category;

  CategoryPreviewCard(this.category);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.amber[50],
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Expanded(
                    child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Placeholder(
                            fallbackHeight: 100.0, fallbackWidth: 100.0))),
                const SizedBox(height: 12.0),
                TextButton(
                  child: Text(category.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.amber, fontWeight: FontWeight.bold)),
                  onPressed: () => context.go("/category/${category.id}"),
                ),
                if (category.numRecipes != null) ...[
                  const SizedBox(height: 12.0),
                  Text("${category.numRecipes} recipes",
                      style: Theme.of(context).textTheme.bodyMedium)
                ]
              ],
            )));
  }
}
