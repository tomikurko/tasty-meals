import 'package:flutter/material.dart';
import 'package:tastymeals/widgets/categories_widget.dart';
import 'package:tastymeals/widgets/screen_frame.dart';

class CategoriesScreen extends StatelessWidget {
  int? selectedCategoryId;

  CategoriesScreen(this.selectedCategoryId);

  @override
  Widget build(BuildContext context) {
    return buildScreenFrame(
        context,
        1,
        Padding(
            padding: const EdgeInsets.all(18.0),
            child: CategoriesWidget(selectedCategoryId)));
  }
}
