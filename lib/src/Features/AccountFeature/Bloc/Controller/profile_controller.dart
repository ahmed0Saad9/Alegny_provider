import 'dart:io';

import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Model/account_details_model.dart';
import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Repo/profile_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Controller/edit_general_profile_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/ImageViewer/image_viewer_list.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/pick_image.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/Network/network_exceptions.dart';

class ProfileController extends BaseController<ProfileRepo> {
  @override
  // TODO: implement repository
  get repository => sl<ProfileRepo>();

  String? _imageLocal;
  String? get imageLocal => _imageLocal;
  MediaType? _image;
  MediaType? get image => _image;

  void setImageFromGallery() async {
    File? image = await getImage(source: ImageSource.gallery);
    if (image != null) {
      _image = MediaType(media: image, type: EnumMediaType.image.name);
    }
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}
