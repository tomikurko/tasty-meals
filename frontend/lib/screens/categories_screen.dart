import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/category.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/model/screen_index.dart';
import 'package:tastymeals/providers/category_future_provider.dart';
import 'package:tastymeals/providers/recipes_by_category_future_provider.dart';
import 'package:tastymeals/widgets/breakpoints.dart';
import 'package:tastymeals/widgets/categories_widget.dart';
import 'package:tastymeals/widgets/screen_frame.dart';

class CategoriesScreen extends ConsumerWidget {
  int? selectedCategoryId;
  final FutureProvider<Category>? categoryFutureProvider;
  final FutureProvider<List<Recipe>>? recipesByCategoryFutureProvider;

  CategoriesScreen(this.selectedCategoryId)
      : categoryFutureProvider = selectedCategoryId != null
            ? getCategoryFutureProvider(selectedCategoryId)
            : null,
        recipesByCategoryFutureProvider = selectedCategoryId != null
            ? getRecipesByCategoryFutureProvider(selectedCategoryId)
            : null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryFuture = categoryFutureProvider != null
        ? ref.watch(categoryFutureProvider!)
        : null;
    final recipesFuture = recipesByCategoryFutureProvider != null
        ? ref.watch(recipesByCategoryFutureProvider!)
        : null;

    final screenHeight = MediaQuery.of(context).size.height;
    const bodyMinHeight = 500.0;
    const screenHeightThresholdForBodyScrolling = bodyMinHeight + topBarHeight;

    return buildScreenFrame(context,
        selectedScreen: ScreenIndex.categories,
        scrollable: screenHeight < screenHeightThresholdForBodyScrolling,
        bodyWidget: Container(
            constraints: BoxConstraints(
                maxWidth: Breakpoints.lg,
                maxHeight: screenHeight < screenHeightThresholdForBodyScrolling
                    ? bodyMinHeight
                    : double.infinity),
            child: CategoriesWidget(
                selectedCategoryId, categoryFuture, recipesFuture)));
  }
}
