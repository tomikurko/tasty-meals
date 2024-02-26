import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tastymeals/routes/router_config.dart';

void main() {
  runApp(ProviderScope(
      child: MaterialApp.router(
          title: "Tasty Meals",
          routerConfig: router,
          theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
              textTheme: TextTheme(
                  titleLarge: GoogleFonts.lora(
                      fontSize: 28, fontWeight: FontWeight.bold))))));
}
