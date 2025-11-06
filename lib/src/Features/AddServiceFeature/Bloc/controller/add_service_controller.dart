import 'dart:io';

import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/Model/add_service_model.dart';
import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/Model/branch_model.dart';
import 'package:Alegny_provider/src/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class AddServiceController extends GetxController {
  final RxInt currentStep = 0.obs;

  //first step controllers
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController serviceDescriptionController =
      TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final Rxn<String> selectedSpecialization = Rxn<String>();
  final Rxn<String> selectedService = Rxn<String>();
  final Rxn<File> serviceImage = Rxn<File>();

  final List<Branch> branches = <Branch>[].obs;

  final List<TextEditingController> branchAddressControllers = [];
  final List<TextEditingController> branchPhoneControllers = [];
  final List<TextEditingController> branchWhatsappControllers = [];
  final List<RxString> branchSelectedCities = [];
  final List<RxString> branchSelectedGovernorates = [];
  final List<Map<String, String>> branchWorkingHours = [];

  //second step controllers
  /// xRay
  TextEditingController xRay = TextEditingController();
  TextEditingController xRayDiscount = TextEditingController();
  TextEditingController discountOther = TextEditingController();

  /// fitness gym
  TextEditingController gymMonthSubPriceB = TextEditingController();
  TextEditingController gymMonthSubPriceA = TextEditingController();
  TextEditingController gymMonth3SubPriceB = TextEditingController();
  TextEditingController gymMonth3SubPriceA = TextEditingController();
  TextEditingController gymMonth6SubPriceB = TextEditingController();
  TextEditingController gymMonth6SubPriceA = TextEditingController();
  TextEditingController gymMonth12SubPriceB = TextEditingController();
  TextEditingController gymMonth12SubPriceA = TextEditingController();

  /// Human Hospital
  TextEditingController humanHospitalDiscountExaminations =
      TextEditingController();
  TextEditingController humanHospitalDiscountMedicalTest =
      TextEditingController();
  TextEditingController humanHospitalDiscountXRay = TextEditingController();
  TextEditingController humanHospitalDiscountMedicines =
      TextEditingController();

  /// Human Doctor
  TextEditingController humanDoctorPriceBefore = TextEditingController();
  TextEditingController humanDoctorPriceAfter = TextEditingController();
  RxBool humanDoctorIsHome = false.obs;
  RxBool humanDoctorIsCard = false.obs;

  /// veterinary doctor
  TextEditingController veterinaryDoctorPriceBefore = TextEditingController();
  TextEditingController veterinaryDoctorPriceAfter = TextEditingController();
  RxBool veterinaryDoctorIsHome = false.obs;
  RxBool veterinaryDoctorIsCard = false.obs;

  /// eye Care
  TextEditingController eyeCareDiscountGlasses = TextEditingController();
  TextEditingController eyeCareDiscountSunGlasses = TextEditingController();
  TextEditingController contactLensesController = TextEditingController();
  TextEditingController eyeCareDiscountEyeExam = TextEditingController();
  RxBool eyeCareIsDelivery = false.obs;
  RxBool eyeCareIsCard = false.obs;

  /// lab Test
  TextEditingController labTestDiscountAllTypes = TextEditingController();
  RxBool labTestIsCard = false.obs;
  RxBool labTestIsHome = false.obs;

  /// HUMAN PHARMACY
  TextEditingController humanPharmacyDiscountLocalMedicine =
      TextEditingController();
  TextEditingController humanPharmacyDiscountImportedMedicine =
      TextEditingController();
  TextEditingController humanPharmacyDiscountMedicalSupplies =
      TextEditingController();
  RxBool humanPharmacyIsHome = false.obs;
  RxBool humanPharmacyIsCard = false.obs;

  /// veterinary PHARMACY
  TextEditingController veterinaryPharmacyDiscountLocalMedicine =
      TextEditingController();
  TextEditingController veterinaryPharmacyDiscountImportedMedicine =
      TextEditingController();
  TextEditingController veterinaryPharmacyDiscountMedicalSupplies =
      TextEditingController();
  RxBool veterinaryPharmacyIsHome = false.obs;
  RxBool veterinaryPharmacyIsCard = false.obs;

  /// veterinary Hospital
  TextEditingController veterinaryHospitalDiscountExaminations =
      TextEditingController();
  TextEditingController veterinaryHospitalDiscountMedicalTest =
      TextEditingController();
  TextEditingController veterinaryHospitalDiscountXRay =
      TextEditingController();
  TextEditingController veterinaryHospitalDiscountMedicines =
      TextEditingController();

  //shared
  TextEditingController surgeriesOtherServicesDiscount =
      TextEditingController();

  final Rxn<double> latitude = Rxn<double>();
  final Rxn<double> longitude = Rxn<double>();

  static const List<String> specializations = [
    'dermatology',
    'laser',
    'dentistry',
    'hair_transplant',
    'psychiatry',
    'pediatrics_neonatology',
    'neurology',
    'orthopedics',
    'obstetrics_gynecology',
    'ent',
    'cardiology',
    'internal_medicine',
    'interventional_radiology',
    'hematology',
    'oncology',
    'nutrition_weight_loss',
    'pediatric_surgery',
    'surgical_oncology',
    'vascular_surgery',
    'plastic_surgery',
    'bariatric_surgery',
    'general_surgery',
    'spine_surgery',
    'cardio_thoracic_surgery',
    'neurosurgery',
    'gastroenterology_endoscopy',
    'allergy_immunology',
    'ivf',
    'andrology_infertility',
    'rheumatology',
    'endocrinology',
    'audiology',
    'pulmonology',
    'family_medicine',
    'geriatrics',
    'rehabilitative_medicine',
    'pain_management',
    'physiotherapy_sports',
    'ophthalmology',
    'hepatology',
    'nephrology',
    'urology',
    'general_practice',
    'speech_therapy',
  ];

  static const List<String> services = [
    'human_hospital',
    'human_doctor',
    'human_pharmacy',
    'lab',
    'radiology_center',
    'optics',
    'gym',
    'veterinary_hospital',
    'veterinarian',
    'veterinary_pharmacy',
  ];

  void setSelectedService(String? service) {
    selectedService.value = service;
    update();
  }

  // Egyptian governorates and cities data
  static const List<String> governorates = [
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
    'الدقهلية',
    'البحر الأحمر',
    'البحيرة',
    'الفيوم',
    'الغربية',
    'الإسماعيلية',
    'المنوفية',
    'المنيا',
    'القليوبية',
    'الوادي الجديد',
    'السويس',
    'أسوان',
    'أسيوط',
    'بني سويف',
    'بورسعيد',
    'دمياط',
    'الشرقية',
    'جنوب سيناء',
    'كفر الشيخ',
    'مطروح',
    'الأقصر',
    'قنا',
    'شمال سيناء',
    'سوهاج',
  ];

  static const Map<String, List<String>> citiesByGovernorate = {
    'القاهرة': [
      'المعادي',
      'المقطم',
      'مدينة نصر',
      'مصر الجديدة',
      'الزمالك',
      'الدقي',
      'المهندسين'
    ],
    'الجيزة': ['الدقي', 'المهندسين', 'العجوزة', 'الهرم', 'فيصل', 'أكتوبر'],
    'الإسكندرية': ['المنتزه', 'سموحة', 'السيوف', 'العصافرة', 'اللبان'],
    'الدقهلية': ['المنصورة', 'طلخا', 'ميت غمر', 'بلقاس', 'أجا'],
    'البحر الأحمر': ['الغردقة', 'مرسى علم', 'رأس غارب'],
    'البحيرة': ['دمنهور', 'كفر الدوار', 'إدكو', 'أبو المطامير'],
    'الفيوم': ['الفيوم', 'طامية', 'سنورس'],
    'الغربية': ['طنطا', 'المحلة الكبرى', 'زفتى', 'سمنود'],
    'الإسماعيلية': ['الإسماعيلية', 'فايد', 'القنطرة'],
    'المنوفية': ['شبين الكوم', 'منوف', 'أشمون', 'الباجور'],
    'المنيا': ['المنيا', 'ملوي', 'دير مواس'],
    'القليوبية': ['بنها', 'قليوب', 'شبرا الخيمة'],
    'الوادي الجديد': ['الخارجة', 'الداخلة', 'باريس'],
    'السويس': ['السويس', 'الأربعين'],
    'أسوان': ['أسوان', 'كوم أمبو', 'دراو'],
    'أسيوط': ['أسيوط', 'أبنوب', 'ديروط'],
    'بني سويف': ['بني سويف', 'الواسطى', 'ناصر'],
    'بورسعيد': ['بورسعيد', 'حي الشرق', 'حي الغرب'],
    'دمياط': ['دمياط', 'فارسكور', 'الزرقا'],
    'الشرقية': ['الزقازيق', 'بلبيس', 'ههيا', 'أبو حماد'],
    'جنوب سيناء': ['شرم الشيخ', 'دهب', 'نويبع'],
    'كفر الشيخ': ['كفر الشيخ', 'دسوق', 'فوه'],
    'مطروح': ['مرسى مطروح', 'الحمام', 'النجيلة'],
    'الأقصر': ['الأقصر', 'القرنة', 'إسنا'],
    'قنا': ['قنا', 'قفط', 'نقادة'],
    'شمال سيناء': ['العريش', 'الشيخ زويد', 'رفح'],
    'سوهاج': ['سوهاج', 'جرجا', 'أخميم'],
  };

  void addBranch() {
    // Create new controllers and data for this branch
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final whatsappController = TextEditingController();
    final selectedCity = ''.obs;
    final selectedGovernorate = ''.obs;
    final workingHours = <String, String>{
      'saturday': '',
      'sunday': '',
      'monday': '',
      'tuesday': '',
      'wednesday': '',
      'thursday': '',
      'friday': 'closed'.tr,
    };

    // Store them in the lists
    branchAddressControllers.add(addressController);
    branchPhoneControllers.add(phoneController);
    branchWhatsappControllers.add(whatsappController);
    branchSelectedCities.add(selectedCity);
    branchSelectedGovernorates.add(selectedGovernorate);
    branchWorkingHours.add(workingHours);

    // Create the branch (initially empty)
    final newBranch = Branch(
      address: '',
      phoneNumber: '',
      whatsAppNumber: '',
      workingHours: workingHours,
      selectedCity: selectedCity.value,
      selectedGovernorate: selectedGovernorate.value,
    );

    branches.add(newBranch);
    update();
  }

  void removeBranch(int index) {
    if (branches.length > 1) {
      // Dispose controllers and remove from lists
      branchAddressControllers[index].dispose();
      branchPhoneControllers[index].dispose();
      branchWhatsappControllers[index].dispose();

      branchAddressControllers.removeAt(index);
      branchPhoneControllers.removeAt(index);
      branchWhatsappControllers.removeAt(index);
      branchSelectedCities.removeAt(index);
      branchSelectedGovernorates.removeAt(index);
      branchWorkingHours.removeAt(index);

      branches.removeAt(index);
      update();
    }
  }

  void updateBranchData(int index) {
    if (index < branches.length) {
      final updatedBranch = Branch(
        address: branchAddressControllers[index].text,
        phoneNumber: branchPhoneControllers[index].text,
        whatsAppNumber: branchWhatsappControllers[index].text,
        selectedGovernorate: branchSelectedGovernorates[index].value,
        selectedCity: branchSelectedCities[index].value,
        workingHours: Map.from(branchWorkingHours[index]), // Create a copy
      );

      branches[index] = updatedBranch;
    }
  }

  void updateAllBranches() {
    for (int i = 0; i < branches.length; i++) {
      updateBranchData(i);
    }
  }

  final List<bool Function()> _stepValidators = [];

  AddServiceController() {
    _initializeValidators();
    addBranch(); // Create first branch
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
    if (selectedService.value == null) {
      _showError('please_select_service'.tr);
      return false;
    }
    if (selectedService.value == 'human_doctor' ||
        selectedService.value == 'human_hospital') {
      if (selectedSpecialization.value == null) {
        _showError('please_select_specialization'.tr);
        return false;
      }
    }
    if (serviceNameController.text.trim().isEmpty) {
      _showError('please_enter_service_name'.tr);
      return false;
    }
    return true;
  }

  bool _validateStep2() {
    return true;
  }

  bool _validateStep3() {
    for (int i = 0; i < branches.length; i++) {
      // Validate using the branch-specific controllers and Rx values
      if (branchSelectedGovernorates[i].value.isEmpty) {
        _showError(
            '${'please_select_governorate'.tr} ${'for_branch'.tr} ${i + 1}');
        return false;
      }

      if (branchSelectedCities[i].value.isEmpty) {
        _showError('${'please_select_city'.tr} ${'for_branch'.tr} ${i + 1}');
        return false;
      }

      if (branchAddressControllers[i].text.trim().isEmpty) {
        _showError('${'please_enter_address'.tr} ${'for_branch'.tr} ${i + 1}');
        return false;
      }

      if (branchPhoneControllers[i].text.trim().isEmpty) {
        _showError(
            '${'please_enter_phone_number'.tr} ${'for_branch'.tr} ${i + 1}');
        return false;
      }

      // Optional: Validate WhatsApp
      // if (branchWhatsappControllers[i].text.trim().isEmpty) {
      //   _showError('${'please_enter_whatsapp_number'.tr} ${'for_branch'.tr} ${i + 1}');
      //   return false;
      // }
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
        update();
      }
    } else {
      submitService();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      update();
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        serviceImage.value = File(image.path);
        update();
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
        await launchUrl(uri, mode: LaunchMode.externalApplication);
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
    final branchesData = branches.map((branch) => branch.toJson()).toList();
    updateAllBranches();
    final serviceData = ServiceData(
      // Basic info
      serviceName: serviceNameController.text.trim(),
      serviceDescription: serviceDescriptionController.text.trim(),
      serviceType: selectedService.value,
      specialization: selectedSpecialization.value,
      serviceImage: serviceImage.value,

      // Social media
      facebook: facebookController.text.trim(),
      instagram: instagramController.text.trim(),
      tiktok: tiktokController.text.trim(),
      youtube: youtubeController.text.trim(),

      // Doctor fields
      consultationPriceBefore: humanDoctorPriceBefore.text.trim().isNotEmpty
          ? humanDoctorPriceBefore.text.trim()
          : veterinaryDoctorPriceBefore.text.trim(),
      consultationPriceAfter: humanDoctorPriceAfter.text.trim().isNotEmpty
          ? humanDoctorPriceAfter.text.trim()
          : veterinaryDoctorPriceAfter.text.trim(),
      isHomeVisit: selectedService.value == 'human_doctor'
          ? humanDoctorIsHome.value
          : (selectedService.value == 'veterinarian'
              ? veterinaryDoctorIsHome.value
              : null),
      homeDiscount: selectedService.value == 'human_doctor'
          ? humanDoctorIsCard.value
          : (selectedService.value == 'veterinarian'
              ? veterinaryDoctorIsCard.value
              : null),

      // Hospital fields
      examinationsDiscount:
          humanHospitalDiscountExaminations.text.trim().isNotEmpty
              ? humanHospitalDiscountExaminations.text.trim()
              : veterinaryHospitalDiscountExaminations.text.trim(),
      medicalTestsDiscount:
          humanHospitalDiscountMedicalTest.text.trim().isNotEmpty
              ? humanHospitalDiscountMedicalTest.text.trim()
              : veterinaryHospitalDiscountMedicalTest.text.trim(),
      xrayDiscount: humanHospitalDiscountXRay.text.trim().isNotEmpty
          ? humanHospitalDiscountXRay.text.trim()
          : veterinaryHospitalDiscountXRay.text.trim(),
      medicinesDiscount: humanHospitalDiscountMedicines.text.trim().isNotEmpty
          ? humanHospitalDiscountMedicines.text.trim()
          : veterinaryHospitalDiscountMedicines.text.trim(),

      // Shared
      surgeriesOtherServicesDiscount:
          surgeriesOtherServicesDiscount.text.trim(),

      // Pharmacy fields
      localMedicinesDiscount:
          humanPharmacyDiscountLocalMedicine.text.trim().isNotEmpty
              ? humanPharmacyDiscountLocalMedicine.text.trim()
              : veterinaryPharmacyDiscountLocalMedicine.text.trim(),
      importedMedicinesDiscount:
          humanPharmacyDiscountImportedMedicine.text.trim().isNotEmpty
              ? humanPharmacyDiscountImportedMedicine.text.trim()
              : veterinaryPharmacyDiscountImportedMedicine.text.trim(),
      medicalSuppliesDiscount:
          humanPharmacyDiscountMedicalSupplies.text.trim().isNotEmpty
              ? humanPharmacyDiscountMedicalSupplies.text.trim()
              : veterinaryPharmacyDiscountMedicalSupplies.text.trim(),
      isHomeDelivery: selectedService.value == 'human_pharmacy'
          ? humanPharmacyIsHome.value
          : (selectedService.value == 'veterinary_pharmacy'
              ? veterinaryPharmacyIsHome.value
              : null),

      // Lab Test fields
      allTestsDiscount: labTestDiscountAllTypes.text.trim(),
      isHomeService: labTestIsHome.value,

      // Radiology fields
      xRayDiscount: xRayDiscount.text.trim(),

      // Eye Care fields
      glassesDiscount: eyeCareDiscountGlasses.text.trim(),
      sunglassesDiscount: eyeCareDiscountSunGlasses.text.trim(),
      contactLensesDiscount: contactLensesController.text.trim(),
      eyeExamDiscount: eyeCareDiscountEyeExam.text.trim(),
      isDelivery: eyeCareIsDelivery.value,

      // Gym fields
      gymMonthSubPriceB: gymMonthSubPriceB.text.trim(),
      gymMonthSubPriceA: gymMonthSubPriceA.text.trim(),
      gymMonth3SubPriceB: gymMonth3SubPriceB.text.trim(),
      gymMonth3SubPriceA: gymMonth3SubPriceA.text.trim(),
      gymMonth6SubPriceB: gymMonth6SubPriceB.text.trim(),
      gymMonth6SubPriceA: gymMonth6SubPriceA.text.trim(),
      gymMonth12SubPriceB: gymMonth12SubPriceB.text.trim(),
      gymMonth12SubPriceA: gymMonth12SubPriceA.text.trim(),

      otherDiscount: discountOther.text.trim(),

      branches: branchesData,
    );

    // Send to backend
    _sendToBackend(serviceData);
  }

  void _sendToBackend(ServiceData serviceData) {
    // TODO: Implement actual backend integration
    printDM('Service Data with Branches: ${serviceData.toJson()}');

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
    // Basic form controllers
    serviceNameController.dispose();
    serviceDescriptionController.dispose();
    facebookController.dispose();
    instagramController.dispose();
    tiktokController.dispose();
    youtubeController.dispose();

    for (var controller in branchAddressControllers) {
      controller.dispose();
    }
    for (var controller in branchPhoneControllers) {
      controller.dispose();
    }
    for (var controller in branchWhatsappControllers) {
      controller.dispose();
    }

    // xRay controllers
    xRay.dispose();
    xRayDiscount.dispose();

    // Gym controllers
    gymMonthSubPriceB.dispose();
    gymMonthSubPriceA.dispose();
    gymMonth3SubPriceB.dispose();
    gymMonth3SubPriceA.dispose();
    gymMonth6SubPriceB.dispose();
    gymMonth6SubPriceA.dispose();
    gymMonth12SubPriceB.dispose();
    gymMonth12SubPriceA.dispose();
    discountOther.dispose();

    // Human Hospital controllers
    humanHospitalDiscountExaminations.dispose();
    humanHospitalDiscountMedicalTest.dispose();
    humanHospitalDiscountXRay.dispose();
    humanHospitalDiscountMedicines.dispose();

    // Human Doctor controllers
    humanDoctorPriceBefore.dispose();
    humanDoctorPriceAfter.dispose();

    // Veterinary Doctor controllers
    veterinaryDoctorPriceBefore.dispose();
    veterinaryDoctorPriceAfter.dispose();

    // Eye Care controllers
    eyeCareDiscountGlasses.dispose();
    eyeCareDiscountSunGlasses.dispose();
    contactLensesController.dispose();
    eyeCareDiscountEyeExam.dispose();

    // Lab Test controllers
    labTestDiscountAllTypes.dispose();

    // Human Pharmacy controllers
    humanPharmacyDiscountLocalMedicine.dispose();
    humanPharmacyDiscountImportedMedicine.dispose();
    humanPharmacyDiscountMedicalSupplies.dispose();

    // Veterinary Pharmacy controllers
    veterinaryPharmacyDiscountLocalMedicine.dispose();
    veterinaryPharmacyDiscountImportedMedicine.dispose();
    veterinaryPharmacyDiscountMedicalSupplies.dispose();

    // Veterinary Hospital controllers
    veterinaryHospitalDiscountExaminations.dispose();
    veterinaryHospitalDiscountMedicalTest.dispose();
    veterinaryHospitalDiscountXRay.dispose();
    veterinaryHospitalDiscountMedicines.dispose();

    surgeriesOtherServicesDiscount.dispose();

    super.onClose();
  }
}
