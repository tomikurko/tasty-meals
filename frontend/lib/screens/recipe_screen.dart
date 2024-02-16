import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/widgets/recipe_widget.dart';
import 'package:tastymeals/widgets/screen_frame.dart';
import 'package:tastymeals/providers/recipe_future_provider.dart';

class RecipeScreen extends ConsumerWidget {
  int recipeId;
  final FutureProvider<Recipe> recipeFutureProvider;

  RecipeScreen(this.recipeId)
      : recipeFutureProvider = getRecipeFutureProvider(recipeId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeFuture = ref.watch(recipeFutureProvider);

    return buildScreenFrame(
        context,
        1,
        Padding(
            padding: const EdgeInsets.all(18.0),
            child: RecipeWidget(recipeFuture)));
  }
}
