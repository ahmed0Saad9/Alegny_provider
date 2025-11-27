part of '../screens/add_service_screen.dart';

class _Step1Content extends StatelessWidget {
  final AddServiceController controller;

  const _Step1Content({required this.controller});

  // Helper method to get platform URLs
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
        ),
        24.ESH(),

        //Service

        buildSectionLabel('Service', true),
        12.ESH(),
        _buildServiceDropdown(),
        24.ESH(),

        //specialization(if visible)
        GetBuilder<AddServiceController>(
          builder: (controller) {
            return (controller.selectedService.value == 'human_doctor') ||
                    (controller.selectedService.value == 'human_hospital' ||
                        controller.selectedService.value == 'human_pharmacy')
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
        ),
        24.ESH(),

        // Social Media Links
        buildSectionLabel('social_media_links', false),
        16.ESH(),
        ..._buildSocialMediaFields(),
      ],
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
    // Show selected image first
    if (controller.serviceImage.value != null) {
      return _buildImagePreview(controller.serviceImage.value!);
    }
    // Show existing image from URL
    else if (controller.serviceImageUrl.value.isNotEmpty) {
      return _buildNetworkImagePreview(controller.serviceImageUrl.value);
    }
    // Show upload placeholder
    else {
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
        // Add remove button
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
      return 'all_specializations'.tr; // Make sure to add this translation
    }
    return specialization
        .tr; // Assuming you have translations for other specializations
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
