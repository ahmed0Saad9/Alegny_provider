import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/core/services/image_network.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.image,
    this.imageFile,
    this.height = 200,
    this.width = 150,
  });

  final String? image;
  final File? imageFile;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        height: height.h,
        width: width.h,
        fit: BoxFit.cover,
      );
    }

    if (image != null && image!.isNotEmpty) {
      return ImageNetwork(
        url: image,
        height: height.h,
        width: width.h,
        boxFit: BoxFit.contain,
      );
    }

    // Fallback to default profile image
    return Image.asset(
      'assets/images/Profile.png',
      height: height.h,
      width: width.h,
      fit: BoxFit.cover,
    );
  }
}
