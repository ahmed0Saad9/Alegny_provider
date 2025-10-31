import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView(
      {super.key,
      required this.globalKey,
      required this.image,
      required this.description,
      required this.child,
      required this.shapeBorder});

  final GlobalKey globalKey;
  final String image;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      description: description,
      child: child,
      title: image,
      targetShapeBorder: shapeBorder,
    );
  }
}
