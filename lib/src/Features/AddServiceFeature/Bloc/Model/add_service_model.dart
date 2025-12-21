import 'dart:io';

class ServiceData {
  // Basic service information
  String? serviceName;
  String? serviceType;
  String? specialization;
  String? serviceDescription;
  File? serviceImage;

  // Social media
  String? facebook;
  String? instagram;
  String? tiktok;
  String? youtube;

  // Human Doctor & Veterinary Doctor fields
  String? consultationPriceBefore;
  String? consultationPriceAfter;
  bool? isHomeVisit;
  bool? homeDiscount;

  // Hospital fields (Human & Veterinary)
  String? examinationsDiscount;
  String? medicalTestsDiscount;
  String? hospitalXrayDiscount;
  String? medicinesDiscount;

  // Pharmacy fields (Human & Veterinary)
  String? localMedicinesDiscount;
  String? importedMedicinesDiscount;
  String? medicalSuppliesDiscount;
  bool? isHomeDelivery;
  bool? pharmacyIsHomeCard;

  // Lab Test fields
  String? allTestsDiscount;
  bool? isHomeService;
  bool? isHomeCard;

  // Radiology fields
  String? xRayDiscount;

  // Eye Care fields
  String? glassesDiscount;
  String? sunglassesDiscount;
  String? contactLensesDiscount;
  String? eyeExamDiscount;
  bool? isDelivery;
  bool? eyeCareIsCard;

  // Gym fields
  String? gymMonthSubPriceB;
  String? gymMonthSubPriceA;
  String? gymMonth3SubPriceB;
  String? gymMonth3SubPriceA;
  String? gymMonth6SubPriceB;
  String? gymMonth6SubPriceA;
  String? gymMonth12SubPriceB;
  String? gymMonth12SubPriceA;
  String? otherDiscount;

  //shared
  String? surgeriesOtherServicesDiscount;

  //branches
  List<Map<String, dynamic>> branches;

  ServiceData({
    // Basic info
    this.serviceName,
    this.serviceDescription,
    this.serviceType,
    this.specialization,
    this.serviceImage,

    // Social media
    this.facebook,
    this.instagram,
    this.tiktok,
    this.youtube,

    // Doctor fields
    this.consultationPriceBefore,
    this.consultationPriceAfter,
    this.isHomeVisit,
    this.homeDiscount,

    // Hospital fields
    this.examinationsDiscount,
    this.medicalTestsDiscount,
    this.hospitalXrayDiscount,
    this.medicinesDiscount,

    // Pharmacy fields
    this.localMedicinesDiscount,
    this.importedMedicinesDiscount,
    this.medicalSuppliesDiscount,
    this.isHomeDelivery,
    this.pharmacyIsHomeCard,

    // Lab Test fields
    this.allTestsDiscount,
    this.isHomeService,
    this.isHomeCard,

    // Radiology fields
    this.xRayDiscount,

    // Eye Care fields
    this.glassesDiscount,
    this.sunglassesDiscount,
    this.contactLensesDiscount,
    this.eyeExamDiscount,
    this.isDelivery,
    this.eyeCareIsCard,

    // Gym fields
    this.gymMonthSubPriceB,
    this.gymMonthSubPriceA,
    this.gymMonth3SubPriceB,
    this.gymMonth3SubPriceA,
    this.gymMonth6SubPriceB,
    this.gymMonth6SubPriceA,
    this.gymMonth12SubPriceB,
    this.gymMonth12SubPriceA,
    this.otherDiscount,

    // shared
    this.surgeriesOtherServicesDiscount,
    // branches
    required this.branches,
  });

  Map<String, dynamic> toJson() => {
        // Basic info
        'service_name': serviceName,
        'service_type': serviceType,
        'specialization': specialization,
        'description': serviceDescription,

        // Social media
        'facebookUrl': facebook,
        'instagramUrl': instagram,
        'tikTokUrl': tiktok,
        'youTubeUrl': youtube,

        // Doctor fields
        'consultation_price_before': consultationPriceBefore,
        'consultation_price_after': consultationPriceAfter,
        'is_home_visit': isHomeVisit,
        'home_discount': homeDiscount,

        // Hospital fields
        'examinations_discount': examinationsDiscount,
        'medical_tests_discount': medicalTestsDiscount,
        'hospital_xray_discount': hospitalXrayDiscount,
        'medicines_discount': medicinesDiscount,

        // Pharmacy fields
        'local_medicines_discount': localMedicinesDiscount,
        'imported_medicines_discount': importedMedicinesDiscount,
        'medical_supplies_discount': medicalSuppliesDiscount,
        'is_home_delivery': isHomeDelivery,
        'pharmacy_is_home_card': pharmacyIsHomeCard,

        // Lab Test fields
        'all_tests_discount': allTestsDiscount,
        'is_home_service': isHomeService,
        'is_home_card': isHomeCard,

        // Radiology fields
        'xray_discount': xRayDiscount,

        // Eye Care fields
        'glasses_discount': glassesDiscount,
        'sunglasses_discount': sunglassesDiscount,
        'contact_lenses_discount': contactLensesDiscount,
        'eye_exam_discount': eyeExamDiscount,
        'is_delivery': isDelivery,
        'eye_care_is_card': eyeCareIsCard,

        // Gym fields
        'gym_month_sub_price_b': gymMonthSubPriceB,
        'gym_month_sub_price_a': gymMonthSubPriceA,
        'gym_month_3_sub_price_b': gymMonth3SubPriceB,
        'gym_month_3_sub_price_a': gymMonth3SubPriceA,
        'gym_month_6_sub_price_b': gymMonth6SubPriceB,
        'gym_month_6_sub_price_a': gymMonth6SubPriceA,
        'gym_month_12_sub_price_b': gymMonth12SubPriceB,
        'gym_month_12_sub_price_a': gymMonth12SubPriceA,
        'other_discount': otherDiscount,
        //shared
        'surgeries_other_services_discount': surgeriesOtherServicesDiscount,
        // branches
        'branches': branches,
      };
}

class Branch {
  final String address;
  final String phoneNumber;
  final String whatsAppNumber;
  final String? locationUrl;
  final String selectedGovernorate;
  final String selectedCity;
  final Map<String, String> workingHours;

  const Branch({
    required this.address,
    required this.phoneNumber,
    required this.whatsAppNumber,
    this.locationUrl,
    required this.selectedGovernorate,
    required this.selectedCity,
    required this.workingHours,
  });

  Map<String, dynamic> toJson() {
    // Convert Arabic day keys to English for API
    final Map<String, String> englishWorkingHours = {};
    final dayMapping = {
      'saturday': 'Saturday',
      'sunday': 'Sunday',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
    };

    workingHours.forEach((key, value) {
      final englishKey = dayMapping[key] ?? key;
      englishWorkingHours[englishKey] = value;
    });

    return {
      'address': address,
      'phoneNumber': phoneNumber,
      'whatsapp': whatsAppNumber,
      'locationUrl': locationUrl,
      'governorate': selectedGovernorate,
      'city': selectedCity,
      'workingHours': englishWorkingHours,
    };
  }
}
