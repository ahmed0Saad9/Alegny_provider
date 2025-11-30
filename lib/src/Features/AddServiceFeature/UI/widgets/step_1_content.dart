part of '../screens/add_service_screen.dart';

class _Step1Content extends StatelessWidget {
  final AddServiceController controller;

  const _Step1Content({required this.controller});

  String _getPlatformUrl(String platform) {
    switch (platform) {
      case 'facebook':
        return 'fb://page';
      case 'instagram':
        return 'instagram://user?username=instagram';
      case 'tiktok':
        return 'tiktok://';
      case 'youtube':
        return 'vnd.youtube://';
      default:
        return 'https://$platform.com';
    }
  }

  String? _validateSocialMediaUrl(String? value, String platform) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }

    final trimmedValue = value.trim().toLowerCase();

    switch (platform) {
      case 'facebook':
        if (!trimmedValue.contains('facebook.com') &&
            !trimmedValue.contains('fb.com') &&
            !trimmedValue.startsWith('fb://')) {
          return 'invalid_facebook_link'.tr;
        }
        break;
      case 'instagram':
        if (!trimmedValue.contains('instagram.com') &&
            !trimmedValue.startsWith('instagram://')) {
          return 'invalid_instagram_link'.tr;
        }
        break;
      case 'tiktok':
        if (!trimmedValue.contains('tiktok.com') &&
            !trimmedValue.startsWith('tiktok://')) {
          return 'invalid_tiktok_link'.tr;
        }
        break;
      case 'youtube':
        if (!trimmedValue.contains('youtube.com') &&
            !trimmedValue.contains('youtu.be') &&
            !trimmedValue.startsWith('vnd.youtube://')) {
          return 'invalid_youtube_link'.tr;
        }
        break;
    }

    final urlPattern = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );

    if (!urlPattern.hasMatch(trimmedValue) && !trimmedValue.contains('://')) {
      return 'invalid_url_format'.tr;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.step1FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextL(
            'let_us_know_about_you',
            fontSize: 20.sp,
            fontWeight: FW.bold,
            color: Colors.grey[800],
          ),
          24.ESH(),
          buildSectionLabel('upload_picture', true),
          12.ESH(),
          _buildImageUploadSection(),
          24.ESH(),
          // Service Name
          buildSectionLabel('service_name', true),
          6.ESH(),
          TextFieldDefault(
            hint: 'enter_service_name_or_doctor',
            controller: controller.serviceNameController,
            validation: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'service_name_required'.tr;
              }
              if (value.trim().length < 3) {
                return 'service_name_too_short'.tr;
              }
              if (value.trim().length > 100) {
                return 'service_name_too_long'.tr;
              }
              return null;
            },
          ),
          24.ESH(),
          buildSectionLabel('Service', true),
          12.ESH(),
          _buildServiceDropdown(),
          24.ESH(),
          GetBuilder<AddServiceController>(
            builder: (controller) {
              return (controller.selectedService.value == 'human_doctor') ||
                      (controller.selectedService.value == 'human_hospital')
                  ? Column(
                      children: [
                        buildSectionLabel('specialization', true),
                        12.ESH(),
                        _buildSpecializationDropdown(),
                        24.ESH(),
                      ],
                    )
                  : const SizedBox.shrink();
            },
          ),
          // Service description
          buildSectionLabel('Service_description', false),
          6.ESH(),
          TextFieldDefault(
            hint: 'Enter_service_description'.tr,
            controller: controller.serviceDescriptionController,
            maxLines: 3,
            validation: (value) {
              if (value != null && value.trim().isNotEmpty) {
                if (value.trim().length < 10) {
                  return 'description_too_short'.tr;
                }
                if (value.trim().length > 500) {
                  return 'description_too_long'.tr;
                }
              }
              return null;
            },
          ),
          24.ESH(),
          24.ESH(),
          buildSectionLabel('social_media_links', false),
          16.ESH(),
          ..._buildSocialMediaFields(),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return GetBuilder<AddServiceController>(
      builder: (controller) {
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
            child: _buildImageContent(),
          ),
        );
      },
    );
  }

  Widget _buildImageContent() {
    if (controller.serviceImage.value != null) {
      return _buildImagePreview(controller.serviceImage.value!);
    } else if (controller.serviceImageUrl.value.isNotEmpty) {
      return _buildNetworkImagePreview(controller.serviceImageUrl.value);
    } else {
      return _buildUploadPlaceholder();
    }
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

  Widget _buildImagePreview(File imageFile) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 8.w,
          right: 8.w,
          child: GestureDetector(
            onTap: () {
              controller.serviceImage.value = null;
              controller.update();
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkImagePreview(String imageUrl) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return _buildUploadPlaceholder();
            },
          ),
        ),
        Positioned(
          bottom: 8.w,
          right: 8.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CustomTextL(
              'existing_image',
              fontSize: 10.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
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
        items: controller
            .getSpecializationsForService(controller.selectedService.value)
            .map((spec) => DropdownMenuItem(
                  value: spec,
                  child: CustomTextL(_getSpecializationDisplayText(spec),
                      fontSize: 14.sp),
                ))
            .toList(),
        onChanged: (value) {
          controller.selectedSpecialization.value = value;
          controller.update();
        });
  }

  String _getSpecializationDisplayText(String specialization) {
    if (specialization == 'جميع التخصصات') {
      return 'all_specializations'.tr;
    }
    return specialization.tr;
  }

  Widget _buildServiceDropdown() {
    return DropdownButtonFormField<String>(
      value: controller.selectedService.value,
      decoration: _dropdownDecoration(),
      hint: CustomTextL(
        'Select_service',
        color: Colors.grey[600],
        fontSize: 18.sp,
      ),
      items: AddServiceController.services
          .map((spec) => DropdownMenuItem(
                value: spec,
                child: CustomTextL(spec.tr, fontSize: 14.sp),
              ))
          .toList(),
      onChanged: (value) => controller.setSelectedService(value),
      disabledHint: controller.isEditingMode
          ? CustomTextL(
              controller.selectedService.value?.tr ?? 'Select_service',
              fontSize: 14.sp,
              color: Colors.grey[500],
            )
          : null,
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
          validation: (value) => _validateSocialMediaUrl(value, platform),
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
                  fontSize: 14.sp,
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

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.main, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    );
  }
}
