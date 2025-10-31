import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Loading/loading_dialog.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

class ImageViewer extends StatelessWidget {
  final String? imageUrl;

  final bool? local;

  final File? file;

  const ImageViewer({Key? key, this.imageUrl, this.local = false, this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child:
                    const Icon(Icons.arrow_back_ios, color: AppColors.iconWight)
                        .paddingSymmetric(horizontal: 15, vertical: 10)),
            Expanded(
              child: local!
                  ? PhotoView(
                      loadingBuilder: (_, __) => const Center(child: Loader()),
                      imageProvider: FileImage(file!))
                  : PhotoView(
                      loadingBuilder: (_, __) => const Center(child: Loader()),
                      imageProvider: NetworkImage(imageUrl!)),
            ),
          ],
        ).paddingSymmetric(vertical: 20),
      ),
    );
  }
}
