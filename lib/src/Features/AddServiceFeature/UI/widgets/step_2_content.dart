part of '../screens/add_service_screen.dart';

class _Step2Content extends StatelessWidget {
  final AddServiceController controller;

  const _Step2Content({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddServiceController>(
      builder: (controller) {
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
            _buildServiceSpecificFields(controller),
          ],
        );
      },
    );
  }

  Widget _buildServiceSpecificFields(AddServiceController controller) {
    switch (controller.selectedService.value) {
      case 'human_doctor':
        return _buildHumanDoctorFields();
      case 'human_hospital':
        return _buildHumanHospitalFields();
      case 'human_pharmacy':
        return _buildHumanPharmacyFields();
      case 'lab':
        return _buildLabTestFields();
      case 'radiology_center':
        return _buildRadiologyFields();
      case 'optics':
        return _buildEyeCareFields();
      case 'gym':
        return _buildGymFields();
      case 'veterinarian':
        return _buildVeterinaryDoctorFields();
      case 'veterinary_hospital':
        return _buildVeterinaryHospitalFields();
      case 'veterinary_pharmacy':
        return _buildVeterinaryPharmacyFields();
      default:
        return SizedBox();
    }
  }

  Widget _buildHumanDoctorFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('consultation_price_before_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.humanDoctorPriceBefore,
          keyboardType: TextInputType.number,
          hint: 'enter_price_before_discount',
        ),
        24.ESH(),
        _buildSectionLabel('consultation_price_after_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.humanDoctorPriceAfter,
          keyboardType: TextInputType.number,
          hint: 'enter_price_after_discount',
        ),
        24.ESH(),
        _buildSectionLabel('surgeries_other_services_discount'.tr, false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.surgeriesOtherServicesDiscount,
          keyboardType: TextInputType.number,
          hint: 'enter_surgeries_other_services_discount'.tr,
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        Column(
          children: [
            Obx(() => CheckboxListTile(
                  title: CustomTextL('home_visit', fontSize: 14.sp),
                  value: controller.humanDoctorIsHome.value,
                  onChanged: (value) =>
                      controller.humanDoctorIsHome.value = value!,
                )),
            Obx(() => CheckboxListTile(
                  title: CustomTextL(
                      'Can_the_discount_card_be_used_in_the_case_of_a_home_visit',
                      fontSize: 14.sp),
                  value: controller.humanDoctorIsCard.value,
                  onChanged: (value) =>
                      controller.humanDoctorIsCard.value = value!,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildHumanHospitalFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('examinations_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.humanHospitalDiscountExaminations,
          keyboardType: TextInputType.number,
          hint: 'enter_examinations_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('medical_tests_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.humanHospitalDiscountMedicalTest,
          keyboardType: TextInputType.number,
          hint: 'enter_medical_tests_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('xray_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.humanHospitalDiscountXRay,
          keyboardType: TextInputType.number,
          hint: 'enter_xray_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('medicines_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.humanHospitalDiscountMedicines,
          keyboardType: TextInputType.number,
          hint: 'enter_medicines_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        // NEW FIELD: Discount on surgeries/other services
        _buildSectionLabel('surgeries_other_services_discount'.tr, false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.surgeriesOtherServicesDiscount,
          keyboardType: TextInputType.number,
          hint: 'enter_surgeries_other_services_discount'.tr,
          prefixIconData: Icons.percent,
        ),
      ],
    );
  }

  Widget _buildHumanPharmacyFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('local_medicines_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.humanPharmacyDiscountLocalMedicine,
          keyboardType: TextInputType.number,
          hint: 'enter_local_medicines_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('imported_medicines_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.humanPharmacyDiscountImportedMedicine,
          keyboardType: TextInputType.number,
          hint: 'enter_imported_medicines_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('medical_supplies_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.humanPharmacyDiscountMedicalSupplies,
          keyboardType: TextInputType.number,
          hint: 'enter_medical_supplies_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        Column(
          children: [
            Obx(() => CheckboxListTile(
                  title: CustomTextL('home_delivery', fontSize: 14.sp),
                  value: controller.humanPharmacyIsHome.value,
                  onChanged: (value) =>
                      controller.humanPharmacyIsHome.value = value!,
                )),
            Obx(() => CheckboxListTile(
                  title: CustomTextL(
                      'Can_the_discount_card_be_used_in_the_case_of_a_home_delivery',
                      fontSize: 14.sp),
                  value: controller.humanPharmacyIsCard.value,
                  onChanged: (value) =>
                      controller.humanPharmacyIsCard.value = value!,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildLabTestFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('all_tests_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.labTestDiscountAllTypes,
          keyboardType: TextInputType.number,
          hint: 'enter_all_tests_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        Column(
          children: [
            Obx(() => CheckboxListTile(
                  title: CustomTextL('Home_service_available', fontSize: 14.sp),
                  value: controller.labTestIsHome.value,
                  onChanged: (value) => controller.labTestIsHome.value = value!,
                )),
            Obx(() => CheckboxListTile(
                  title: CustomTextL(
                      'Can_the_discount_card_be_used_in_the_case_of_a_home_visit',
                      fontSize: 14.sp),
                  value: controller.labTestIsCard.value,
                  onChanged: (value) => controller.labTestIsCard.value = value!,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildRadiologyFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('xray_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.xRayDiscount,
          keyboardType: TextInputType.number,
          hint: 'enter_xray_discount',
          prefixIconData: Icons.percent,
        ),
      ],
    );
  }

  Widget _buildEyeCareFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('glasses_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.eyeCareDiscountGlasses,
          keyboardType: TextInputType.number,
          hint: 'enter_glasses_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('sunglasses_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.eyeCareDiscountSunGlasses,
          keyboardType: TextInputType.number,
          hint: 'enter_sunglasses_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('contact_lenses_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.contactLensesController,
          keyboardType: TextInputType.number,
          hint: 'enter_contact_lenses_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('eye_exam_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.eyeCareDiscountEyeExam,
          keyboardType: TextInputType.number,
          hint: 'enter_eye_exam_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        Column(
          children: [
            Obx(() => CheckboxListTile(
                  title: CustomTextL('home_delivery', fontSize: 14.sp),
                  value: controller.eyeCareIsDelivery.value,
                  onChanged: (value) =>
                      controller.eyeCareIsDelivery.value = value!,
                )),
            Obx(() => CheckboxListTile(
                  title: CustomTextL(
                      'Can_the_discount_card_be_used_in_the_case_of_a_home_delivery',
                      fontSize: 14.sp),
                  value: controller.eyeCareIsCard.value,
                  onChanged: (value) => controller.eyeCareIsCard.value = value!,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildGymFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('1_month_subscription', false),
        12.ESH(),
        Row(
          children: [
            Expanded(
              child: TextFieldDefault(
                controller: controller.gymMonthSubPriceB,
                keyboardType: TextInputType.number,
                hint: 'price_before',
              ),
            ),
            12.ESW(),
            Expanded(
              child: TextFieldDefault(
                controller: controller.gymMonthSubPriceA,
                keyboardType: TextInputType.number,
                hint: 'price_after',
              ),
            ),
          ],
        ),
        24.ESH(),
        _buildSectionLabel('3_months_subscription', false),
        12.ESH(),
        Row(
          children: [
            Expanded(
              child: TextFieldDefault(
                controller: controller.gymMonth3SubPriceB,
                keyboardType: TextInputType.number,
                hint: 'price_before',
              ),
            ),
            12.ESW(),
            Expanded(
              child: TextFieldDefault(
                controller: controller.gymMonth3SubPriceA,
                keyboardType: TextInputType.number,
                hint: 'price_after',
              ),
            ),
          ],
        ),
        24.ESH(),
        _buildSectionLabel('6_months_subscription', false),
        12.ESH(),
        Row(
          children: [
            Expanded(
              child: TextFieldDefault(
                controller: controller.gymMonth6SubPriceB,
                keyboardType: TextInputType.number,
                hint: 'price_before',
              ),
            ),
            12.ESW(),
            Expanded(
              child: TextFieldDefault(
                controller: controller.gymMonth6SubPriceA,
                keyboardType: TextInputType.number,
                hint: 'price_after',
              ),
            ),
          ],
        ),
        24.ESH(),
        _buildSectionLabel('12_months_subscription', false),
        12.ESH(),
        Row(
          children: [
            Expanded(
              child: TextFieldDefault(
                controller: controller.gymMonth12SubPriceB,
                keyboardType: TextInputType.number,
                hint: 'price_before',
              ),
            ),
            12.ESW(),
            Expanded(
              child: TextFieldDefault(
                controller: controller.gymMonth12SubPriceA,
                keyboardType: TextInputType.number,
                hint: 'price_after',
              ),
            ),
          ],
        ),
        24.ESH(),
        _buildSectionLabel('discount_on_other_services', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.discountOther,
          keyboardType: TextInputType.number,
          hint: 'enter_discount_on_other_services',
          prefixIconData: Icons.percent,
        ),
      ],
    );
  }

  Widget _buildVeterinaryDoctorFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('consultation_price_before_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.veterinaryDoctorPriceBefore,
          keyboardType: TextInputType.number,
          hint: 'enter_price_before_discount',
        ),
        24.ESH(),
        _buildSectionLabel('consultation_price_after_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.veterinaryDoctorPriceAfter,
          keyboardType: TextInputType.number,
          hint: 'enter_price_after_discount',
        ),
        24.ESH(),
        _buildSectionLabel('surgeries_other_services_discount'.tr, false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.surgeriesOtherServicesDiscount,
          keyboardType: TextInputType.number,
          hint: 'enter_surgeries_other_services_discount'.tr,
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        Column(
          children: [
            Obx(() => CheckboxListTile(
                  title: CustomTextL('home_visit', fontSize: 14.sp),
                  value: controller.veterinaryDoctorIsHome.value,
                  onChanged: (value) =>
                      controller.veterinaryDoctorIsHome.value = value!,
                )),
            Obx(() => CheckboxListTile(
                  title: CustomTextL(
                      'Can_the_discount_card_be_used_in_the_case_of_a_home_visit',
                      fontSize: 14.sp),
                  value: controller.veterinaryDoctorIsCard.value,
                  onChanged: (value) =>
                      controller.veterinaryDoctorIsCard.value = value!,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildVeterinaryHospitalFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('examinations_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.veterinaryHospitalDiscountExaminations,
          keyboardType: TextInputType.number,
          hint: 'enter_examinations_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('medical_tests_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.veterinaryHospitalDiscountMedicalTest,
          keyboardType: TextInputType.number,
          hint: 'enter_medical_tests_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('xray_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.veterinaryHospitalDiscountXRay,
          keyboardType: TextInputType.number,
          hint: 'enter_xray_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('medicines_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.veterinaryHospitalDiscountMedicines,
          keyboardType: TextInputType.number,
          hint: 'enter_medicines_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('surgeries_other_services_discount'.tr, false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.surgeriesOtherServicesDiscount,
          keyboardType: TextInputType.number,
          hint: 'enter_surgeries_other_services_discount'.tr,
          prefixIconData: Icons.percent,
        ),
      ],
    );
  }

  Widget _buildVeterinaryPharmacyFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('local_medicines_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.veterinaryPharmacyDiscountLocalMedicine,
          keyboardType: TextInputType.number,
          hint: 'enter_local_medicines_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('imported_medicines_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.veterinaryPharmacyDiscountImportedMedicine,
          keyboardType: TextInputType.number,
          hint: 'enter_imported_medicines_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        _buildSectionLabel('medical_supplies_discount', false),
        12.ESH(),
        TextFieldDefault(
          controller: controller.veterinaryPharmacyDiscountMedicalSupplies,
          keyboardType: TextInputType.number,
          hint: 'enter_medical_supplies_discount',
          prefixIconData: Icons.percent,
        ),
        24.ESH(),
        Column(
          children: [
            Obx(() => CheckboxListTile(
                  title: CustomTextL('home_delivery', fontSize: 14.sp),
                  value: controller.veterinaryPharmacyIsHome.value,
                  onChanged: (value) =>
                      controller.veterinaryPharmacyIsHome.value = value!,
                )),
            Obx(() => CheckboxListTile(
                  title: CustomTextL(
                      'Can_the_discount_card_be_used_in_the_case_of_a_home_visit',
                      fontSize: 14.sp),
                  value: controller.veterinaryPharmacyIsCard.value,
                  onChanged: (value) =>
                      controller.veterinaryPharmacyIsCard.value = value!,
                )),
          ],
        ),
      ],
    );
  }

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
}
