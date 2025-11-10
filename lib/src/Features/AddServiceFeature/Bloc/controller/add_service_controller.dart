import 'dart:convert';
import 'dart:io';

import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/Model/add_service_model.dart';
import 'package:Alegny_provider/src/Features/BaseBNBFeature/UI/screens/base_BNB_screen.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/controller/services_controller.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/service_model.dart';
import 'package:Alegny_provider/src/core/constants/app_assets.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/services/services_locator.dart';
import '../repo/add_service_repo.dart';

class AddServiceController extends BaseController<CreateServiceRepository> {
  @override
  get repository => sl<CreateServiceRepository>();
  final ServiceModel? serviceToEdit;
  final RxInt currentStep = 0.obs;
  final bool isEditingMode;

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
  final RxString serviceImageUrl = ''.obs;

  final List<Branch> branches = <Branch>[].obs;

  final List<TextEditingController> branchAddressControllers = [];
  final List<TextEditingController> branchPhoneControllers = [];
  final List<TextEditingController> branchWhatsappControllers = [];
  final List<RxString> branchSelectedCities = [];
  final List<RxString> branchSelectedGovernorates = [];
  final List<Map<String, String>> branchWorkingHours = [];
  final List<Rxn<double>> branchLatitudes = [];
  final List<Rxn<double>> branchLongitudes = [];

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
    // Reset specialization when service type changes
    selectedSpecialization.value = null;
    update();
  }

  void setSelectedSpecialization(String? specialization) {
    selectedSpecialization.value = specialization;
    update();
  }

  List<String> getSpecializationsForService(String? serviceType) {
    if (serviceType == null) return [];

    if (serviceType == 'human_hospital' || serviceType == 'human_pharmacy') {
      // Return list with "جميع التخصصات" first, then the rest
      return ['all_specializations', ...specializations];
    } else if (serviceType == 'human_doctor') {
      // Return original list for human doctor (without "جميع التخصصات")
      return List.from(specializations);
    }
    return [];
  }

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

  // Helper method to get unique governorates
  List<String> get uniqueGovernorates {
    final uniqueList = governorates.toSet().toList();
    // Sort to maintain consistent order
    uniqueList.sort();
    return uniqueList;
  }

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
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final whatsappController = TextEditingController();
    final selectedCity = ''.obs;
    final selectedGovernorate = ''.obs;
    final workingHours = <String, String>{}.obs;

    branchAddressControllers.add(addressController);
    branchPhoneControllers.add(phoneController);
    branchWhatsappControllers.add(whatsappController);
    branchSelectedCities.add(selectedCity);
    branchSelectedGovernorates.add(selectedGovernorate);
    branchWorkingHours.add(workingHours);
    branchLatitudes.add(Rxn<double>());
    branchLongitudes.add(Rxn<double>());

    final newBranch = Branch(
      address: '',
      phoneNumber: '',
      whatsAppNumber: '',
      workingHours: workingHours,
      selectedCity: selectedCity.value,
      selectedGovernorate: selectedGovernorate.value,
      latitude: null,
      longitude: null,
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
      branchLatitudes.removeAt(index);
      branchLongitudes.removeAt(index);

      branches.removeAt(index);
      update();
    }
  }

  void updateBranchData(int index) {
    if (index < branches.length) {
      final workingHours = branchWorkingHours[index] ?? <String, String>{};
      final cleanedWorkingHours = Map<String, String>.from(workingHours)
        ..removeWhere((key, value) => value.isEmpty);

      final updatedBranch = Branch(
        address: branchAddressControllers[index].text.trim(),
        phoneNumber: branchPhoneControllers[index].text.trim(),
        whatsAppNumber: branchWhatsappControllers[index].text.trim(),
        selectedGovernorate: branchSelectedGovernorates[index].value,
        selectedCity: branchSelectedCities[index].value,
        workingHours: cleanedWorkingHours,
        latitude: branchLatitudes[index].value,
        longitude: branchLongitudes[index].value,
      );

      branches[index] = updatedBranch;
    }
  }

  // Method to set location for a specific branch
  void setBranchLocation(int branchIndex, double latitude, double longitude) {
    if (branchIndex < branchLatitudes.length) {
      branchLatitudes[branchIndex].value = latitude;
      branchLongitudes[branchIndex].value = longitude;
      updateBranchData(branchIndex);
      update();
    }
  }

  void updateAllBranches() {
    print('=== DEBUG UPDATE ALL BRANCHES ===');
    for (int i = 0; i < branches.length; i++) {
      print('Updating branch $i:');
      print('  Address controller: "${branchAddressControllers[i].text}"');
      print('  Phone controller: "${branchPhoneControllers[i].text}"');
      print('  WhatsApp controller: "${branchWhatsappControllers[i].text}"');

      // Ensure working hours is not null and is properly formatted
      final workingHours = branchWorkingHours[i] ?? <String, String>{};

      // Clean working hours - remove empty entries
      final cleanedWorkingHours = Map<String, String>.from(workingHours)
        ..removeWhere((key, value) => value.isEmpty);

      final updatedBranch = Branch(
        address: branchAddressControllers[i].text.trim(),
        phoneNumber:
            branchPhoneControllers[i].text.trim(), // Make sure this is set
        whatsAppNumber:
            branchWhatsappControllers[i].text.trim(), // Make sure this is set
        selectedGovernorate: branchSelectedGovernorates[i].value,
        selectedCity: branchSelectedCities[i].value,
        workingHours: cleanedWorkingHours,
        latitude: branchLatitudes[i].value,
        longitude: branchLongitudes[i].value,
      );

      branches[i] = updatedBranch;

      print('  Updated branch phone: "${branches[i].phoneNumber}"');
      print('  Updated branch whatsapp: "${branches[i].whatsAppNumber}"');
    }
    print('=================================');
    update();
  }

  final List<bool Function()> _stepValidators = [];

  AddServiceController({this.serviceToEdit})
      : isEditingMode = serviceToEdit != null {
    _initializeValidators();
    addBranch(); // Create first branch
    if (isEditingMode) {
      _populateFormForEditing();
    }
  }
  void _populateFormForEditing() {
    if (serviceToEdit == null) return;

    final service = serviceToEdit!;

    // Step 1: Basic Information
    serviceNameController.text = service.serviceName;
    selectedService.value = service.serviceType;
    selectedSpecialization.value = service.specialization;

    // Load image URL if available
    if (service.imageUrl != null && service.imageUrl!.isNotEmpty) {
      serviceImageUrl.value = service.imageUrl!;
      print('Service image URL loaded: ${service.imageUrl}');
    } else {
      serviceImageUrl.value = '';
      serviceImage.value = null;
    }

    // Clear existing branches and populate with service branches
    _clearAllBranches();
    for (final branch in service.branches) {
      _addBranchFromModel(branch);
    }

    // Step 2: Discounts and Pricing
    _populateDiscountsFromModel(service);

    update();
  }

  void removeServiceImage() {
    serviceImage.value = null;
    serviceImageUrl.value = ''; // Clear the URL to indicate removal
    update();
  }

  void _clearAllBranches() {
    // Dispose all existing branch controllers
    for (var controller in branchAddressControllers) {
      controller.dispose();
    }
    for (var controller in branchPhoneControllers) {
      controller.dispose();
    }
    for (var controller in branchWhatsappControllers) {
      controller.dispose();
    }

    // Clear all lists
    branchAddressControllers.clear();
    branchPhoneControllers.clear();
    branchWhatsappControllers.clear();
    branchSelectedCities.clear();
    branchSelectedGovernorates.clear();
    branchWorkingHours.clear();
    branchLatitudes.clear();
    branchLongitudes.clear();
    branches.clear();
  }

  void _addBranchFromModel(BranchModel branchModel) {
    final addressController = TextEditingController(text: branchModel.address);
    final phoneController =
        TextEditingController(text: branchModel.phoneNumber);
    final whatsappController =
        TextEditingController(text: branchModel.whatsapp);
    final selectedCity = branchModel.city.obs;
    final selectedGovernorate = branchModel.governorate.obs;
    final workingHours = Map<String, String>.from(branchModel.workingHours);

    branchAddressControllers.add(addressController);
    branchPhoneControllers.add(phoneController);
    branchWhatsappControllers.add(whatsappController);
    branchSelectedCities.add(selectedCity);
    branchSelectedGovernorates.add(selectedGovernorate);
    branchWorkingHours.add(workingHours);
    branchLatitudes.add(Rxn<double>(branchModel.latitude));
    branchLongitudes.add(Rxn<double>(branchModel.longitude));

    final newBranch = Branch(
      address: branchModel.address,
      phoneNumber: branchModel.phoneNumber,
      whatsAppNumber: branchModel.whatsapp,
      workingHours: workingHours,
      selectedCity: branchModel.city,
      selectedGovernorate: branchModel.governorate,
      latitude: branchModel.latitude,
      longitude: branchModel.longitude,
    );

    branches.add(newBranch);
  }

  void _populateDiscountsFromModel(ServiceModel service) {
    final discounts = service.discounts;

    // Gym fields
    if (service.serviceType == 'gym') {
      gymMonthSubPriceA.text =
          discounts['gym_month_sub_price_a']?.toString() ?? '';
      gymMonthSubPriceB.text =
          discounts['gym_month_sub_price_b']?.toString() ?? '';
      gymMonth3SubPriceA.text =
          discounts['gym_month_3_sub_price_a']?.toString() ?? '';
      gymMonth3SubPriceB.text =
          discounts['gym_month_3_sub_price_b']?.toString() ?? '';
      gymMonth6SubPriceA.text =
          discounts['gym_month_6_sub_price_a']?.toString() ?? '';
      gymMonth6SubPriceB.text =
          discounts['gym_month_6_sub_price_b']?.toString() ?? '';
      gymMonth12SubPriceA.text =
          discounts['gym_month_12_sub_price_a']?.toString() ?? '';
      gymMonth12SubPriceB.text =
          discounts['gym_month_12_sub_price_b']?.toString() ?? '';
      discountOther.text = discounts['other_discount']?.toString() ?? '';
    }

    // Human Doctor fields
    if (service.serviceType == 'human_doctor') {
      humanDoctorPriceBefore.text =
          discounts['consultation_price_before']?.toString() ?? '';
      humanDoctorPriceAfter.text =
          discounts['consultation_price_after']?.toString() ?? '';
      humanDoctorIsHome.value = discounts['is_home_visit'] == 'true';
      humanDoctorIsCard.value = discounts['home_discount'] == 'true';
    }

    // Veterinary Doctor fields
    if (service.serviceType == 'veterinarian') {
      veterinaryDoctorPriceBefore.text =
          discounts['consultation_price_before']?.toString() ?? '';
      veterinaryDoctorPriceAfter.text =
          discounts['consultation_price_after']?.toString() ?? '';
      veterinaryDoctorIsHome.value = discounts['is_home_visit'] == 'true';
      veterinaryDoctorIsCard.value = discounts['home_discount'] == 'true';
    }

    // Hospital fields (Human & Veterinary)
    if (service.serviceType == 'human_hospital' ||
        service.serviceType == 'veterinary_hospital') {
      humanHospitalDiscountExaminations.text =
          discounts['examinations_discount']?.toString() ?? '';
      humanHospitalDiscountMedicalTest.text =
          discounts['medical_tests_discount']?.toString() ?? '';
      humanHospitalDiscountXRay.text =
          discounts['xray_discount']?.toString() ?? '';
      humanHospitalDiscountMedicines.text =
          discounts['medicines_discount']?.toString() ?? '';
    }

    // Pharmacy fields (Human & Veterinary)
    if (service.serviceType == 'human_pharmacy' ||
        service.serviceType == 'veterinary_pharmacy') {
      humanPharmacyDiscountLocalMedicine.text =
          discounts['local_medicines_discount']?.toString() ?? '';
      humanPharmacyDiscountImportedMedicine.text =
          discounts['imported_medicines_discount']?.toString() ?? '';
      humanPharmacyDiscountMedicalSupplies.text =
          discounts['medical_supplies_discount']?.toString() ?? '';
      humanPharmacyIsHome.value = discounts['is_home_delivery'] == 'true';
    }

    // Lab Test fields
    if (service.serviceType == 'lab') {
      labTestDiscountAllTypes.text =
          discounts['all_tests_discount']?.toString() ?? '';
      labTestIsHome.value = discounts['is_home_service'] == 'true';
    }

    // Radiology fields
    if (service.serviceType == 'radiology_center') {
      xRayDiscount.text = discounts['xray_discount']?.toString() ?? '';
    }

    // Eye Care fields
    if (service.serviceType == 'optics') {
      eyeCareDiscountGlasses.text =
          discounts['glasses_discount']?.toString() ?? '';
      eyeCareDiscountSunGlasses.text =
          discounts['sunglasses_discount']?.toString() ?? '';
      contactLensesController.text =
          discounts['contact_lenses_discount']?.toString() ?? '';
      eyeCareDiscountEyeExam.text =
          discounts['eye_exam_discount']?.toString() ?? '';
      eyeCareIsDelivery.value = discounts['is_delivery'] == 'true';
    }

    // Shared fields
    surgeriesOtherServicesDiscount.text =
        discounts['surgeries_other_services_discount']?.toString() ?? '';
  }

  void submitService() {
    updateAllBranches();

    final branchesData = branches.map((branch) => branch.toJson()).toList();

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

      // Lab
      allTestsDiscount: labTestDiscountAllTypes.text.trim(),
      isHomeService: labTestIsHome.value,

      // Radiology fields
      xRayDiscount: xRayDiscount.text.trim(),

      // Eye Care fields
      glassesDiscount: eyeCareDiscountGlasses.text.trim(),
      sunglassesDiscount: eyeCareDiscountSunGlasses.text.trim(),
      contactLensesDiscount: contactLensesController.text.trim(),
      eyeExamDiscount: eyeCareDiscountEyeExam.text.trim(),
      isDelivery:
          selectedService.value == 'optics' ? eyeCareIsDelivery.value : null,

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
    if (isEditingMode) {
      updateService(
        serviceId: serviceToEdit!.id,
        serviceData: serviceData,
        imageFile: serviceImage.value,
      );
    } else {
      _createService(serviceData);
    }
  }

  void _createService(ServiceData serviceData) async {
    showEasyLoading();

    final result = await repository!.createService(serviceData);

    closeEasyLoading();

    result.when(
      success: (response) {
        print('DEBUG createService response: ${response.runtimeType}');
        print(response.data);
        successEasyLoading(response.data['message'] ??
            (isEditingMode
                ? 'service_updated_successfully'.tr
                : 'service_created_successfully'.tr));
        printDM('✅ Service Created: ${response.data}');
        printDM('result ${serviceData.toJson()}');
        Get.offAll(const BaseBNBScreen());
      },
      failure: (error) {
        actionNetworkExceptions(error);
      },
    );
  }

  Future<bool> updateService({
    required String serviceId,
    required ServiceData serviceData,
    File? imageFile,
  }) async {
    try {
      showEasyLoading();

      final result = await repository!.updateService(
        serviceId: serviceId,
        serviceData: serviceData,
        imageFile: imageFile,
      );

      closeEasyLoading();

      return result.when(
        success: (response) {
          successEasyLoading(
            response.data['message'] ?? 'service_updated_successfully'.tr,
          );

          // Navigate back and let the parent screen refresh
          Get.offAll(const BaseBNBScreen());

          return true;
        },
        failure: (error) {
          // Show user-friendly message for concurrency errors
          if (error.toString().toLowerCase().contains('affected 0 row')) {
            errorEasyLoading('service_modified_please_try_again'.tr);
          } else {
            actionNetworkExceptions(error);
          }
          return false;
        },
      );
    } catch (e) {
      closeEasyLoading();
      errorEasyLoading('failed_to_update_service'.tr);
      return false;
    }
  }

  void _initializeValidators() {
    _stepValidators
      ..add(_validateStep1)
      ..add(_validateStep2)
      ..add(_validateStep3);
  }

  bool _validateStep1() {
    // For editing: if we have an image URL, it's valid even if serviceImage.value is null
    // For creating: we need an actual image file
    if (isEditingMode) {
      // In edit mode, it's valid if we have either an existing image URL OR a new image file
      if (serviceImageUrl.value.isEmpty && serviceImage.value == null) {
        _showError('please_upload_picture'.tr);
        return false;
      }
    } else {
      // In create mode, we must have an image file
      if (serviceImage.value == null) {
        _showError('please_upload_picture'.tr);
        return false;
      }
    }
    if (selectedService.value == null) {
      _showError('please_select_service'.tr);
      return false;
    }
    if (selectedService.value == 'human_doctor' ||
        selectedService.value == 'human_hospital' ||
        selectedService.value == 'human_pharmacy') {
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
      if (branchWhatsappControllers[i].text.trim().isEmpty) {
        _showError('${'please_enter_whatsapp'.tr} ${'for_branch'.tr} ${i + 1}');
        return false;
      }

      if (!_validateWorkingHours(branchWorkingHours[i])) {
        _showError(
            '${'please_set_proper_working_hours'.tr} ${'for_branch'.tr} ${i + 1}');
        return false;
      }
    }
    return true;
  }

  bool _validateWorkingHours(Map<String, String> workingHours) {
    bool hasAtLeastOneOpenDay = false;

    final days = [
      'saturday',
      'sunday',
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday'
    ];

    for (final day in days) {
      final hours = workingHours[day] ?? '';

      if (hours.isNotEmpty &&
          hours.toLowerCase() != 'closed'.tr.toLowerCase()) {
        hasAtLeastOneOpenDay = true;
      }
    }

    // At least one day should be open with valid times
    if (!hasAtLeastOneOpenDay) {
      _showError('at_least_one_open_day_required'.tr);
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
        update();
      }
    } else {
      if (_validateStep3()) {
        submitService();
      }
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
