import 'dart:io';
import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/controller/add_service_controller.dart';
import 'package:Alegny_provider/src/Features/AddServiceFeature/UI/widgets/location_picker_screen.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/service_model.dart';

import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

part '../widgets/step_1_content.dart';

part '../widgets/step_2_content.dart';

part '../widgets/step_3_content.dart';

class AddServiceScreen extends StatelessWidget {
  final ServiceModel? serviceToEdit;

  const AddServiceScreen({super.key, this.serviceToEdit});

  @override
  Widget build(BuildContext context) {
    // Get initial step from arguments, default to 0
    final initialStep = Get.arguments?['initialStep'] ?? 0;
    print('DEBUG: AddServiceScreen initialStep = $initialStep');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBars.appBarBack(
        title: serviceToEdit != null ? 'Edit_service' : 'Add_Service',
      ),
      body: GetBuilder<AddServiceController>(
        init: AddServiceController(
          serviceToEdit: serviceToEdit,
          initialStep: initialStep, // Pass initial step here
        ),
        builder: (controller) {
          print(
              'DEBUG: Current step in builder = ${controller.currentStep.value}');
          return Column(
            children: [
              _buildStepperHeader(controller),
              _buildStepContent(controller),
              _buildNavigationButtons(controller, serviceToEdit),
            ],
          );
        },
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

  Widget _buildNavigationButtons(
      AddServiceController controller, ServiceModel? serviceToEdit) {
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
              title: controller.currentStep.value == 2
                  ? serviceToEdit != null
                      ? 'Save'
                      : 'submit'
                  : 'next',
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

// Helper widget for section labels
Widget buildSectionLabel(String text, bool isRequired) {
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
