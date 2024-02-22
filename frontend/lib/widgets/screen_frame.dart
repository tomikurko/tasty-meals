import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastymeals/widgets/breakpoints.dart';
import 'package:tastymeals/widgets/responsive_widget.dart';

class _Route {
  static const HOME = "/";
  static const CATEGORIES = "/categories";
  static const EXPLORE = "/explore";
  static const SEARCH = "/search";
}

Widget buildScreenFrame(BuildContext context,
    {required int selectedScreen,
    required bool scrollable,
    required Widget bodyWidget,
    TextEditingController? searchController}) {
  return Scaffold(
    appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(18.0),
            alignment: Alignment.center,
            child: ResponsiveWidget(
                desktop: Container(
                    constraints: const BoxConstraints(
                        maxWidth: Breakpoints.lg - 2 * 18.0),
                    child: Row(children: [
                      _buildAppTitle(),
                      const SizedBox(width: 48.0),
                      _buildTopBarLink("HOME", _Route.HOME, context),
                      _buildTopBarLink(
                          "CATEGORIES", _Route.CATEGORIES, context),
                      _buildTopBarLink("EXPLORE", _Route.EXPLORE, context),
                      const Spacer(),
                      MediaQuery.of(context).size.width > Breakpoints.md
                          ? SearchBar(
                              controller: searchController,
                              constraints: const BoxConstraints(
                                  maxWidth: 250.0, minHeight: 35.0),
                              leading: const Icon(Icons.search),
                              onSubmitted: (value) => context.go(
                                  "/search/${value.replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '')}"),
                            )
                          : IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () => context.go("/search"))
                    ])),
                mobile: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_buildAppTitle()])))),
    body: scrollable
        ? SingleChildScrollView(child: Center(child: bodyWidget))
        : Center(child: bodyWidget),
    bottomNavigationBar: ResponsiveWidget(
        desktop: const SizedBox.shrink(),
        mobile: NavigationBar(
          onDestinationSelected: (int index) {
            switch (index) {
              case 0:
                context.go(_Route.HOME);
              case 1:
                context.go(_Route.CATEGORIES);
              case 2:
                context.go(_Route.EXPLORE);
              case 3:
                context.go(_Route.SEARCH);
              default:
                assert(false, "Unknown destination");
            }
          },
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.category), label: "Categories"),
            NavigationDestination(icon: Icon(Icons.explore), label: "Explore"),
            NavigationDestination(icon: Icon(Icons.search), label: "Search"),
          ],
          selectedIndex: selectedScreen,
        )),
  );
}

Widget _buildAppTitle() {
  return Text('Tasty Meals',
      style: GoogleFonts.dancingScript(
          color: Colors.red[700], fontSize: 32, fontWeight: FontWeight.w900));
}

Widget _buildTopBarLink(String text, String route, BuildContext context) {
  return TextButton(
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.bold)),
      onPressed: () => context.go(route));
}
