import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget buildScreenFrame(
    BuildContext context, int selectedScreen, Widget bodyWidget) {
  return Scaffold(
    appBar: AppBar(title: const Text('Tasty Meals')),
    body: bodyWidget,
    bottomNavigationBar: NavigationBar(
      onDestinationSelected: (int index) {
        switch (index) {
          case 0:
            context.go("/");
          case 1:
            context.go("/categories");
          case 2:
            context.go("/explore");
          default:
            assert(false, "Unknown destination");
        }
      },
      destinations: const <Widget>[
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.category), label: "Categories"),
        NavigationDestination(icon: Icon(Icons.explore), label: "Explore"),
      ],
      selectedIndex: selectedScreen,
    ),
  );
}
