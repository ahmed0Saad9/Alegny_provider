// lib/src/Features/ComplaintsFeature/UI/screens/complaint_screen.dart
import 'package:Alegny_provider/src/Features/ComplaintsFeature/Bloc/Controller/complaints_controller.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
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
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.subjectController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'enter_subject'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16.r,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    validator: controller.validateSubject,
                  ),
                  const SizedBox(height: 16),

                  // Message Field
                  CustomTextL(
                    'message'.tr,
                    fontSize: 16,
                    fontWeight: FW.bold,
                  ),

                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.messageController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'enter_message'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16.r,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    validator: controller.validateMessage,
                  ),
                  const SizedBox(height: 24),

                  // Image Upload Section
                  CustomTextL(
                    'attach_image'.tr,
                    fontSize: 16,
                    fontWeight: FW.bold,
                  ),
                  const SizedBox(height: 8),
                  _buildImageSection(controller),
                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ButtonDefault(
                      onTap: controller.isSubmitting
                          ? null
                          : controller.submitComplaint,
                      child: controller.isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Center(
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
