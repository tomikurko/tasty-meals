import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/providers/random_recipe_future_provider.dart';
import 'package:tastymeals/widgets/recipe_widget.dart';

class ExploreWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeFuture = ref.watch(randomRecipeFutureProvider);

    return RecipeWidget(recipeFuture);
  }
}
