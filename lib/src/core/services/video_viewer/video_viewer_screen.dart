import 'dart:io';

import 'package:Alegny_provider/src/core/services/video_viewer/video_viewer_widget.dart';
import 'package:flutter/material.dart';

class VideoViewerScreen extends StatelessWidget {
  final String url;
  final bool showAppBar;
  final bool fromLocal;
  final File? file;
  const VideoViewerScreen(
      {Key? key,
      this.file,
      this.fromLocal = false,
      required this.url,
      this.showAppBar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      backgroundColor: Colors.black,
      body: Center(
          child: VideoViewerWidget(
        url: url,
        file: file,
        fromAsset: fromLocal,
        radius: 0,
        fromScreen: true,
      )),
    );
  }
}
