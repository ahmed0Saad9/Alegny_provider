import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewPhoto extends StatelessWidget {
  final List<String> photos;
  const ViewPhoto({Key? key,required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
        children: photos.map((e) => PhotoView(imageProvider: NetworkImage(e)),).toList()
    );
  }
}
