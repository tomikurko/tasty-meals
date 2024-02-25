import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/model/recipe.dart';
import 'package:tastymeals/model/screen_index.dart';
import 'package:tastymeals/providers/recipes_by_name_future_provider.dart';
import 'package:tastymeals/routes/screen_route.dart';
import 'package:tastymeals/widgets/breakpoints.dart';
import 'package:tastymeals/widgets/screen_frame.dart';
import 'package:tastymeals/widgets/search_results_widget.dart';

class SearchScreen extends ConsumerWidget {
  final String searchString;
  final FutureProvider<List<Recipe>> recipesByNameFutureProvider;
  final TextEditingController searchController;

  SearchScreen(this.searchString)
      : searchController = TextEditingController(text: searchString),
        recipesByNameFutureProvider =
            getRecipesByNameFutureProvider(searchString);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesFuture = ref.watch(recipesByNameFutureProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    const bodyMinHeight = 500.0;
    const screenHeightThresholdForBodyScrolling = bodyMinHeight + topBarHeight;

    return buildScreenFrame(context,
        selectedScreen: ScreenIndex.search,
        scrollable: screenHeight < screenHeightThresholdForBodyScrolling,
        searchController: searchController,
        bodyWidget: Container(
            constraints: BoxConstraints(
                maxWidth: Breakpoints.lg,
                maxHeight: screenHeight < screenHeightThresholdForBodyScrolling
                    ? bodyMinHeight
                    : double.infinity),
            child: Card(
                margin: const EdgeInsets.all(18.0),
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: MediaQuery.of(context).size.width > Breakpoints.md
                        ? SearchResultsWidget(searchString, recipesFuture)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                const SizedBox(height: 18.0),
                                SearchBar(
                                  controller: searchController,
                                  constraints: const BoxConstraints(
                                      maxWidth: 300.0, minHeight: 35.0),
                                  leading: const Icon(Icons.search),
                                  onSubmitted: (value) => context.go(
                                      "${ScreenRoute.search}/${value.replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '')}"),
                                ),
                                const SizedBox(height: 38.0),
                                Expanded(
                                    child: SearchResultsWidget(
                                        searchString, recipesFuture))
                              ])))));
  }
}
