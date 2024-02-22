import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/providers/random_recipe_future_provider.dart';
import 'package:tastymeals/widgets/breakpoints.dart';
import 'package:tastymeals/widgets/explore_widget.dart';
import 'package:tastymeals/widgets/screen_frame.dart';

class ExploreScreen extends ConsumerWidget {
  bool refreshed;

  ExploreScreen() : refreshed = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!refreshed) {
      ref.refresh(randomRecipeFutureProvider);
      refreshed = true;
    }

    return buildScreenFrame(context,
        selectedScreen: 2,
        scrollable: true,
        bodyWidget: Container(
            constraints: const BoxConstraints(maxWidth: Breakpoints.lg),
            child: ExploreWidget()));
  }
}
