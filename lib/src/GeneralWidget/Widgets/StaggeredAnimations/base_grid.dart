import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/constants/duration.dart';

class BaseItemBuilderGrid extends StatelessWidget {
  final Widget child;
  final int index;
  final int columnCount;

  const BaseItemBuilderGrid(
      {Key? key,
      required this.child,
      required this.index,
      required this.columnCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration:  AppDuration.animationDuration,
      columnCount: columnCount,
      child: SlideAnimation(
        verticalOffset: 50.0,
        // curve: Curves.bounceIn,
        horizontalOffset: 0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
