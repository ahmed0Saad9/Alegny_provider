import 'dart:io';

class ServiceData {
  // Basic service information
  final String serviceName;
  final String? serviceType;
  final String? specialization;
  final String serviceDescription;
  final File? serviceImage;

  // Social media
  final String facebook;
  final String instagram;
  final String tiktok;
  final String youtube;

  // Location
  final String address;
  final String city;

  // Human Doctor & Veterinary Doctor fields
  final String? consultationPriceBefore;
  final String? consultationPriceAfter;
  final bool? isHomeVisit;
  final bool? homeDiscount;

  // Hospital fields (Human & Veterinary)
  final String? examinationsDiscount;
  final String? medicalTestsDiscount;
  final String? xrayDiscount;
  final String? medicinesDiscount;

  // Pharmacy fields (Human & Veterinary)
  final String? localMedicinesDiscount;
  final String? importedMedicinesDiscount;
  final String? medicalSuppliesDiscount;
  final bool? isHomeDelivery;

  // Lab Test fields
  final String? allTestsDiscount;
  final bool? isHomeService;

  // Radiology fields
  final String? xRayDiscount;

  // Eye Care fields
  final String? glassesDiscount;
  final String? sunglassesDiscount;
  final String? contactLensesDiscount;
  final String? eyeExamDiscount;
  final bool? isDelivery;

  // Gym fields
  final String? gymMonthSubPriceB;
  final String? gymMonthSubPriceA;
  final String? gymMonth3SubPriceB;
  final String? gymMonth3SubPriceA;
  final String? gymMonth6SubPriceB;
  final String? gymMonth6SubPriceA;
  final String? gymMonth12SubPriceB;
  final String? gymMonth12SubPriceA;
  final String? otherDiscount;

  //shared
  final String? surgeriesOtherServicesDiscount;

  //branches
  final List<Map<String, dynamic>> branches;

  const ServiceData({
    // Basic info
    required this.serviceName,
    this.serviceDescription = '',
    this.serviceType,
    this.specialization,
    this.serviceImage,

    // Social media
    this.facebook = '',
    this.instagram = '',
    this.tiktok = '',
    this.youtube = '',

    // Location
    this.address = '',
    this.city = '',

    // Doctor fields
    this.consultationPriceBefore,
    this.consultationPriceAfter,
    this.isHomeVisit,
    this.homeDiscount,

    // Hospital fields
    this.examinationsDiscount,
    this.medicalTestsDiscount,
    this.xrayDiscount,
    this.medicinesDiscount,

    // Pharmacy fields
    this.localMedicinesDiscount,
    this.importedMedicinesDiscount,
    this.medicalSuppliesDiscount,
    this.isHomeDelivery,

    // Lab Test fields
    this.allTestsDiscount,
    this.isHomeService,

    // Radiology fields
    this.xRayDiscount,

    // Eye Care fields
    this.glassesDiscount,
    this.sunglassesDiscount,
    this.contactLensesDiscount,
    this.eyeExamDiscount,
    this.isDelivery,

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
        'service_description': serviceDescription,
        'service_image': serviceImage,

        // Social media
        'facebook': facebook,
        'instagram': instagram,
        'tiktok': tiktok,
        'youtube': youtube,

        // Location
        'address': address,
        'city': city,

        // Doctor fields
        'consultation_price_before': consultationPriceBefore,
        'consultation_price_after': consultationPriceAfter,
        'is_home_visit': isHomeVisit,
        'homeDiscount': homeDiscount,

        // Hospital fields
        'examinations_discount': examinationsDiscount,
        'medical_tests_discount': medicalTestsDiscount,
        'xray_discount': xrayDiscount,
        'medicines_discount': medicinesDiscount,

        // Pharmacy fields
        'local_medicines_discount': localMedicinesDiscount,
        'imported_medicines_discount': importedMedicinesDiscount,
        'medical_supplies_discount': medicalSuppliesDiscount,
        'is_home_delivery': isHomeDelivery,

        // Lab Test fields
        'all_tests_discount': allTestsDiscount,
        'is_home_service': isHomeService,

        // Radiology fields
        'xray_discount': xRayDiscount,

        // Eye Care fields
        'glasses_discount': glassesDiscount,
        'sunglasses_discount': sunglassesDiscount,
        'contact_lenses_discount': contactLensesDiscount,
        'eye_exam_discount': eyeExamDiscount,
        'is_delivery': isDelivery,

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
  final String selectedGovernorate;
  final String selectedCity;
  final Map<String, String> workingHours;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'phone': phoneNumber,
      'whatsapp': whatsAppNumber,
      'governorate': selectedGovernorate,
      'city': selectedCity,
      'workingHours': workingHours,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  const Branch({
    required this.address,
    required this.phoneNumber,
    required this.whatsAppNumber,
    required this.selectedGovernorate,
    required this.selectedCity,
    required this.workingHours,
    this.latitude,
    this.longitude,
  });
}
