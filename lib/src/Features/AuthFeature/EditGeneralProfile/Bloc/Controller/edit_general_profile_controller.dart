import 'dart:io';

import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Repo/account_details_repo.dart';
import 'package:Alegny_provider/src/core/utils/storage_util.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
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

import '../../../../BaseBNBFeature/UI/screens/base_BNB_screen.dart';

class EditProfileController
    extends BaseController<EditGeneralProfileRepository> {
  @override
  get repository => sl<EditGeneralProfileRepository>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isLoading = false; // Add loading state
  bool dataModifiedSuccessfully = false;

  String? _imageLocal;
  String? get imageLocal => _imageLocal;

  MediaType? _image;
  MediaType? get image => _image;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final AccountDetailsRepository _getMyAccountDataRepo =
      sl<AccountDetailsRepository>();
  Profile? _profile;
  UserModel? _user;

  @override
  void onInit() {
    initTextEditingController();
    _getMyAccountData();
    super.onInit();
  }

  void initTextEditingController() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
  }

  void setImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90, // Good quality but compressed
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        // Check file size
        final fileSize = await imageFile.length();
        print('Selected image size: ${fileSize ~/ 1024} KB');

        // For now, don't compress - use as is
        _image = MediaType(media: imageFile, type: EnumMediaType.image.name);
        update();

        print('Image set successfully: ${imageFile.path}');
      }
    } catch (e) {
      print('Image picker error: $e');
      errorEasyLoading('Failed to pick image: $e');
    }
  }

  Future<void> _getMyAccountData() async {
    isLoading = true;
    update();

    var result = await _getMyAccountDataRepo.getAccountDetails();
    result.when(success: (Response response) {
      _profile = Profile.fromJson(response.data);
      _initData();
      isLoading = false;
      update();
    }, failure: (NetworkExceptions error) {
      status = actionNetworkExceptions(error);
      isLoading = false;
      update();
    });
  }

  void _initData() {
    if (_profile != null) {
      _imageLocal = _profile!.profileImageUrl;

      firstNameController.text = _profile!.firstName;
      lastNameController.text = _profile!.lastName;
      phoneController.text = _profile!.phoneNumber;
    }
  }

  void editProfile() async {
    if (!globalKey.currentState!.validate()) return;

    globalKey.currentState!.save();
    showEasyLoading();

    // Debug print
    print('=== EDIT PROFILE DEBUG ===');
    print('First Name: ${firstNameController.text}');
    print('Last Name: ${lastNameController.text}');
    print('Phone: ${phoneController.text}');
    print('Image: ${_image?.media.path}');

    try {
      var result = await repository!.updateProfile(
        param: EditProfileParam(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          image: _image,
        ),
      );

      closeEasyLoading();

      result.when(success: (Response response) {
        print('=== SUCCESS RESPONSE ===');
        print('Response data: ${response.data}');
        print('Response status: ${response.statusCode}');

        // Fix: Handle the response structure correctly
        if (response.data != null) {
          final responseData = response.data;

          // Create updated profile from response
          final updatedProfile = Profile(
            firstName: responseData['profile']['firstName'] ??
                firstNameController.text,
            lastName:
                responseData['profile']['lastName'] ?? lastNameController.text,
            email: responseData['profile']['email'] ?? _profile?.email ?? '',
            phoneNumber:
                responseData['profile']['phoneNumber'] ?? phoneController.text,
            profileImageUrl: responseData['profile']['profileImageUrl'],
            emailVerified: responseData['profile']['emailVerified'] ?? false,
          );

          // Create user model with updated profile
          _user = UserModel(
            isSuccess: responseData['isSuccess'] ?? true,
            message: responseData['message'] ?? 'Profile updated successfully',
            token: sl<GetStorage>().read('token') ?? _user?.token ?? '',
            roles: _user?.roles ?? [],
            profileId: _user?.profileId ?? '',
            profile: updatedProfile,
          );

          // Store the updated data
          _storeUserData(_user!);

          // Print stored data for verification
          printStoredUserData();

          successEasyLoading(
              responseData['message'] ?? "Profile_Update_Successfully");

          // Navigate back
          Future.delayed(Duration(seconds: 2), () {
            Get.offAll(() => const BaseBNBScreen());
          });
        }
      }, failure: (NetworkExceptions error) {
        print('=== ERROR RESPONSE ===');
        print('Error: $error');
        actionNetworkExceptions(error);
      });
    } catch (e) {
      closeEasyLoading();
      print('=== EXCEPTION ===');
      print('Exception: $e');
      errorEasyLoading('An error occurred: $e');
    }
  }

  void _storeUserData(UserModel data) {
    final storage = sl<GetStorage>();

    storage.write("token", data.token);
    storage.write("email", data.profile.email);
    storage.write("firstName", data.profile.firstName);
    storage.write("lastName", data.profile.lastName);
    storage.write("userImage",
        data.profile.profileImageUrl); // This is the key you're using
    storage.write("phoneNumber", data.profile.phoneNumber);

    print('=== STORAGE VERIFICATION ===');
    print('Stored userImage: ${storage.read("userImage")}');
    print('Stored firstName: ${storage.read("firstName")}');
  }

  // Add this method to check stored data
  void printStoredUserData() {
    final storage = sl<GetStorage>();
    print('Stored First Name: ${storage.read("firstName")}');
    print('Stored Last Name: ${storage.read("lastName")}');
    print('Stored Phone: ${storage.read("phoneNumber")}');
    print('Stored Image: ${storage.read("userImage")}');
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}

class ImageValidationResult {
  final bool isValid;
  final String? errorMessage;

  ImageValidationResult({required this.isValid, this.errorMessage});
}

class MediaType extends Equatable {
  final File media;
  final String type;

  const MediaType({required this.media, required this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [media, type];
}
