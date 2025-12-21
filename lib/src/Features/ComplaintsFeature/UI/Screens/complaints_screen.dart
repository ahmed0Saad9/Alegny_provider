import 'package:Alegny_provider/src/Features/ComplaintsFeature/Bloc/Controller/complaints_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplaintController>(
      init: ComplaintController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBars.appBarBack(
            title: 'complaints',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  // Subject Field
                  const CustomTextL(
                    'subject',
                    fontSize: 16,
                    fontWeight: FW.bold,
                  ),
                  8.ESH(),
                  TextFieldDefault(
                    controller: controller.subjectController,
                    maxLines: 1,
                    hint: 'enter_subject'.tr,
                    validation: controller.validateSubject,
                  ),
                  16.ESH(),
                  // Message Field
                  CustomTextL(
                    'message'.tr,
                    fontSize: 16,
                    fontWeight: FW.bold,
                  ),

                  8.ESH(),
                  TextFieldDefault(
                    controller: controller.messageController,
                    maxLines: 6,
                    hint: 'enter_message'.tr,
                    validation: controller.validateMessage,
                  ),
                  24.ESH(),
                  // Image Upload Section
                  CustomTextL(
                    'attach_image'.tr,
                    fontSize: 16,
                    fontWeight: FW.bold,
                  ),
                  8.ESH(),
                  _buildImageSection(controller),
                  24.ESH(),
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ButtonDefault(
                      onTap: controller.submitComplaint,
                      child: const Center(
                        child: CustomTextL(
                          'submit_complaint',
                          color: AppColors.titleWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection(ComplaintController controller) {
    return Column(
      children: [
        if (controller.complaintImage != null) ...[
          Stack(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Image.file(
                  controller.complaintImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: controller.removeComplaintImage,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        OutlinedButton.icon(
          onPressed: controller.setComplaintImage,
          icon: const Icon(Icons.camera_alt),
          label: CustomTextL('select_image'.tr),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.main,
            side: const BorderSide(color: AppColors.main),
          ),
        ),
      ],
    );
  }
}
