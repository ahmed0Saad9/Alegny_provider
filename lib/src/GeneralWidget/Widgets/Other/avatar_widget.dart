import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/core/services/image_network.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.image,
    this.imageFile,
    this.height = 100,
    this.width = 95,
  });

  final String? image;
  final File? imageFile;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // radius: radius.r,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Colors.white,
      ),
      child: (imageFile == null && (image == null || image!.isEmpty))
          ? Image.asset(
              'assets/images/Profile.png',
              height: height.h,
              width: width.w,
              fit: BoxFit.cover,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: imageFile == null
                  ? ImageNetwork(
                      url: image,
                      height: height.h,
                      width: width.w,
                    )
                  : Image.file(
                      imageFile!,
                      height: height.h,
                      width: width.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.error_outline,
                      ),
                    ),
            ),
    );
  }
}
