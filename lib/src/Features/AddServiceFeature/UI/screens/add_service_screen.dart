import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:image_picker/image_picker.dart';

// Model for service data
class ServiceData {
  final String serviceName;
  final String? specialization;
  final File? serviceImage;
  final String facebook;
  final String instagram;
  final String tiktok;
  final String youtube;
  final String discount;
  final String address;
  final String city;
  final double? latitude;
  final double? longitude;

  const ServiceData({
    required this.serviceName,
    this.specialization,
    this.serviceImage,
    this.facebook = '',
    this.instagram = '',
    this.tiktok = '',
    this.youtube = '',
    this.discount = '',
    this.address = '',
    this.city = '',
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'service_name': serviceName,
        'specialization': specialization,
        'service_image': serviceImage,
        'facebook': facebook,
        'instagram': instagram,
        'tiktok': tiktok,
        'youtube': youtube,
        'discount': discount,
        'address': address,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
      };
}

// Controller
class AddServiceController extends GetxController {
  final RxInt currentStep = 0.obs;

  // Form controllers
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final Rxn<String> selectedSpecialization = Rxn<String>();
  final Rxn<File> serviceImage = Rxn<File>();
  final Rxn<double> latitude = Rxn<double>();
  final Rxn<double> longitude = Rxn<double>();

  static const List<String> specializations = [
    'Doctor',
    'Dentist',
    'Physiotherapist',
    'Veterinarian',
    'Other',
  ];

  // Step validation rules
  final List<bool Function()> _stepValidators = [];

  AddServiceController() {
    _initializeValidators();
  }

  void _initializeValidators() {
    _stepValidators
      ..add(_validateStep1)
      ..add(_validateStep2)
      ..add(_validateStep3);
  }

  bool _validateStep1() {
    if (serviceImage.value == null) {
      _showError('please_upload_picture'.tr);
      return false;
    }
    if (selectedSpecialization.value == null) {
      _showError('please_select_specialization'.tr);
      return false;
    }
    if (serviceNameController.text.trim().isEmpty) {
      _showError('please_enter_service_name'.tr);
      return false;
    }
    return true;
  }

  bool _validateStep2() {
    if (discountController.text.trim().isEmpty) {
      _showError('please_enter_discount'.tr);
      return false;
    }
    return true;
  }

  bool _validateStep3() {
    if (addressController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty) {
      _showError('please_enter_location'.tr);
      return false;
    }
    return true;
  }

  void _showError(String message) {
    Get.snackbar(
      'error'.tr,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void nextStep() {
    if (currentStep.value < 2) {
      if (_stepValidators[currentStep.value]()) {
        currentStep.value++;
      }
    } else {
      submitService();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        serviceImage.value = File(image.path);
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to pick image: $e");
      _showError('failed_to_pick_image'.tr);
    }
  }

  // Method to open social media apps
  Future<void> openSocialMediaApp(String url, String platform) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          'error'.tr,
          '${'cannot_open'.tr} $platform',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'error_occurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void submitService() {
    final serviceData = ServiceData(
      serviceName: serviceNameController.text.trim(),
      specialization: selectedSpecialization.value,
      serviceImage: serviceImage.value,
      facebook: facebookController.text.trim(),
      instagram: instagramController.text.trim(),
      tiktok: tiktokController.text.trim(),
      youtube: youtubeController.text.trim(),
      discount: discountController.text.trim(),
      address: addressController.text.trim(),
      city: cityController.text.trim(),
      latitude: latitude.value,
      longitude: longitude.value,
    );

    // Send to backend
    _sendToBackend(serviceData);
  }

  void _sendToBackend(ServiceData serviceData) {
    // TODO: Implement actual backend integration
    print('Service Data: ${serviceData.toJson()}');

    Get.snackbar(
      'success'.tr,
      'service_added_successfully'.tr,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.back();
  }

  @override
  void onClose() {
    serviceNameController.dispose();
    facebookController.dispose();
    instagramController.dispose();
    tiktokController.dispose();
    youtubeController.dispose();
    discountController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.onClose();
  }
}

// Screen
class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBars.appBarBack(
        title: 'Add_Service',
      ),
      body: GetBuilder<AddServiceController>(
        init: AddServiceController(),
        builder: (controller) => Column(
          children: [
            _buildStepperHeader(
              controller,
            ),
            _buildStepContent(
              controller,
            ),
            _buildNavigationButtons(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperHeader(
    AddServiceController controller,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColors.main,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStepIndicator(1, controller.currentStep.value >= 0),
          _buildStepLine(controller.currentStep.value >= 1),
          _buildStepIndicator(
            2,
            controller.currentStep.value >= 1,
          ),
          _buildStepLine(controller.currentStep.value >= 2),
          _buildStepIndicator(
            3,
            controller.currentStep.value >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(
    AddServiceController controller,
  ) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: _getStepWidget(
          controller,
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(AddServiceController controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (controller.currentStep.value > 0) ...[
            Expanded(
              child: _buildBackButton(controller),
            ),
            16.ESW(),
          ],
          Expanded(
            flex: controller.currentStep.value == 0 ? 1 : 1,
            child: ButtonDefault(
              title: controller.currentStep.value == 2 ? 'submit' : 'next',
              onTap: controller.nextStep,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(AddServiceController controller) {
    return ElevatedButton(
      onPressed: controller.previousStep,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.grey[700],
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
      ),
      child: CustomTextL(
        'back',
        fontSize: 16.sp,
        fontWeight: FW.bold,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildStepIndicator(
    int step,
    bool isActive,
  ) {
    return Column(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: CustomTextL(
              '$step',
              fontSize: 16.sp,
              fontWeight: FW.bold,
              color: isActive ? AppColors.main : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
      ),
    );
  }

  Widget _getStepWidget(
    AddServiceController controller,
  ) {
    switch (controller.currentStep.value) {
      case 0:
        return _Step1Content(controller: controller);
      case 1:
        return _Step2Content(controller: controller);
      case 2:
        return _Step3Content(controller: controller);
      default:
        return const SizedBox.shrink();
    }
  }
}

// Step 1 Content Widget
class _Step1Content extends StatelessWidget {
  final AddServiceController controller;

  const _Step1Content({required this.controller});

  // Helper method to get platform URLs
  String _getPlatformUrl(String platform) {
    switch (platform) {
      case 'facebook':
        return 'fb://page';
      case 'instagram':
        return 'instagram://app';
      case 'tiktok':
        return 'tiktok://';
      case 'youtube':
        return 'vnd.youtube://';
      default:
        return 'https://$platform.com';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextL(
          'let_us_know_about_you',
          fontSize: 20.sp,
          fontWeight: FW.bold,
          color: Colors.grey[800],
        ),
        24.ESH(),

        // Upload Picture
        _buildSectionLabel('upload_picture', true),
        12.ESH(),
        _buildImageUploadSection(),
        24.ESH(),

        // Specialization
        _buildSectionLabel('specialization', true),
        12.ESH(),
        _buildSpecializationDropdown(),
        24.ESH(),

        // Service Name
        _buildSectionLabel('service_name', true),
        6.ESH(),
        TextFieldDefault(
          hint: 'enter_service_name_or_doctor',
          controller: controller.serviceNameController,
        ),
        24.ESH(),

        // Social Media Links
        _buildSectionLabel('social_media_links', false),
        16.ESH(),
        ..._buildSocialMediaFields(),
      ],
    );
  }

  Widget _buildImageUploadSection() {
    return InkWell(
      onTap: controller.pickImageFromGallery,
      child: Container(
        width: double.infinity,
        height: 180.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey[300]!, width: 2),
        ),
        child: controller.serviceImage.value == null
            ? _buildUploadPlaceholder()
            : _buildImagePreview(),
      ),
    );
  }

  Widget _buildUploadPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.cloud_upload_outlined, size: 48.sp, color: AppColors.main),
        12.ESH(),
        CustomTextL(
          'tap_to_upload',
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: Image.file(
        controller.serviceImage.value!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildSpecializationDropdown() {
    return DropdownButtonFormField<String>(
      value: controller.selectedSpecialization.value,
      decoration: _dropdownDecoration(),
      hint: CustomTextL(
        'select_specialization',
        color: Colors.grey[600],
        fontSize: 18.sp,
      ),
      items: AddServiceController.specializations
          .map((spec) => DropdownMenuItem(
                value: spec,
                child: CustomTextL(spec, fontSize: 14.sp),
              ))
          .toList(),
      onChanged: (value) => controller.selectedSpecialization.value = value,
    );
  }

  List<Widget> _buildSocialMediaFields() {
    return [
      _buildSocialMediaField(
        controller.facebookController,
        'Facebook',
        'Facebook',
        const Color(0xFF1877F2),
        'facebook',
      ),
      12.ESH(),
      _buildSocialMediaField(
        controller.instagramController,
        'Instagram',
        'Instagram',
        const Color(0xFFE4405F),
        'instagram',
      ),
      12.ESH(),
      _buildSocialMediaField(
        controller.tiktokController,
        'TikTok',
        'Tiktok',
        Colors.black,
        'tiktok',
      ),
      12.ESH(),
      _buildSocialMediaField(
        controller.youtubeController,
        'YouTube',
        'Youtube',
        const Color(0xFFFF0000),
        'youtube',
      ),
    ];
  }

  Widget _buildSocialMediaField(
    TextEditingController textController,
    String label,
    String icon,
    Color color,
    String platform,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldDefault(
          controller: textController,
          hint: '${label.tr} ${'link'.tr}',
          prefixIconUrl: icon,
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: () => controller.openSocialMediaApp(
                _getPlatformUrl(platform), platform),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              foregroundColor: color,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.open_in_new,
                  size: 16.sp,
                  color: color,
                ),
                4.ESW(),
                CustomTextL(
                  'Open_in_app',
                  fontSize: 12.sp,
                  color: color,
                  fontWeight: FW.medium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Step 2 Content Widget
class _Step2Content extends StatelessWidget {
  final AddServiceController controller;

  const _Step2Content({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextL(
          'discounts',
          fontSize: 20.sp,
          fontWeight: FW.bold,
          color: Colors.grey[800],
        ),
        24.ESH(),
        _buildSectionLabel('discount_percentage', true),
        12.ESH(),
        TextFieldDefault(
          controller: controller.discountController,
          keyboardType: TextInputType.number,
          hint: 'enter_discount_percentage',
        ),
      ],
    );
  }
}

// Step 3 Content Widget
class _Step3Content extends StatelessWidget {
  final AddServiceController controller;

  const _Step3Content({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextL(
          'location',
          fontSize: 20.sp,
          fontWeight: FW.bold,
          color: Colors.grey[800],
        ),
        24.ESH(),
        _buildSectionLabel('address', true),
        12.ESH(),
        TextFieldDefault(
          controller: controller.addressController,
          maxLines: 3,
          hint: 'enter_address',
        ),
        24.ESH(),
        _buildSectionLabel('city', true),
        12.ESH(),
        TextFieldDefault(
          controller: controller.cityController,
          hint: 'enter_city'.tr,
        ),
      ],
    );
  }
}

// Helper widget for section labels
Widget _buildSectionLabel(String text, bool isRequired) {
  return Row(
    children: [
      CustomTextL(
        text,
        fontSize: 18.sp,
        fontWeight: FW.medium,
        color: Colors.grey[700],
      ),
      if (isRequired) ...[
        4.ESW(),
        CustomTextL('*', fontSize: 18.sp, color: Colors.red),
      ],
    ],
  );
}

// Common decoration for dropdowns
InputDecoration _dropdownDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: TextFieldColors.enableBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.main, width: 1),
    ),
  );
}
