import 'package:flutter/material.dart';
import 'package:tastymeals/model/screen_index.dart';
import 'package:tastymeals/widgets/breakpoints.dart';
import 'package:tastymeals/widgets/categories_widget.dart';
import 'package:tastymeals/widgets/screen_frame.dart';

class CategoriesScreen extends StatelessWidget {
  int? selectedCategoryId;

  CategoriesScreen(this.selectedCategoryId);

  @override
  Widget build(BuildContext context) {
    return buildScreenFrame(context,
        selectedScreen: ScreenIndex.categories,
        scrollable: false,
        bodyWidget: Container(
            constraints: const BoxConstraints(maxWidth: Breakpoints.lg),
            child: CategoriesWidget(selectedCategoryId)));
  }
}
