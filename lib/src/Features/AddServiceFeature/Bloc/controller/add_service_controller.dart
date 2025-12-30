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
  final int? initialStep;

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
  final List<TextEditingController> branchLocationUrlControllers = [];
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

    if (serviceType == 'human_hospital') {
      // Return list with "all_specializations" first, then the rest
      return ['all_specializations', ...specializations];
    } else if (serviceType == 'human_doctor') {
      // Return original list for human doctor (without "all_specializations")
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
      'ain_shams',
      'zamalek',
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
      'sayeda_zeinab',
      'shubra',
      'helwan',
      'st_may',
      'new_cairo',
      'rehab_city',
      'madinaty',
      'sheraton',
      'agakhan',
      'ekhsas',
      'amerya',
      'tahrir',
      'helmiya',
      'tenth_district',
      'khalfawy',
      'khalifa_mamoun',
      'demerdash',
      'sawah',
      'sharabia',
      'shorouk',
      'daher',
      'abbassia',
      'fosat',
      'katameya',
      'korba',
      'almazah',
      'merghany',
      'maassara',
      'maqrizi',
      'manyal',
      'meriland',
      'meray',
      'ahly_club',
      'nozha',
      'helal',
      'waha',
      'wayli',
      'badr',
      'triumph',
      'gesr_suez',
      'hadayek_zaitoun',
      'hadayek_maadi',
      'helmiyet_el_zaitoun',
      'hamamat_qobbah',
      'dar_elsalam',
      'st_fatima',
      'saray_el_qobbah',
      'city_stars',
      'sakr_quraish',
      'salah_salem',
      'carrefour_maadi',
      'monshiyet_el_sadr',
      'shams_club',
      'bab_ellouq'
    ],
    'giza': [
      'dokki',
      'mohandessin',
      'agouza',
      'haram',
      'faisal',
      'october_city',
      'sheikh_zayed_city',
      'omrania',
      'warraq',
      'osim',
      'kerdasa',
      'hawamdeya',
      'badrashin',
      'ayyat',
      'saf',
      'hadayek_ahram',
      'imbaba',
      'boulaq_dakrour',
      'ard_ellawa',
      'arkan_mall',
      'bahr_aazam',
      'hosary',
      'sheikh_zayed',
      'talbia',
      'smart_village',
      'kit_kat',
      'lobini',
      'maryoutiya',
      'mounib',
      'mounira',
      'bashtil',
      'beverly_hills',
      'tarsa',
      'khatem_morsalin',
      'zayed',
      'kafr_taharmes',
      'court_yard',
      'moussadak',
      'lebanon_square',
      'new_giza',
      'gezira_plaza',
      'park_street',
      'cairo_medical'
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
      'sidi_gaber',
      'sidi_bishr',
      'bitash',
      'hanoville',
      'amreya',
      'km_21',
      'abou_qir',
      'borg_el_arab',
      'wardian',
      'falaki',
      'gomrok',
      'miami',
      'mandara',
      'manshia',
      'victoria',
      'agami',
      'bab_sharq',
      'bahary',
      'gleem',
      'gianaclis',
      'rashdy',
      'sporting',
      'mahatet_el_raml',
      'mostafa_kamel',
      'mamoura',
      'matoubes',
      'askout',
    ],
    'dakahlia': [
      'mansoura',
      'talkha',
      'mit_ghamr',
      'belqas',
      'aga',
      'sinbillawin',
      'sherbin',
      'beni_ebeid',
      'dekernes',
      'samanoud',
      'delta',
      'menia_el_nasr',
      'el_manzala',
      'mit_salsil',
      'gamasa',
      'nabaroh',
      'el_kurdi',
      'mahalet_demna',
      'gamalia'
    ],
    'red_sea': ['hurghada', 'marsa_alam', 'ras_ghareb', 'safaga', 'ain_sokhna'],
    'beheira': [
      'damanhour',
      'kafr_el_dawar',
      'abu_hummus',
      'hosh_essa',
      'delengat',
      'itay_el_barud',
      'shubrakhit',
      'edko',
      'rashid',
      'rahmaniya',
      'noubaria',
      'kom_hamada',
      'abu_el_matamir',
      'wadi_el_natrun',
      'advina',
    ],
    'faiyum': ['faiyum_city', 'sinnuris', 'etsa', 'abubakk', 'mosalla'],
    'gharbia': [
      'tanta',
      'mahalla',
      'zefta',
      'samanoud',
      'kafr_el_zayat',
      'basion',
      'qutour',
      'santah'
    ],
    'ismailia': [
      'ismailia_city',
      'qantera_west',
      'tal_el_kebir',
      'fayed',
      'qantera',
      'qantera_east'
    ],
    'monufia': [
      'shebin_el_kom',
      'menouf',
      'ashmoun',
      'bagour',
      'sadat_city',
      'quesna',
      'shohada',
      'baranya',
      'sadat',
      'begeirm',
      'mit_bere',
      'tala',
      'berket_el_sabaa'
    ],
    'minya': [
      'minya_city',
      'malawi',
      'maghagha',
      'beni_mazar',
      'samalout',
      'abu_qurqas',
      'deir_mawas',
      'el_edwa',
      'matai'
    ],
    'qalyubia': [
      'banha',
      'qalyub',
      'shubra_el_kheima',
      'kafr_shukr',
      'tukh',
      'shibin_el_qanater',
      'khanka',
      'qaha',
      'obour_city',
      'khusus',
      'qanatir',
      'abour'
    ],
    'new_valley': ['kharga', 'dakhla', 'paris'],
    'suez': [
      'suez_city',
      'ain_sokhna',
      'arbaeen',
      'suez_district',
      'attaka_district',
      'el_ganayen_district'
    ],
    'aswan': [
      'aswan_city',
      'kom_ombo',
      'daraw',
      'new_aswan_city',
      'edfu_center'
    ],
    'asyut': [
      'asyut_city',
      'abu_tis',
      'nomiss',
      'abnub',
      'dayrout',
      'manfalut'
    ],
    'beni_suef': ['beni_suef_city', 'wasta', 'naser'],
    'port_said': [
      'port_said_city',
      'port_fouad',
      'east_district',
      'west_district'
    ],
    'damietta': ['damietta_city', 'faraskour', 'kafr_saad', 'zarqa'],
    'sharqia': [
      'zagazig',
      'belbeis',
      'abu_kabir',
      'kafr_saqr',
      'menia_el_qamh',
      'faques',
      'tenth_of_ramadan_city',
      'abu_hammad',
      'salheya',
      'qanayat',
      'hehya',
      'ibrahimia_sharqia',
      'awlad_saqr',
      'husseiniya',
      'deirb_negm',
      'el_qurin'
    ],
    'south_sinai': ['sharm_el_sheikh', 'dahab', 'nuweiba'],
    'kafr_el_sheikh': ['kafr_el_sheikh_city', 'desouk', 'sidi_salem', 'fuwa'],
    'matrouh': [
      'marsa_matrouh',
      'north_coast',
      'hacienda',
      'amwaj',
      'hamam',
      'nagila',
      'el_alamein',
      'dabaa',
      'sidi_barrani',
      'salloum',
      'siwa'
    ],
    'luxor': ['luxor_city', 'esna', 'qurna'],
    'qena': ['qena_city', 'qift', 'qous', 'nag_hamadi', 'deshna', 'naqada'],
    'north_sinai': ['el_arish', 'sheikh_zuweid', 'rafah'],
    'sohag': ['sohag_city', 'girga', 'tahta', 'asierat', 'akhmim'],
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
    final locationUrlController = TextEditingController();
    final selectedCity = ''.obs;
    final selectedGovernorate = ''.obs;
    final workingHours = <String, String>{}.obs;

    branchAddressControllers.add(addressController);
    branchPhoneControllers.add(phoneController);
    branchWhatsappControllers.add(whatsappController);
    branchLocationUrlControllers.add(locationUrlController);
    branchSelectedCities.add(selectedCity);
    branchSelectedGovernorates.add(selectedGovernorate);
    branchWorkingHours.add(workingHours);

    final newBranch = Branch(
      address: '',
      phoneNumber: '',
      whatsAppNumber: '',
      locationUrl: '',
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
      branchLocationUrlControllers[index].dispose();

      branchAddressControllers.removeAt(index);
      branchPhoneControllers.removeAt(index);
      branchWhatsappControllers.removeAt(index);
      branchLocationUrlControllers.removeAt(index);
      branchSelectedCities.removeAt(index);
      branchSelectedGovernorates.removeAt(index);
      branchWorkingHours.removeAt(index);

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
        locationUrl: branchLocationUrlControllers[index].text.trim(),
        selectedGovernorate: branchSelectedGovernorates[index].value,
        selectedCity: branchSelectedCities[index].value,
        workingHours: cleanedWorkingHours,
      );

      branches[index] = updatedBranch;
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
        locationUrl: branchLocationUrlControllers[i].text.trim(),
        // Make sure this is set
        selectedGovernorate: branchSelectedGovernorates[i].value,
        selectedCity: branchSelectedCities[i].value,
        workingHours: cleanedWorkingHours,
      );

      branches[i] = updatedBranch;

      print('  Updated branch phone: "${branches[i].phoneNumber}"');
      print('  Updated branch whatsapp: "${branches[i].whatsAppNumber}"');
    }
    print('=================================');
    update();
  }

  final List<bool Function()> _stepValidators = [];

  AddServiceController({this.serviceToEdit, this.initialStep})
      : isEditingMode = serviceToEdit != null {
    _initializeValidators();
    addBranch(); // Create first branch
    if (isEditingMode) {
      _populateFormForEditing();
    }

    // Set initial step immediately if provided
    if (initialStep != null) {
      currentStep.value = initialStep!;
    }
  }

  void _populateFormForEditing() {
    if (serviceToEdit == null) return;

    final service = serviceToEdit!;

    // Step 1: Basic Information
    serviceNameController.text = service.serviceName;
    selectedService.value = service.serviceType;
    if (service.specialization != null && service.specialization!.isNotEmpty) {
      selectedSpecialization.value = service.specialization;
    } else {
      selectedSpecialization.value = null;
    }
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
    for (var controller in branchLocationUrlControllers) {
      controller.dispose();
    }

    // Clear all lists
    branchAddressControllers.clear();
    branchPhoneControllers.clear();
    branchWhatsappControllers.clear();
    branchLocationUrlControllers.clear();
    branchSelectedCities.clear();
    branchSelectedGovernorates.clear();
    branchWorkingHours.clear();
    branches.clear();
  }

  void _addBranchFromModel(BranchModel branchModel) {
    final addressController = TextEditingController(text: branchModel.address);
    final phoneController =
        TextEditingController(text: branchModel.phoneNumber);
    final whatsappController =
        TextEditingController(text: branchModel.whatsapp);
    final locationUrlController =
        TextEditingController(text: branchModel.locationUrl);
    final selectedCity = branchModel.city.obs;
    final selectedGovernorate = branchModel.governorate.obs;
    final workingHours = Map<String, String>.from(branchModel.workingHours);
    // Debug print to see what's being loaded
    print('DEBUG: Loading working hours for edit:');
    workingHours.forEach((key, value) {
      print('  $key: $value');
    });
    branchAddressControllers.add(addressController);
    branchPhoneControllers.add(phoneController);
    branchWhatsappControllers.add(whatsappController);
    branchLocationUrlControllers.add(locationUrlController);
    branchSelectedCities.add(selectedCity);
    branchSelectedGovernorates.add(selectedGovernorate);
    branchWorkingHours.add(workingHours);

    final newBranch = Branch(
      address: branchModel.address,
      phoneNumber: branchModel.phoneNumber,
      whatsAppNumber: branchModel.whatsapp,
      locationUrl: branchModel.locationUrl,
      workingHours: workingHours,
      selectedCity: branchModel.city,
      selectedGovernorate: branchModel.governorate,
    );

    branches.add(newBranch);
  }

  String _stripCurrency(dynamic value) {
    if (value == null) return '';
    final stringValue = value.toString();
    // Strip both L.E and جنية (Arabic) for loading into edit fields
    return stringValue.replaceAll('L.E', '').replaceAll('جنية', '').trim();
  }

  String _stripPercentage(dynamic value) {
    if (value == null) return '';
    final stringValue = value.toString();
    return stringValue.replaceAll('%', '').trim();
  }

  void _populateDiscountsFromModel(ServiceModel service) {
    try {
      print('=== POPULATE DISCOUNTS START ===');
      print('Service Type: ${service.serviceType}');

      final discounts = Map<String, dynamic>.from(service.discounts);
      print('Discounts map: $discounts');

      // Clean incoming data for all possible fields
      final allPossibleFields = [
        // Gym fields
        'gym_month_sub_price_a',
        'gym_month_sub_price_b',
        'gym_month_3_sub_price_a',
        'gym_month_3_sub_price_b',
        'gym_month_6_sub_price_a',
        'gym_month_6_sub_price_b',
        'gym_month_12_sub_price_a',
        'gym_month_12_sub_price_b',
        'other_discount',

        // Doctor fields
        'consultation_price_before',
        'consultation_price_after',
        'surgeries_other_services_discount',

        // Hospital fields
        'examinations_discount',
        'medical_tests_discount',
        'hospital_xray_discount',
        'medicines_discount',

        // Pharmacy fields
        'local_medicines_discount',
        'imported_medicines_discount',
        'medical_supplies_discount',

        // Lab fields
        'all_tests_discount',

        // Radiology fields
        'xray_discount',

        // Eye care fields
        'glasses_discount',
        'sunglasses_discount',
        'contact_lenses_discount',
        'eye_exam_discount',
      ];

      for (final field in allPossibleFields) {
        _cleanIncomingDiscountValue(discounts, field);
      }

      // Gym fields
      if (service.serviceType == 'gym') {
        print('Loading gym fields...');
        try {
          gymMonthSubPriceA.text =
              _stripCurrency(discounts['gym_month_sub_price_a']);
          gymMonthSubPriceB.text =
              _stripCurrency(discounts['gym_month_sub_price_b']);
          gymMonth3SubPriceA.text =
              _stripCurrency(discounts['gym_month_3_sub_price_a']);
          gymMonth3SubPriceB.text =
              _stripCurrency(discounts['gym_month_3_sub_price_b']);
          gymMonth6SubPriceA.text =
              _stripCurrency(discounts['gym_month_6_sub_price_a']);
          gymMonth6SubPriceB.text =
              _stripCurrency(discounts['gym_month_6_sub_price_b']);
          gymMonth12SubPriceA.text =
              _stripCurrency(discounts['gym_month_12_sub_price_a']);
          gymMonth12SubPriceB.text =
              _stripCurrency(discounts['gym_month_12_sub_price_b']);
          discountOther.text = _stripPercentage(discounts['other_discount']);
          print('Gym fields loaded successfully');
        } catch (e) {
          print('ERROR loading gym fields: $e');
        }
      }

      // Human Doctor fields
      if (service.serviceType == 'human_doctor') {
        print('Loading human doctor fields...');
        try {
          humanDoctorPriceBefore.text =
              _stripCurrency(discounts['consultation_price_before']);
          humanDoctorPriceAfter.text =
              _stripCurrency(discounts['consultation_price_after']);
          humanDoctorIsHome.value = discounts['is_home_visit'] == 'true';
          humanDoctorIsCard.value = discounts['home_discount'] == 'true';
          surgeriesOtherServicesDiscount.text =
              _stripPercentage(discounts['surgeries_other_services_discount']);
          print('Human doctor fields loaded successfully');
        } catch (e) {
          print('ERROR loading human doctor fields: $e');
        }
      }

      // Veterinary Doctor fields
      if (service.serviceType == 'veterinarian') {
        print('Loading veterinarian fields...');
        try {
          veterinaryDoctorPriceBefore.text =
              _stripCurrency(discounts['consultation_price_before']);
          veterinaryDoctorPriceAfter.text =
              _stripCurrency(discounts['consultation_price_after']);
          veterinaryDoctorIsHome.value = discounts['is_home_visit'] == 'true';
          veterinaryDoctorIsCard.value = discounts['home_discount'] == 'true';
          surgeriesOtherServicesDiscount.text =
              _stripPercentage(discounts['surgeries_other_services_discount']);
          print('Veterinarian fields loaded successfully');
        } catch (e) {
          print('ERROR loading veterinarian fields: $e');
        }
      }

      // Hospital fields (Human)
      if (service.serviceType == 'human_hospital') {
        print('Loading human hospital fields...');
        try {
          humanHospitalDiscountExaminations.text =
              _stripPercentage(discounts['examinations_discount']);
          print('  examinations: ${humanHospitalDiscountExaminations.text}');

          humanHospitalDiscountMedicalTest.text =
              _stripPercentage(discounts['medical_tests_discount']);
          print('  medical tests: ${humanHospitalDiscountMedicalTest.text}');

          humanHospitalDiscountXRay.text =
              _stripPercentage(discounts['hospital_xray_discount']);
          print('  xray: ${humanHospitalDiscountXRay.text}');

          humanHospitalDiscountMedicines.text =
              _stripPercentage(discounts['medicines_discount']);
          print('  medicines: ${humanHospitalDiscountMedicines.text}');

          surgeriesOtherServicesDiscount.text =
              _stripPercentage(discounts['surgeries_other_services_discount']);
          print('  surgeries: ${surgeriesOtherServicesDiscount.text}');

          print('Human hospital fields loaded successfully');
        } catch (e) {
          print('ERROR loading human hospital fields: $e');
          print('Stack trace: ${StackTrace.current}');
        }
      }

      // Hospital fields (Veterinary)
      if (service.serviceType == 'veterinary_hospital') {
        print('Loading veterinary hospital fields...');
        try {
          veterinaryHospitalDiscountExaminations.text =
              _stripPercentage(discounts['examinations_discount']);
          veterinaryHospitalDiscountMedicalTest.text =
              _stripPercentage(discounts['medical_tests_discount']);
          veterinaryHospitalDiscountXRay.text =
              _stripPercentage(discounts['hospital_xray_discount']);
          veterinaryHospitalDiscountMedicines.text =
              _stripPercentage(discounts['medicines_discount']);
          surgeriesOtherServicesDiscount.text =
              _stripPercentage(discounts['surgeries_other_services_discount']);
          print('Veterinary hospital fields loaded successfully');
        } catch (e) {
          print('ERROR loading veterinary hospital fields: $e');
        }
      }

      // Pharmacy fields (Human)
      if (service.serviceType == 'human_pharmacy') {
        print('Loading human pharmacy fields...');
        try {
          humanPharmacyDiscountLocalMedicine.text =
              _stripPercentage(discounts['local_medicines_discount']);
          humanPharmacyDiscountImportedMedicine.text =
              _stripPercentage(discounts['imported_medicines_discount']);
          humanPharmacyDiscountMedicalSupplies.text =
              _stripPercentage(discounts['medical_supplies_discount']);
          humanPharmacyIsHome.value = discounts['is_home_delivery'] == 'true';
          humanPharmacyIsCard.value =
              discounts['pharmacy_is_home_card'] == 'true';
          print('Human pharmacy fields loaded successfully');
        } catch (e) {
          print('ERROR loading human pharmacy fields: $e');
        }
      }

      // Pharmacy fields (Veterinary)
      if (service.serviceType == 'veterinary_pharmacy') {
        print('Loading veterinary pharmacy fields...');
        try {
          veterinaryPharmacyDiscountLocalMedicine.text =
              _stripPercentage(discounts['local_medicines_discount']);
          veterinaryPharmacyDiscountImportedMedicine.text =
              _stripPercentage(discounts['imported_medicines_discount']);
          veterinaryPharmacyDiscountMedicalSupplies.text =
              _stripPercentage(discounts['medical_supplies_discount']);
          veterinaryPharmacyIsHome.value =
              discounts['is_home_delivery'] == 'true';
          veterinaryPharmacyIsCard.value =
              discounts['pharmacy_is_home_card'] == 'true';
          print('Veterinary pharmacy fields loaded successfully');
        } catch (e) {
          print('ERROR loading veterinary pharmacy fields: $e');
        }
      }

      // Lab Test fields
      if (service.serviceType == 'lab') {
        print('Loading lab fields...');
        try {
          labTestDiscountAllTypes.text =
              _stripPercentage(discounts['all_tests_discount']);
          labTestIsHome.value = discounts['is_home_service'] == 'true';
          labTestIsCard.value = discounts['is_home_card'] == 'true';
          print('Lab fields loaded successfully');
        } catch (e) {
          print('ERROR loading lab fields: $e');
        }
      }

      // Radiology fields
      if (service.serviceType == 'radiology_center') {
        print('Loading radiology fields...');
        try {
          xRayDiscount.text = _stripPercentage(discounts['xray_discount']);
          print('Radiology fields loaded successfully');
        } catch (e) {
          print('ERROR loading radiology fields: $e');
        }
      }

      // Eye Care fields
      if (service.serviceType == 'optics') {
        print('Loading eye care fields...');
        try {
          eyeCareDiscountGlasses.text =
              _stripPercentage(discounts['glasses_discount']);
          eyeCareDiscountSunGlasses.text =
              _stripPercentage(discounts['sunglasses_discount']);
          contactLensesController.text =
              _stripPercentage(discounts['contact_lenses_discount']);
          eyeCareDiscountEyeExam.text =
              _stripPercentage(discounts['eye_exam_discount']);
          eyeCareIsDelivery.value = discounts['is_delivery'] == 'true';
          eyeCareIsCard.value = discounts['eye_care_is_card'] == 'true';
          print('Eye care fields loaded successfully');
        } catch (e) {
          print('ERROR loading eye care fields: $e');
        }
      }

      print('=== POPULATE DISCOUNTS END ===');
    } catch (e) {
      print('=== CRITICAL ERROR IN POPULATE DISCOUNTS ===');
      print('Error: $e');
      print('Stack trace: ${StackTrace.current}');
    }
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
      specialization: selectedSpecialization.value?.trim().isEmpty ?? true
          ? null
          : selectedSpecialization.value,
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

// Helper to determine if a field key is a price field
  bool _isPriceField(String key) {
    final priceFieldKeys = [
      'consultation_price_before',
      'consultation_price_after',
      'gym_month_sub_price_a',
      'gym_month_sub_price_b',
      'gym_month_3_sub_price_a',
      'gym_month_3_sub_price_b',
      'gym_month_6_sub_price_a',
      'gym_month_6_sub_price_b',
      'gym_month_12_sub_price_a',
      'gym_month_12_sub_price_b',
      'price_before',
      'price_after',
      // Add any other price field keys
    ];

    final keyLower = key.toLowerCase();
    return priceFieldKeys.any((priceKey) => keyLower.contains(priceKey));
  }

  bool _isPercentageField(String key) {
    final percentageFieldKeys = [
      'discount',
      'examinations_discount',
      'medical_tests_discount',
      'hospital_xray_discount',
      'medicines_discount',
      'surgeries_other_services_discount',
      'local_medicines_discount',
      'imported_medicines_discount',
      'medical_supplies_discount',
      'all_tests_discount',
      'xray_discount',
      'glasses_discount',
      'sunglasses_discount',
      'contact_lenses_discount',
      'eye_exam_discount',
      'other_discount',
      'tests_discount',
      // Add any other percentage field keys
    ];

    final keyLower = key.toLowerCase();
    return percentageFieldKeys
        .any((percentKey) => keyLower.contains(percentKey));
  }

  void _cleanIncomingDiscountValue(Map<String, dynamic> discounts, String key) {
    if (discounts.containsKey(key)) {
      final value = discounts[key];
      if (value is String && value.isNotEmpty) {
        final stringValue = value.toString();
        // Check if it already has a suffix
        if (!stringValue.contains('%') &&
            !stringValue.contains('L.E') &&
            !stringValue.contains('جنية')) {
          // Add appropriate suffix based on key
          if (_isPriceField(key)) {
            discounts[key] = '$stringValue L.E';
          } else if (_isPercentageField(key)) {
            discounts[key] = '$stringValue%';
          }
        }
      }
    }
  }

  void _setServiceSpecificFields(ServiceData serviceData) {
    final currentService = selectedService.value;
    final bool isArabic = Get.locale?.languageCode == 'ar';
    final String currencySuffix = isArabic ? 'جنية' : 'L.E';

    String? _formatPercentage(String value) {
      if (value.trim().isEmpty) return null;

      // Clean the value
      final cleanedValue = value.replaceAll('%', '').trim();

      // Check if it's already a number with % at the end (from editing)
      if (cleanedValue.endsWith('%')) {
        // Already has %, return as is
        return cleanedValue;
      }

      // Validate it's a valid number
      if (double.tryParse(cleanedValue) == null) {
        return null; // Or show error
      }

      return '$cleanedValue%';
    }

// Helper function for price fields (always use "L.E" for backend)
    String? _formatPrice(String value) {
      if (value.trim().isEmpty) return null;

      // Clean the value - remove any currency
      String cleanedValue =
          value.replaceAll('L.E', '').replaceAll('جنية', '').trim();

      // Check if it's already a number with currency
      if (value.contains('L.E') || value.contains('جنية')) {
        // Already has currency, but we need to convert to "L.E"
        final numValue = double.tryParse(cleanedValue);
        if (numValue != null) {
          return '$cleanedValue L.E';
        }
      }

      // Validate it's a valid number
      if (double.tryParse(cleanedValue) == null) {
        return null; // Or show error
      }

      return '$cleanedValue L.E';
    }

    // Helper function for regular fields (no formatting)
    String? _getFieldValue(String value) {
      if (value.trim().isEmpty) return null;
      return value.trim();
    }

    // Now set only the fields for the current service type
    switch (currentService) {
      case 'human_doctor':
        serviceData.consultationPriceBefore =
            _formatPrice(humanDoctorPriceBefore.text);
        serviceData.consultationPriceAfter =
            _formatPrice(humanDoctorPriceAfter.text);
        serviceData.isHomeVisit = humanDoctorIsHome.value;
        serviceData.homeDiscount = humanDoctorIsCard.value;
        serviceData.surgeriesOtherServicesDiscount =
            _formatPercentage(surgeriesOtherServicesDiscount.text);
        break;

      case 'veterinarian':
        serviceData.consultationPriceBefore =
            _formatPrice(veterinaryDoctorPriceBefore.text);
        serviceData.consultationPriceAfter =
            _formatPrice(veterinaryDoctorPriceAfter.text);
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
        serviceData.gymMonthSubPriceB = _formatPrice(gymMonthSubPriceB.text);
        serviceData.gymMonthSubPriceA = _formatPrice(gymMonthSubPriceA.text);
        serviceData.gymMonth3SubPriceB = _formatPrice(gymMonth3SubPriceB.text);
        serviceData.gymMonth3SubPriceA = _formatPrice(gymMonth3SubPriceA.text);
        serviceData.gymMonth6SubPriceB = _formatPrice(gymMonth6SubPriceB.text);
        serviceData.gymMonth6SubPriceA = _formatPrice(gymMonth6SubPriceA.text);
        serviceData.gymMonth12SubPriceB =
            _formatPrice(gymMonth12SubPriceB.text);
        serviceData.gymMonth12SubPriceA =
            _formatPrice(gymMonth12SubPriceA.text);
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
        _fetchUpdatedServices();

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
          _fetchUpdatedServices();

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

  void _fetchUpdatedServices() {
    try {
      // Find the ServicesController and refresh data
      final servicesController = Get.find<ServicesController>();
      servicesController.fetchServices();
    } catch (e) {
      print('Error fetching updated services: $e');
      // If controller is not found, it's okay - it will refresh on next init
    }
  }

  void _initializeValidators() {
    _stepValidators
      ..add(_validateStep1)
      ..add(_validateStep2)
      ..add(_validateStep3);
  }

  bool _validateStep1() {
    try {
      print('=== VALIDATE STEP 1 START ===');

      // Check basic required fields first (without form validation)
      print('Checking selected service...');
      if (selectedService.value == null) {
        print('Selected service is NULL');
        _showError('please_select_service'.tr);
        return false;
      }
      print('Selected service PASSED: ${selectedService.value}');

      print('Checking specialization requirement...');
      if (selectedService.value == 'human_doctor' ||
          selectedService.value == 'human_hospital') {
        final specialization = selectedSpecialization.value;
        print(
            'Service requires specialization. Current value: $specialization');
        if (specialization == null || specialization.trim().isEmpty) {
          print('Specialization validation FAILED');
          _showError('please_select_specialization'.tr);
          return false;
        }
        print('Specialization PASSED: $specialization');
      }

      print('Checking service name...');
      if (serviceNameController.text.trim().isEmpty) {
        print('Service name validation FAILED');
        _showError('please_enter_service_name'.tr);
        return false;
      }
      print('Service name PASSED');

      // Now validate the form (text field validators)
      print('Checking form validation...');
      try {
        if (step1FormKey.currentState != null) {
          final isValid = step1FormKey.currentState!.validate();
          if (!isValid) {
            print('Form validation FAILED');
            return false;
          }
          print('Form validation PASSED');
        } else {
          print(
              'WARNING: Form key current state is null, skipping form validation');
        }
      } catch (e, stackTrace) {
        print('ERROR during form validation: $e');
        print('Stack trace: $stackTrace');
        // Continue anyway - the error might be in a non-critical validator
        return false;
      }

      print('=== VALIDATE STEP 1 PASSED ===');
      return true;
    } catch (e, stackTrace) {
      print('=== ERROR IN VALIDATE STEP 1 ===');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return false;
    }
  }

  bool _validateStep2() {
    return true;
  }

  bool _validateStep3() {
    if (step3FormKey.currentState != null &&
        !step3FormKey.currentState!.validate()) {
      return false;
    }
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
      for (int i = 0; i < branches.length; i++) {
        if (!_validateWorkingHours(branchWorkingHours[i])) {
          _showError(
              '${'please_set_proper_working_hours'.tr} ${'for_branch'.tr} ${i + 1}');
          return false;
        }
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
    try {
      print('=== NEXT STEP CALLED ===');
      print('Current step: ${currentStep.value}');

      if (currentStep.value < 2) {
        print('Validating current step...');
        if (_stepValidators[currentStep.value]()) {
          print('Validation passed, incrementing step...');
          currentStep.value++;
          print('New step value: ${currentStep.value}');

          print('Calling update()...');
          update();
          print('Update() completed');
        } else {
          print('Validation failed');
        }
      } else {
        print('Final step, validating step 3...');
        if (_validateStep3()) {
          print('Step 3 validated, submitting service...');
          submitService();
        } else {
          print('Step 3 validation failed');
        }
      }
      print('=== NEXT STEP COMPLETED ===');
    } catch (e, stackTrace) {
      print('=== ERROR IN NEXT STEP ===');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      _showError('An error occurred: $e');
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
    for (var controller in branchLocationUrlControllers) {
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

  final GlobalKey<FormState> step1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> step3FormKey = GlobalKey<FormState>();
}
