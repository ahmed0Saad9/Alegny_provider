import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Branch {
  // 1. Use controllers for your TextFields
  //    This is what _Step3Content is expecting
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();

  // 2. State for your Dropdowns
  final RxString selectedGovernorate = ''.obs;
  final RxString selectedCity = ''.obs;

  // 3. State for your working hours (make it observable)
  final Map<String, String> workingHours = <String, String>{
    'saturday': '9:00 AM - 5:00 PM',
    'sunday': '9:00 AM - 5:00 PM',
    'monday': '9:00 AM - 5:00 PM',
    'tuesday': '9:00 AM - 5:00 PM',
    'wednesday': '9:00 AM - 5:00 PM',
    'thursday': '9:00 AM - 5:00 PM',
    'friday': 'closed'.tr,
  };

  // 4. Dispose method to clean up controllers
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
  }

  // 5. toJson reads directly from the controllers
  Map<String, dynamic> toJson() {
    return {
      'address': addressController.text.trim(),
      'phone': phoneController.text.trim(),
      'whatsapp': whatsappController.text.trim(),
      'governorate': selectedGovernorate.value,
      'city': selectedCity.value,
      'workingHours': workingHours, // Convert RxMap to regular Map
    };
  }
}
