import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastymeals/widgets/breakpoints.dart';
import 'package:tastymeals/widgets/screen_frame.dart';
import 'package:tastymeals/widgets/search_results_widget.dart';

class SearchScreen extends StatelessWidget {
  final String searchString;
  final TextEditingController searchController;

  SearchScreen(this.searchString)
      : searchController = TextEditingController(text: searchString);

  @override
  Widget build(BuildContext context) {
    return buildScreenFrame(context,
        selectedScreen: 3,
        scrollable: false,
        searchController: searchController,
        bodyWidget: Container(
            constraints: const BoxConstraints(maxWidth: Breakpoints.lg),
            child: Card(
                margin: const EdgeInsets.all(18.0),
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: MediaQuery.of(context).size.width > Breakpoints.md
                        ? SearchResultsWidget(searchString)
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
                                      "/search/${value.replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '')}"),
                                ),
                                const SizedBox(height: 38.0),
                                Expanded(
                                    child: SearchResultsWidget(searchString))
                              ])))));
  }
}
