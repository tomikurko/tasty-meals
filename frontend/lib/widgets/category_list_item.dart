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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        surfaceTintColor: Colors.amber[50],
        child: ListTile(
            leading:
                const AspectRatio(aspectRatio: 3 / 2, child: Placeholder()),
            title: Text(category.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            selected: selected,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.all(18.0),
            horizontalTitleGap: 25.0,
            hoverColor: Colors.amber[50],
            selectedTileColor: Colors.amber[100],
            onTap: () => context.go("${ScreenRoute.category}/${category.id}")));
  }
}
