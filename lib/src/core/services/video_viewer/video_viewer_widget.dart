import 'dart:io';

import 'package:Alegny_provider/src/GeneralWidget/Widgets/Loading/loading_dialog.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/video_viewer/video_viewer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoViewerWidget extends StatelessWidget {
  final String url;
  final Color mainColor;
  final double radius;
  final File? file;
  final bool fromScreen;
  final bool fromAsset;

  VideoViewerWidget(
      {Key? key,
      this.file,
      required this.url,
      this.mainColor = AppColors.main,
      this.radius = 8,
      this.fromAsset = false,
      this.fromScreen = false})
      : super(key: key);

  final controller = Get.put(VideoViewerController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        tag: fromScreen ? 'full$url' : url,
        id: 'video',
        initState: (state) => controller.initVideo(url,
            file: file, localVideo: fromAsset, fullScreen: fromScreen),
        builder: (_) => InkWell(
              onTap: fromScreen ? null : () => controller.onItemSelect(url),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: Obx(
                      () => controller.videoLoaded.value
                          ? GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: controller.videoController!.value.isPlaying
                                  ? controller.videoController!.pause
                                  : null,
                              child: Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: controller
                                            .videoController!.value.aspectRatio,
                                        child: VideoPlayer(
                                          controller.videoController!,
                                          // controller: controller.videoController!,
                                          // aspectRatio: 16 / 9,
                                          // backgroundColor: kBlack33,
                                        ),
                                      ),
                                      Positioned.fill(
                                          child: Stack(
                                        children: [
                                          Offstage(
                                            offstage: controller
                                                .showPlayingIcon.value,
                                            child: Container(
                                              alignment: Alignment.center,
                                              color: Colors.black38,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.videoController!
                                                      .play();
                                                },
                                                child: const Icon(
                                                    Icons.play_arrow_rounded,
                                                    color: Colors.white,
                                                    size: 120),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: SizedBox(
                                                  height: 15,
                                                  child: VideoProgressIndicator(
                                                      controller
                                                          .videoController!,
                                                      allowScrubbing: true))),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const Center(child: Loader()),
                    ) /*YoutubePlayer(
                  controller: controller.videoController!,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: mainColor,
                  progressColors: ProgressBarColors(
                    playedColor: mainColor,
                    handleColor: mainColor.withOpacity(0.8),
                  ),
                )*/
                    ,
                  ),
                  if (!fromScreen)
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  if (!fromScreen)
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.9)),
                          child: const Icon(
                            Icons.play_circle_outline,
                            color: Colors.grey,
                          )),
                    ),
                ],
              ),
            ));
  }
}
