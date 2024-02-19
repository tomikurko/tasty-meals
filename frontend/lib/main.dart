import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastymeals/routes/router_config.dart';

void main() {
  runApp(ProviderScope(
      child: MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
              useMaterial3: true,
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: Colors.red)))));
}
