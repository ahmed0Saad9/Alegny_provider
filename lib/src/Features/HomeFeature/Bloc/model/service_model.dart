import 'package:flutter/material.dart';
import 'package:get/get.dart';

//  Service Status
enum ServiceStatus {
  pending(
      'pending', 'under_review', Colors.orange, Icons.hourglass_top_rounded),
  approved('approved', 'approved', Colors.green, Icons.verified),
  rejected('rejected', 'rejected', Colors.red, Icons.cancel);

  final String value;
  final String translationKey;
  final Color color;
  final IconData icon;

  const ServiceStatus(this.value, this.translationKey, this.color, this.icon);

  static ServiceStatus fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'approved':
        return ServiceStatus.approved;
      case 'rejected':
        return ServiceStatus.rejected;
      case 'pending':
      default:
        return ServiceStatus.pending;
    }
  }

  String toJsonValue() => value;
}

//  BranchModel
class BranchModel {
  final String governorate;
  final String city;
  final String address;
  final String phone;
  final String whatsapp;
  final Map<String, dynamic> workingHours;

  BranchModel({
    required this.governorate,
    required this.city,
    required this.address,
    required this.phone,
    required this.whatsapp,
    required this.workingHours,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      governorate: json['governorate'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone']?.toString() ?? '',
      whatsapp: json['whatsapp']?.toString() ?? '',
      workingHours: (json['workingHours'] as Map?)?.map(
            (key, value) => MapEntry(key.toString(), value),
          ) ??
          {},
    );
  }

  // Enhanced method to get working hours with language support
  String getWorkingHoursForDay(String dayKey) {
    final bool isArabic = Get.locale?.languageCode == 'ar';

    // Try multiple key formats
    final possibleKeys = [
      dayKey, // Original key (english)
      dayKey.toLowerCase(), // Lowercase english
      _convertToArabicDay(dayKey), // Arabic equivalent
      _convertToArabicDay(dayKey).toLowerCase(), // Lowercase arabic
    ];

    for (final key in possibleKeys) {
      final hours = workingHours[key];
      if (hours != null && hours.toString().isNotEmpty) {
        final hoursString = hours.toString();

        // If closed, return in correct language
        if (_isClosedHours(hoursString)) {
          return isArabic ? 'مغلق' : 'Closed';
        }

        return hoursString;
      }
    }

    return isArabic ? 'مغلق' : 'Closed';
  }

  bool _isClosedHours(String hours) {
    final closedIndicators = ['مغلق', 'closed', 'close', 'مقفول'];
    return hours.isEmpty ||
        closedIndicators.any((indicator) =>
            hours.toLowerCase().contains(indicator.toLowerCase()));
  }

  // Helper method to convert english days to arabic
  String _convertToArabicDay(String englishDay) {
    final dayMap = {
      'saturday': 'السبت',
      'sunday': 'الأحد',
      'monday': 'الإثنين',
      'tuesday': 'الثلاثاء',
      'wednesday': 'الأربعاء',
      'thursday': 'الخميس',
      'friday': 'الجمعة',
    };
    return dayMap[englishDay.toLowerCase()] ?? englishDay;
  }

  // New method to get all working hours in a consistent format
  Map<String, String> getFormattedWorkingHours() {
    final Map<String, String> formatted = {};
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
      formatted[day] = getWorkingHoursForDay(day);
    }

    return formatted;
  }

  Map<String, dynamic> toJson() => {
        'governorate': governorate,
        'city': city,
        'address': address,
        'phone': phone,
        'whatsapp': whatsapp,
        'workingHours': workingHours,
      };
}

//  ServiceModel
class ServiceModel {
  final String id;
  final String serviceName;
  final String serviceType;
  final String? specialization;
  final String? imageUrl;
  final Map<String, dynamic> discounts;
  final List<BranchModel> branches;
  final ServiceStatus status;

  ServiceModel({
    required this.id,
    required this.serviceName,
    required this.serviceType,
    this.specialization,
    required this.imageUrl,
    required this.discounts,
    required this.branches,
    required this.status,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'].toString(),
      serviceName: json['serviceName'] ?? '',
      serviceType: json['serviceType'] ?? '',
      specialization: json['specialization'],
      imageUrl: json['imageUrl'],
      // may be null — safe now
      discounts: (json['discounts'] as Map?)?.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          ) ??
          {},
      branches: (json['branches'] as List?)
              ?.map((b) => BranchModel.fromJson(b))
              .toList() ??
          [],
      status: ServiceStatus.fromString(json['status']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'serviceName': serviceName,
        'serviceType': serviceType,
        'specialization': specialization,
        'imageUrl': imageUrl,
        'discounts': discounts,
        'branches': branches.map((b) => b.toJson()).toList(),
        'status': status.toJsonValue(),
      };
}
