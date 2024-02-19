import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastymeals/widgets/breakpoints.dart';
import 'package:tastymeals/widgets/responsive_widget.dart';

class _Route {
  static const HOME = "/";
  static const CATEGORIES = "/categories";
  static const EXPLORE = "/explore";
}

Widget buildScreenFrame(
    BuildContext context, int selectedScreen, Widget bodyWidget) {
  return Scaffold(
    appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(18.0),
            alignment: Alignment.center,
            child: ResponsiveWidget(
                desktop: Container(
                    constraints: const BoxConstraints(maxWidth: Breakpoints.lg),
                    child: Row(children: [
                      _buildAppTitle(),
                      const SizedBox(width: 48.0),
                      _buildTopBarLink("HOME", _Route.HOME, context),
                      _buildTopBarLink(
                          "CATEGORIES", _Route.CATEGORIES, context),
                      _buildTopBarLink("EXPLORE", _Route.EXPLORE, context),
                    ])),
                mobile: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_buildAppTitle()])))),
    body: Center(
        child: Container(
            constraints: const BoxConstraints(maxWidth: Breakpoints.md),
            child: bodyWidget)),
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
              default:
                assert(false, "Unknown destination");
            }
          },
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.category), label: "Categories"),
            NavigationDestination(icon: Icon(Icons.explore), label: "Explore"),
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
