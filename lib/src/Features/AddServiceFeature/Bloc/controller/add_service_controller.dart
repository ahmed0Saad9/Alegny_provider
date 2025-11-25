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
    // Store the previous service type
    final previousService = selectedService.value;

    // Update the selected service
    selectedService.value = service;

    // Only clear fields if service type actually changed and we're not in editing mode
    if (previousService != null &&
        previousService != service &&
        !isEditingMode) {
      _clearPreviousServiceTypeFields();
    }

    // Reset specialization when service type changes
    selectedSpecialization.value = null;
    update();
  }

  void _clearPreviousServiceTypeFields() {
    // Clear all doctor fields
    humanDoctorPriceBefore.clear();
    humanDoctorPriceAfter.clear();
    humanDoctorIsHome.value = false;
    humanDoctorIsCard.value = false;

    veterinaryDoctorPriceBefore.clear();
    veterinaryDoctorPriceAfter.clear();
    veterinaryDoctorIsHome.value = false;
    veterinaryDoctorIsCard.value = false;

    // Clear all hospital fields
    humanHospitalDiscountExaminations.clear();
    humanHospitalDiscountMedicalTest.clear();
    humanHospitalDiscountXRay.clear();
    humanHospitalDiscountMedicines.clear();

    veterinaryHospitalDiscountExaminations.clear();
    veterinaryHospitalDiscountMedicalTest.clear();
    veterinaryHospitalDiscountXRay.clear();
    veterinaryHospitalDiscountMedicines.clear();

    // Clear all pharmacy fields
    humanPharmacyDiscountLocalMedicine.clear();
    humanPharmacyDiscountImportedMedicine.clear();
    humanPharmacyDiscountMedicalSupplies.clear();
    humanPharmacyIsHome.value = false;
    humanPharmacyIsCard.value = false;

    veterinaryPharmacyDiscountLocalMedicine.clear();
    veterinaryPharmacyDiscountImportedMedicine.clear();
    veterinaryPharmacyDiscountMedicalSupplies.clear();
    veterinaryPharmacyIsHome.value = false;
    veterinaryPharmacyIsCard.value = false;

    // Clear lab fields
    labTestDiscountAllTypes.clear();
    labTestIsHome.value = false;
    labTestIsCard.value = false;

    // Clear radiology fields
    xRayDiscount.clear();

    // Clear eye care fields
    eyeCareDiscountGlasses.clear();
    eyeCareDiscountSunGlasses.clear();
    contactLensesController.clear();
    eyeCareDiscountEyeExam.clear();
    eyeCareIsDelivery.value = false;
    eyeCareIsCard.value = false;

    // Clear gym fields
    gymMonthSubPriceB.clear();
    gymMonthSubPriceA.clear();
    gymMonth3SubPriceB.clear();
    gymMonth3SubPriceA.clear();
    gymMonth6SubPriceB.clear();
    gymMonth6SubPriceA.clear();
    gymMonth12SubPriceB.clear();
    gymMonth12SubPriceA.clear();
    discountOther.clear();

    // Clear shared fields
    surgeriesOtherServicesDiscount.clear();
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
    'cairo',
    'giza',
    'alexandria',
    'dakahlia',
    'red_sea',
    'beheira',
    'faiyum',
    'gharbia',
    'ismailia',
    'monufia',
    'minya',
    'qalyubia',
    'new_valley',
    'suez',
    'aswan',
    'asyut',
    'beni_suef',
    'port_said',
    'damietta',
    'sharqia',
    'south_sinai',
    'kafr_el_sheikh',
    'matrouh',
    'luxor',
    'qena',
    'north_sinai',
    'sohag',
  ];

  static const Map<String, List<String>> citiesByGovernorate = {
    'cairo': [
      'maadi',
      'mokattam',
      'nasr_city',
      'heliopolis',
      'zamalek',
      'dokki',
      'mohandessin',
      'downtown',
      'ramses',
      'bab_el_shaaria',
      'moski',
      'el_nozha',
      'roxy',
      'mataria',
      'el_marg',
      'zeitoun',
      'ezbet_el_nakhl',
      'hadayek_el_qobbah',
      'old_cairo',
    ],
    'giza': [
      'dokki',
      'mohandessin',
      'agouza',
      'harram',
      'faisal',
      'october_city',
      'omrania',
      'warraq',
      'sheikh_zayed_city',
      'mansheyat_al_qanater',
      'osim',
      'kerdasa',
      'abu_el_nomros',
      'hawamdeya',
      'badrashin',
      'ayyat',
      'saf',
      'atfih',
    ],
    'alexandria': [
      'montaza',
      'smouha',
      'siouf',
      'asafra',
      'labban',
      'raml',
      'shatby',
      'azarita',
      'camp_caesar',
      'ibrahimia',
      'kom_el_deka',
      'maharam_bek',
      'east_alexandria',
      'lauren',
      'zizinia',
      'bolkly',
      'fleming',
      'shots',
      'san_stefano',
      'kafr_abdo',
    ],
    'dakahlia': [
      'mansoura',
      'talkha',
      'mit_ghamr',
      'belqas',
      'aga',
      'menia_el_nasr',
      'sinbillawin',
      'el_manzala',
      'sherbin',
      'mit_salsil',
      'bani_ebeid',
      'gamasa',
      'nabaroh',
      'el_kurdi',
      'mahalet_demna',
      'gamalia',
    ],
    'red_sea': ['marsa_alam', 'ras_ghareb'],
    'hurghada': [
      'safaga',
    ],
    'beheira': [
      'damanhur',
      'kafr_el_dawar',
      'edko',
      'abu_el_matamir',
      'abu_hummus',
      'hosh_essa',
      'delengat',
      'rashid',
      'itay_el_barud',
      'wadi_el_natrun',
    ],
    'faiyum': ['faiyum_city', 'tamiya', 'sinnuris'],
    'gharbia': [
      'tanta',
      'el_mahalla_el_kubra',
      'zefta',
      'samannoud',
      'kafr_el_zayat',
      'basion',
      'qutour',
      'santah',
    ],
    'ismailia': [
      'ismailia_city',
      'fayed',
      'qantara',
      'el_tal_el_kebir',
      'qantara_east',
      'qantara_west',
    ],
    'monufia': [
      'shebin_el_kom',
      'menouf',
      'ashmoun',
      'bagour',
      'sadat_city',
      'quesna',
      'tala',
      'el_shohada',
      'berket_el_sabaa',
    ],
    'minya': [
      'minya_city',
      'malawi',
      'deir_mawas',
      'el_edwa',
      'maghagha',
      'beni_mazar',
      'matai',
      'samalout',
      'abu_qurqas',
      'malawi',
    ],
    'qalyubia': [
      'banha',
      'qalyub',
      'shubra_el_kheima',
      'el_khanka',
      'kafr_shukr',
      'tukh',
      'shibin_el_qanater',
      'khanka',
      'qaha',
      'obour_city',
      'khosous',
    ],
    'new_valley': ['kharga', 'dakhla', 'paris'],
    'suez': [
      'suez_city',
      'arbaeen',
      'suez_district',
      'arbaeen_district',
      'attaka_district',
      'el_ganayen_district',
      'ain_sokhna',
      'green_island',
      'shatt',
      'houd_el_dars',
      'port_tawfik',
      'craftsmen_city',
      'el_sabah',
      'el_amal',
      'mubarak',
      'cooperations',
      'salam',
      'nour',
      'ferdous',
      'tawfiqia',
      'arab_el_maamal_area',
    ],
    'aswan': [
      'aswan_city',
      'kom_ombo',
      'daraw',
      'new_aswan_city',
      'aswan_center',
      'abu_simbel_center',
      'daraw_center',
      'kom_ombo_center',
      'nasr_el_nuba_center',
      'edfu_center',
    ],
    'asyut': ['asyut_city', 'abnub', 'dayrout', 'manfalut'],
    'beni_suef': ['beni_suef_city', 'el_wasta', 'naser'],
    'port_said': ['port_said_city', 'east_district', 'west_district'],
    'damietta': ['damietta_city', 'faraskour', 'zarqa'],
    'sharqia': [
      'zagazig',
      'abu_hamad',
      'belbeis',
      'hehya',
      'abu_kabir',
      'ibrahimia_sharqia',
      'awlad_saqr',
      'husseiniya',
      'deirb_negm',
      'el_qurin',
      'kafr_saqr',
      'menia_el_qamh',
      'mashtool_el_souk',
      'faques',
      'new_salheya',
      'tenth_of_ramadan_city',
    ],
    'south_sinai': ['sharm_el_sheikh', 'dahab', 'nuweiba'],
    'kafr_el_sheikh': ['kafr_el_sheikh_city', 'desouk', 'fuwa'],
    'matrouh': [
      'marsa_matrouh',
      'hamam',
      'nagila',
      'el_alamein',
      'dabaa',
      'marsa_matrouh',
      'nagila',
      'sidi_barrani',
      'salloum',
      'siwa',
    ],
    'luxor': ['luxor_city', 'qurna', 'esna'],
    'qena': ['qena_city', 'qift', 'naqada'],
    'north_sinai': ['el_arish', 'sheikh_zuweid', 'rafah'],
    'sohag': ['sohag_city', 'girga', 'akhmim'],
  };

  // Helper method to get unique governorates
  List<String> get uniqueGovernorates {
    final uniqueList = governorates.toSet().toList();
    // Sort to maintain consistent order
    uniqueList.sort();
    return uniqueList;
  }

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
        phoneNumber: branchPhoneControllers[i].text.trim(),
        // Make sure this is set
        whatsAppNumber: branchWhatsappControllers[i].text.trim(),
        // Make sure this is set
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
    serviceDescriptionController.text = service.description ?? '';
    facebookController.text = service.facebookUrl ?? '';
    instagramController.text = service.instagramUrl ?? '';
    tiktokController.text = service.tikTokUrl ?? '';
    youtubeController.text = service.youTubeUrl ?? '';
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

    // Hospital fields (Human)
    if (service.serviceType == 'human_hospital') {
      humanHospitalDiscountExaminations.text =
          discounts['examinations_discount']?.toString() ?? '';
      humanHospitalDiscountMedicalTest.text =
          discounts['medical_tests_discount']?.toString() ?? '';
      humanHospitalDiscountXRay.text =
          discounts['hospital_xray_discount']?.toString() ?? '';
      humanHospitalDiscountMedicines.text =
          discounts['medicines_discount']?.toString() ?? '';
    }
    // Hospital fields (vet)
    if (service.serviceType == 'veterinary_hospital') {
      veterinaryHospitalDiscountExaminations.text =
          discounts['examinations_discount']?.toString() ?? '';
      veterinaryHospitalDiscountMedicalTest.text =
          discounts['medical_tests_discount']?.toString() ?? '';
      veterinaryHospitalDiscountXRay.text =
          discounts['hospital_xray_discount']?.toString() ?? '';
      veterinaryHospitalDiscountMedicines.text =
          discounts['medicines_discount']?.toString() ?? '';
    }

    // Pharmacy fields (Human )
    if (service.serviceType == 'human_pharmacy') {
      humanPharmacyDiscountLocalMedicine.text =
          discounts['local_medicines_discount']?.toString() ?? '';
      humanPharmacyDiscountImportedMedicine.text =
          discounts['imported_medicines_discount']?.toString() ?? '';
      humanPharmacyDiscountMedicalSupplies.text =
          discounts['medical_supplies_discount']?.toString() ?? '';
      humanPharmacyIsHome.value = discounts['is_home_delivery'] == 'true';
      humanPharmacyIsCard.value = discounts['pharmacy_is_home_card'] == 'true';
    }
    // Pharmacy fields (Veterinary)
    if (service.serviceType == 'veterinary_pharmacy') {
      veterinaryPharmacyDiscountLocalMedicine.text =
          discounts['local_medicines_discount']?.toString() ?? '';
      veterinaryPharmacyDiscountImportedMedicine.text =
          discounts['imported_medicines_discount']?.toString() ?? '';
      veterinaryPharmacyDiscountMedicalSupplies.text =
          discounts['medical_supplies_discount']?.toString() ?? '';
      veterinaryPharmacyIsHome.value = discounts['is_home_delivery'] == 'true';
      veterinaryPharmacyIsCard.value =
          discounts['pharmacy_is_home_card'] == 'true';
    }

    // Lab Test fields
    if (service.serviceType == 'lab') {
      labTestDiscountAllTypes.text =
          discounts['all_tests_discount']?.toString() ?? '';
      labTestIsHome.value = discounts['is_home_service'] == 'true';
      labTestIsCard.value = discounts['is_home_card'] == 'true';
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
      eyeCareIsCard.value = discounts['eye_care_is_card'] == 'true';
    }

    // Shared fields
    surgeriesOtherServicesDiscount.text =
        discounts['surgeries_other_services_discount']?.toString() ?? '';
  }

  void submitService() {
    updateAllBranches();

    final branchesData = branches.map((branch) => branch.toJson()).toList();

    // Create base service data with only common fields
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

      branches: branchesData,
    );

    // ONLY set fields specific to the current service type
    _setServiceSpecificFields(serviceData);

    // Debug: Print what's being sent
    _debugPrintServiceData(serviceData);

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

  void _setServiceSpecificFields(ServiceData serviceData) {
    final currentService = selectedService.value;

    // Helper function to add % to percentage fields
    String? _formatPercentage(String value) {
      if (value.trim().isEmpty) return null;
      // Remove any existing % and add it back
      final cleanedValue = value.replaceAll('%', '').trim();
      return '$cleanedValue%';
    }

    // Helper function for regular fields
    String? _getFieldValue(String value) {
      if (value.trim().isEmpty) return null;
      return value.trim();
    }

    // Now set only the fields for the current service type
    switch (currentService) {
      case 'human_doctor':
        serviceData.consultationPriceBefore =
            _getFieldValue(humanDoctorPriceBefore.text);
        serviceData.consultationPriceAfter =
            _getFieldValue(humanDoctorPriceAfter.text);
        serviceData.isHomeVisit = humanDoctorIsHome.value;
        serviceData.homeDiscount = humanDoctorIsCard.value;
        serviceData.surgeriesOtherServicesDiscount =
            _formatPercentage(surgeriesOtherServicesDiscount.text);
        break;

      case 'veterinarian':
        serviceData.consultationPriceBefore =
            _getFieldValue(veterinaryDoctorPriceBefore.text);
        serviceData.consultationPriceAfter =
            _getFieldValue(veterinaryDoctorPriceAfter.text);
        serviceData.isHomeVisit = veterinaryDoctorIsHome.value;
        serviceData.homeDiscount = veterinaryDoctorIsCard.value;
        serviceData.surgeriesOtherServicesDiscount =
            _formatPercentage(surgeriesOtherServicesDiscount.text);
        break;

      case 'human_hospital':
        serviceData.examinationsDiscount =
            _formatPercentage(humanHospitalDiscountExaminations.text);
        serviceData.medicalTestsDiscount =
            _formatPercentage(humanHospitalDiscountMedicalTest.text);
        serviceData.hospitalXrayDiscount =
            _formatPercentage(humanHospitalDiscountXRay.text);
        serviceData.medicinesDiscount =
            _formatPercentage(humanHospitalDiscountMedicines.text);
        serviceData.surgeriesOtherServicesDiscount =
            _formatPercentage(surgeriesOtherServicesDiscount.text);
        break;

      case 'veterinary_hospital':
        serviceData.examinationsDiscount =
            _formatPercentage(veterinaryHospitalDiscountExaminations.text);
        serviceData.medicalTestsDiscount =
            _formatPercentage(veterinaryHospitalDiscountMedicalTest.text);
        serviceData.hospitalXrayDiscount =
            _formatPercentage(veterinaryHospitalDiscountXRay.text);
        serviceData.medicinesDiscount =
            _formatPercentage(veterinaryHospitalDiscountMedicines.text);
        serviceData.surgeriesOtherServicesDiscount =
            _formatPercentage(surgeriesOtherServicesDiscount.text);
        break;

      case 'human_pharmacy':
        serviceData.localMedicinesDiscount =
            _formatPercentage(humanPharmacyDiscountLocalMedicine.text);
        serviceData.importedMedicinesDiscount =
            _formatPercentage(humanPharmacyDiscountImportedMedicine.text);
        serviceData.medicalSuppliesDiscount =
            _formatPercentage(humanPharmacyDiscountMedicalSupplies.text);
        serviceData.isHomeDelivery = humanPharmacyIsHome.value;
        serviceData.pharmacyIsHomeCard = humanPharmacyIsCard.value;
        break;

      case 'veterinary_pharmacy':
        serviceData.localMedicinesDiscount =
            _formatPercentage(veterinaryPharmacyDiscountLocalMedicine.text);
        serviceData.importedMedicinesDiscount =
            _formatPercentage(veterinaryPharmacyDiscountImportedMedicine.text);
        serviceData.medicalSuppliesDiscount =
            _formatPercentage(veterinaryPharmacyDiscountMedicalSupplies.text);
        serviceData.isHomeDelivery = veterinaryPharmacyIsHome.value;
        serviceData.pharmacyIsHomeCard = veterinaryPharmacyIsCard.value;
        break;

      case 'lab':
        serviceData.allTestsDiscount =
            _formatPercentage(labTestDiscountAllTypes.text);
        serviceData.isHomeService = labTestIsHome.value;
        serviceData.isHomeCard = labTestIsCard.value;
        break;

      case 'radiology_center':
        serviceData.xRayDiscount = _formatPercentage(xRayDiscount.text);
        break;

      case 'optics':
        serviceData.glassesDiscount =
            _formatPercentage(eyeCareDiscountGlasses.text);
        serviceData.sunglassesDiscount =
            _formatPercentage(eyeCareDiscountSunGlasses.text);
        serviceData.contactLensesDiscount =
            _formatPercentage(contactLensesController.text);
        serviceData.eyeExamDiscount =
            _formatPercentage(eyeCareDiscountEyeExam.text);
        serviceData.isDelivery = eyeCareIsDelivery.value;
        serviceData.eyeCareIsCard = eyeCareIsCard.value;
        break;

      case 'gym':
        serviceData.gymMonthSubPriceB = _getFieldValue(gymMonthSubPriceB.text);
        serviceData.gymMonthSubPriceA = _getFieldValue(gymMonthSubPriceA.text);
        serviceData.gymMonth3SubPriceB =
            _getFieldValue(gymMonth3SubPriceB.text);
        serviceData.gymMonth3SubPriceA =
            _getFieldValue(gymMonth3SubPriceA.text);
        serviceData.gymMonth6SubPriceB =
            _getFieldValue(gymMonth6SubPriceB.text);
        serviceData.gymMonth6SubPriceA =
            _getFieldValue(gymMonth6SubPriceA.text);
        serviceData.gymMonth12SubPriceB =
            _getFieldValue(gymMonth12SubPriceB.text);
        serviceData.gymMonth12SubPriceA =
            _getFieldValue(gymMonth12SubPriceA.text);
        serviceData.otherDiscount = _formatPercentage(discountOther.text);
        break;

      default:
        // For any other service type, don't set any specific fields
        break;
    }
  }

  void _debugPrintServiceData(ServiceData serviceData) {
    print('=== DEBUG SERVICE DATA ===');
    print('Service Type: ${serviceData.serviceType}');
    print('Consultation Price Before: ${serviceData.consultationPriceBefore}');
    print('Consultation Price After: ${serviceData.consultationPriceAfter}');
    print('Examinations Discount: ${serviceData.examinationsDiscount}');
    print('Medical Tests Discount: ${serviceData.medicalTestsDiscount}');
    print('Hospital XRay Discount: ${serviceData.hospitalXrayDiscount}');
    print('Medicines Discount: ${serviceData.medicinesDiscount}');
    print(
        'Surgeries Other Services Discount: ${serviceData.surgeriesOtherServicesDiscount}');
    print('Local Medicines Discount: ${serviceData.localMedicinesDiscount}');
    print(
        'Imported Medicines Discount: ${serviceData.importedMedicinesDiscount}');
    print('Medical Supplies Discount: ${serviceData.medicalSuppliesDiscount}');
    print('All Tests Discount: ${serviceData.allTestsDiscount}');
    print('XRay Discount: ${serviceData.xRayDiscount}');
    print('Glasses Discount: ${serviceData.glassesDiscount}');
    print('Sunglasses Discount: ${serviceData.sunglassesDiscount}');
    print('Contact Lenses Discount: ${serviceData.contactLensesDiscount}');
    print('Eye Exam Discount: ${serviceData.eyeExamDiscount}');
    print('Other Discount: ${serviceData.otherDiscount}');
    print('Is Home Visit: ${serviceData.isHomeVisit}');
    print('Home Discount: ${serviceData.homeDiscount}');
    print('Is Home Delivery: ${serviceData.isHomeDelivery}');
    print('Pharmacy Is Home Card: ${serviceData.pharmacyIsHomeCard}');
    print('Is Home Service: ${serviceData.isHomeService}');
    print('Is Home Card: ${serviceData.isHomeCard}');
    print('Is Delivery: ${serviceData.isDelivery}');
    print('Eye Care Is Card: ${serviceData.eyeCareIsCard}');
    print('==========================');
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
        Get.offAll(() => const BaseBNBScreen());
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
          Get.offAll(() => const BaseBNBScreen());

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
