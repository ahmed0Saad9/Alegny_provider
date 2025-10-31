import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> getImage({required ImageSource source }) async {
  try {
    final image = await ImagePicker().pickImage(source:source);
    if (image == null) return null;
    return File(image.path);
  } on PlatformException catch (e) {
    debugPrint("field picked image $e");
  }
  return null;
}
Future<File?> getVideo({required ImageSource source }) async {
  try {
    final video = await ImagePicker().pickVideo(source:source);
    if (video == null) return null;
    return File(video.path);
  } on PlatformException catch (e) {
    debugPrint("field picked image $e");
  }
  return null;
}



Future<List<File>> getImagesFromGallery() async {
  List<File> images = [];
  try {
    final List<XFile> selectedImages = await ImagePicker().pickMultiImage();

      for (var item in selectedImages) {
        images.add(File(item.path));
      }
      return images;

  } on PlatformException catch (e) {
    debugPrint("field picked image $e");
  }
  return [];
}
