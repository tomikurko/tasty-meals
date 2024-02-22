import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/model/category.dart';
import 'package:tastymeals/routes/screen_route.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;
  final bool selected;

  CategoryListItem(this.category, this.selected);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: Border.all(),
        elevation: 1.0,
        color: Colors.white,
        surfaceTintColor: Colors.amber[50],
        child: ListTile(
            shape: Border.all(),
            leading:
                const AspectRatio(aspectRatio: 3 / 2, child: Placeholder()),
            title: Text(category.name),
            selected: selected,
            contentPadding: const EdgeInsets.all(18.0),
            hoverColor: Colors.amber[50],
            selectedTileColor: Colors.amber[100],
            onTap: () => context.go("${ScreenRoute.category}/${category.id}")));
  }
}
