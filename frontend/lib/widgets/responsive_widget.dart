import 'package:flutter/material.dart';
import 'package:tastymeals/widgets/breakpoints.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveWidget({required this.mobile, required this.desktop});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width < Breakpoints.sm
        ? mobile
        : desktop;
  }
}
