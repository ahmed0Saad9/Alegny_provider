import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Loading/loading_dialog.dart';
import 'package:Alegny_provider/src/core/constants/app_assets.dart';
import 'package:Alegny_provider/src/core/services/video_viewer/video_viewer_screen.dart';

class ImageViewerList extends StatefulWidget {
  final List<ImageModel> images;
  final int index;

  const ImageViewerList({
    Key? key,
    required this.images,
    required this.index,
  }) : super(key: key);

  @override
  State<ImageViewerList> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewerList> {
  int oldIndex = 0;
  bool firstClick = false;
  PageController? pageController;

  @override
  void initState() {
    // TODO: implement initState
    oldIndex = widget.index;
    firstClick = true;
    pageController = PageController(keepPage: true, initialPage: widget.index);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            SizedBox(
                height: Get.height * 0.85,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    if (widget.images[index].type == EnumMediaType.image.name) {
                      return Dismissible(
                        key: Key(widget.images[index].fullUrl),
                        direction: DismissDirection.vertical,
                        onDismissed: (direction) {
                          // Handle swipe gesture, e.g., navigate back
                          Navigator.pop(context);
                        },
                        child: PhotoViewGallery(
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          pageOptions: [
                            PhotoViewGalleryPageOptions(
                              imageProvider: CachedNetworkImageProvider(
                                widget.images[index].fullUrl,
                              ),
                              minScale: PhotoViewComputedScale.contained,
                              maxScale: PhotoViewComputedScale.covered,
                            )
                          ],
                          loadingBuilder: (context, event) => SizedBox(
                            width: Get.width,
                            height: Get.height,
                            child: const Center(
                              child: Loader(),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return VideoViewerScreen(
                        url: widget.images[index].fullUrl,
                        showAppBar: false,
                      );
                    }
                  },
                  onPageChanged: onPageChange,
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.images.length,
                )),
            SafeArea(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              widget.images.isNotEmpty
                  ? SmoothPageIndicator(
                      controller: pageController!,
                      count: widget.images.length,
                      effect: SwapEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.white.withOpacity(0.5),
                          dotWidth: 8,
                          dotHeight: 8,
                          spacing: 2))
                  : Expanded(child: Container()),
            ]).paddingOnly(left: 16, right: 16))
          ],
        ),
      ),
    );
  }

  onPageChange(int index) {
    setState(() {
      oldIndex = index;
      firstClick = false;
    });
  }
}

class ImageModel {
  final int id;
  final String extension;
  final String humanReadableSize;
  final String fullUrl;
  final String type;

  const ImageModel({
    required this.id,
    required this.extension,
    required this.humanReadableSize,
    required this.fullUrl,
    required this.type,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    printDM("ImageModel json is $json");
    return ImageModel(
      id: json['id'] ?? 0,
      extension: json['extension'] ?? "",
      humanReadableSize: json['humanReadableSize'] ?? "",
      fullUrl: json['full_url'] ?? "",
      type: json['type'] ?? "",
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [id, extension, humanReadableSize, fullUrl];

  @override
  String toString() {
    return 'ImageModel{id: $id, extension: $extension, humanReadableSize: $humanReadableSize, fullUrl: $fullUrl, type: $type}';
  }
}

enum EnumMediaType {
  image,
  video,
}
