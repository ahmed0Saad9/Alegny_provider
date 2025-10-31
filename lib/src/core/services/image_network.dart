import 'package:Alegny_provider/src/GeneralWidget/Widgets/Loading/loading_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageNetwork extends StatelessWidget {
  final String? url;
  final double? width, height;
  final String defaultAvatar;
  final BoxFit boxFit;

  const ImageNetwork(
      {super.key,
      this.boxFit = BoxFit.cover,
      required this.url,
      required this.width,
      required this.height,
      this.defaultAvatar =
          'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height!.h,
      width: width!.w,
      imageUrl: url != null
          ? url!.isNotEmpty
              ? url!
              : defaultAvatar
          : defaultAvatar,
      fit: boxFit,
      errorWidget: (context, url, error) => CachedNetworkImage(
        height: height!.h,
        width: width!.w,
        imageUrl: defaultAvatar,
        fit: boxFit,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicatorWithValue(
          value: downloadProgress.progress,
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
