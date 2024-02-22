import 'package:flutter/material.dart';
import 'package:tastymeals/model/screen_index.dart';
import 'package:tastymeals/widgets/breakpoints.dart';
import 'package:tastymeals/widgets/home_widget.dart';
import 'package:tastymeals/widgets/screen_frame.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildScreenFrame(context,
        selectedScreen: ScreenIndex.home,
        scrollable: true,
        bodyWidget: Container(
            constraints: const BoxConstraints(maxWidth: Breakpoints.lg),
            child: HomeWidget()));
  }
}
