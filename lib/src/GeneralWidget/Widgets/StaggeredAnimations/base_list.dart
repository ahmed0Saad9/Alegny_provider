

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/constants/duration.dart';

class BaseItemBuilderList extends StatelessWidget {
  final Widget child;
  final int index;

  const BaseItemBuilderList({Key? key, required this.child, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   AnimationConfiguration.staggeredList(
      position: index,
      duration:  AppDuration.animationDuration,
      child: SlideAnimation(
        verticalOffset: 50.0,
        // curve: Curves.easeOut,
        horizontalOffset: 0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
