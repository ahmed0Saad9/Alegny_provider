import 'package:Alegny_provider/src/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AssetSvg extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit fit;

  const AssetSvg(
    this.imagePath, {
    Key? key,
    this.color,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/$imagePath.svg',
      color: color,
      width: width,
      height: height,
      fit: fit,
    );
  }
}

class IconPng extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double size;

  const IconPng(
    this.imagePath, {
    Key? key,
    this.color,
    this.height,
    this.width,
    this.size = 14,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/$imagePath.png',
      color: color,
      width: width == null ? size.w : width!.w,
      height: height == null ? size.w : height!.h,
      fit: fit,
    );
  }
}

class IconSvg extends StatelessWidget {
  final String iconPath;
  final Color? color;
  final double size;
  final double? width;
  final double? height;
  final BoxFit boxFit;

  const IconSvg(
    this.iconPath, {
    Key? key,
    this.color,
    this.size = 27,
    this.width,
    this.height,
    this.boxFit = BoxFit.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconPath.svg',
      color: color,
      width: width == null ? size.w : width!.w,
      height: height == null ? size.w : height!.h,
      fit: boxFit,
      cacheColorFilter: false,
      // matchTextDirection: true,
    );
  }
}

String getImageType(String imageUrl) {
  // Get the file extension from the URL
  String extension = imageUrl.split('.').last.toLowerCase();

  // Determine the image type based on the file extension
  if (extension == 'png') {
    return EnumImageType.png.name;
  } else if (extension == 'svg') {
    return EnumImageType.svg.name;
  } else {
    return extension; // Return 'Unknown' for unsupported formats
  }
}
