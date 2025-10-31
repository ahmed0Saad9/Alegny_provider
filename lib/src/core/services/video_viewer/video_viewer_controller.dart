import 'dart:io';

import 'package:Alegny_provider/src/core/constants/app_assets.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/video_viewer/video_viewer_screen.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoViewerController extends BaseController {
  @override
  @override
  // TODO: implement repository
  get repository => throw UnimplementedError();

  var videoLoaded = false.obs;
  var showPlayingIcon = false.obs;

  ///lifecycle ***************************************
  @override
  onClose() {
    videoLoaded.value = false;
    videoController!.dispose();
    update();
  }

  ///Data ********************************************
  VideoPlayerController? videoController;

  ///listener ***************************************
  onItemSelect(String url) {
    Get.to(() => VideoViewerScreen(url: url));
  }

  ///logic ******************************************
  initVideo(String url,
      {bool? fullScreen, File? file, bool localVideo = false}) {
    // var videoId = AppUtils.randomTag;
    if (localVideo) {
      videoController = VideoPlayerController.file(file!)
        ..addListener(() {
          showPlayingIcon.value = videoController!.value.isPlaying;
          if (videoController!.value.isPlaying) {
            videoLoaded.value = true;
          }
          printDM(
              '*********************************************************\nlistener called\n*********************************************************\n');
        })
        ..initialize().then((value) {
          videoLoaded.value = true;
          // videoController!.play();
        });
    } else {
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(url),
      )
        ..addListener(() {
          showPlayingIcon.value = videoController!.value.isPlaying;
          if (videoController!.value.isPlaying) {
            videoLoaded.value = true;
          }
          printDM(
              '*********************************************************\nlistener called\n*********************************************************\n');
        })
        ..initialize().then((value) {
          videoLoaded.value = true;
          update();
          // videoController!.play();
        });
    }

    // YoutubePlayerController(
    //   params: YoutubePlayerParams(
    //     loop: fullScreen!,
    //     mute: false,
    //     showFullscreenButton: fullScreen,
    //     showControls: fullScreen,
    //   ),
    // )..onInit = (){
    //   // if(autoPlay) {
    //   //   videoController?.loadVideoById(videoId: 'K18cpp_-gP8', startSeconds: 30);
    //   // } else {
    //     videoController?.cueVideoById(videoId: AppUtils.getYoutubeVideoIdByURL(url)?? '');
    //   // }
    // };
  }
}
