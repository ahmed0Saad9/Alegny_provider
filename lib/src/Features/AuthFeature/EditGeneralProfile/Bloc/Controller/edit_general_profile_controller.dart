import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Params/edit_general_profile_params.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Repo/efit_profile_repo.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Model/company_category_model.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Model/nationality_model.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Model/simple_model.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Model/user_model.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/ImageViewer/image_viewer_list.dart';
import 'package:Alegny_provider/src/core/constants/app_assets.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/pick_image.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class EditProfileController
    extends BaseController<EditGeneralProfileRepository> {
  @override
  // TODO: implement repository
  get repository => sl<EditGeneralProfileRepository>();
  TextEditingController? firstNameController;
  TextEditingController? familyNameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;

  bool dataModifiedSuccessfully = false;
  void modifiesData() {
    dataModifiedSuccessfully = true;
    update();
  }

  // int _cityId = 0;
  //
  // int get cityId => _cityId;
  //
  // void selectCity(CountryModel country) {
  //   cityController!.text = country.title;
  //   _cityId = country.id;
  //   update();
  // }

  String? fileName;
  String? fileExtension;
  double? fileSize;
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      fileName = file.name;
      fileExtension = file.extension;
      fileSize = file.size / 1024; // Extract the file size in bytes
      update();
    }
  }

  // Clear the file data from GetStorage (if needed)
  void clearFile() {
    fileName = null;
    fileExtension = null;
    fileSize = null;
    update();
  }

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

  // int _countryId = 0;
  //
  // int get countryId => _countryId;
  //
  // void selectCountry(CountryModel country) {
  //   countryController!.text = country.title;
  //   _countryId = country.id;
  //   update();
  // }
  //
  // String activitySelected = '';
  //
  // void selectActivity(SimpleModel v) {
  //   activitySelected = v.id;
  //   activityController!.text = v.title.tr;
  //
  //   update();
  // }

  // int _companyCategoryId = 0;
  //
  // int get companyCategoryId => _companyCategoryId;
  //
  // void selectCompanyCategory(CategoryModel activity) {
  //   companyCategoryController!.text = activity.name;
  //   _companyCategoryId = activity.id;
  //   update();
  // }

  // // Merchant
  // int _merchantCategory = 0;
  //
  // int get merchantCategory => _merchantCategory;
  //
  // void selectMerchantCategory(CategoryModel category) {
  //   merchantCategoryController!.text = category.name;
  //   _merchantCategory = category.id;
  //   update();
  // }
  //
  // final List<int> _merchantCitiesIds = [];
  //
  // List<int> get merchantCitiesIds => _merchantCitiesIds;
  //
  // void selectMerchantCitiesIds(List<CountryModel> countries) {
  //   _merchantCitiesIds.clear();
  //
  //   for (var item in countries) {
  //     _merchantCitiesIds.add(item.id);
  //   }
  //   merchantCitiesController!.text =
  //       countries.map((e) => e.title).toList().toString();
  //   printDM('_merchantCitiesIds is < $countries');
  //   printDM('_merchantCitiesIds is $_merchantCitiesIds');
  //   update();
  // }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  // final GetMyAccountDataRepository _getMyAccountDataRepo =
  // sl<GetMyAccountDataRepository>();
  UserModel? _user;

  Future<void> _getMyAccountData() async {
    // showLoading();
    // update();
    // var result = await _getMyAccountDataRepo.getMyAccountData();
    // result.when(success: (Response response) {
    //   // _user = UserModel.fromJson(response.data['data'][0]);
    //   _initData();
    //   doneLoading();
    //   update();
    // }, failure: (NetworkExceptions error) {
    //   status = actionNetworkExceptions(error);
    //   update();
    // });
  }

  // void editProfile() async {
  //   if (globalKey.currentState!.validate()) {
  //     globalKey.currentState!.save();
  //     showEasyLoading();
  //     var result = await repository!.updateProfile(
  //       param: EditProfileParam(
  //         // image: _image,
  //         name: fullNameController!.text,
  //         mobile: phoneController!.text,
  //         email: emailController!.text,
  //         role: activitySelected,
  //         cityId: _countryId,
  //         address: addressController!.text,
  //         description: descriptionController!.text,
  //         companyCategoryId: _companyCategoryId,
  //         merchantCategoryId: _merchantCategory,
  //         merchantCitiesIds: _merchantCitiesIds,
  //         deviceToken: '',
  //       ),
  //     );
  //     closeEasyLoading();
  //     result.when(success: (Response response) {
  //       // _user = UserModel.fromJson(response.data['data'][0]);
  //       // LocalStorageCubit().saveItem(key: 'avatar',item: _user!.image);
  //       successEasyLoading(response.data['message'] ?? "success");
  //       // Get.offAll(() => const BaseBNBScreen());
  //     }, failure: (NetworkExceptions error) {
  //       actionNetworkExceptions(error);
  //     });
  //   }
  // }

  @override
  void onInit() {
    initTextEditingController();
    _getMyAccountData();
    super.onInit();
  }

  void _initData() {
    // Role
    // activitySelected = _user!.role.toLowerCase();
    // activityController = TextEditingController(text:activitySelected.tr);
    // // General
    // _imageLocal= _user!.image;
    // if(_user!.phone.startsWith('+2')){
    // phoneController = TextEditingController(text: _user!.phone.replaceFirst("+2", ""));
    // }else{
    // phoneController = TextEditingController(text: _user!.phone);
    // }
    // nameController = TextEditingController(text: _user!.name);
    // emailController = TextEditingController(text: _user!.email);
    // descriptionController = TextEditingController(text: _user!.details);
    //
    // if(activitySelected ==EnumProfileRole.company.name){
    // addressController = TextEditingController(text: _user!.companyDetails!.address);
    // companyCategoryController = TextEditingController(text: _user!.companyDetails!.companyCategory.name);
    // _companyCategoryId = _user!.companyDetails!.companyCategory.id;
    // if(_user!.companyDetails!.city!=null){
    // countryController = TextEditingController(text: _user!.companyDetails!.city!.name);
    // _countryId = _user!.companyDetails!.city!.id;
    // }
    // }
    //
    // merchantCategoryController = TextEditingController();
    // merchantCitiesController = TextEditingController();
  }

  void initTextEditingController() {
    firstNameController = TextEditingController();
    familyNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
  }
}

class MediaType extends Equatable {
  final File media;
  final String type;

  const MediaType({required this.media, required this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [media, type];
}
