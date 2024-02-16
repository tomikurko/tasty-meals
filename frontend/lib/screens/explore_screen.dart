import 'package:flutter/material.dart';
import 'package:tastymeals/widgets/explore_widget.dart';
import 'package:tastymeals/widgets/screen_frame.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildScreenFrame(context, 2,
        Padding(padding: const EdgeInsets.all(18.0), child: ExploreWidget()));
  }
}
