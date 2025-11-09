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
    // Debug prints
    print('=== AvatarWidget Debug ===');
    print('Image URL: $image');
    print('Image File: $imageFile');
    print('Image is null: ${image == null}');
    print('Image is empty: ${image?.isEmpty ?? true}');

    return Container(
      height: height.h,
      width: width.h, // Changed from width.w to height.h for circle
      decoration: const BoxDecoration(
        shape: BoxShape.circle, // Use circle for perfect circle
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
      print('Loading network image: $image');
      return ImageNetwork(
        url: image,
        height: height.h,
        width: width.h,
        boxFit: BoxFit.cover,
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
