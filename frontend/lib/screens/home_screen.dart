import 'package:flutter/material.dart';
import 'package:tastymeals/widgets/home_widget.dart';
import 'package:tastymeals/widgets/screen_frame.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildScreenFrame(context, 0,
        Padding(padding: const EdgeInsets.all(18.0), child: HomeWidget()));
  }
}
