import 'package:flutter/material.dart';

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

  // Helper to convert string → enum
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

  // Helper to convert enum → string
  String toJsonValue() => value;
}

//  BranchModel
class BranchModel {
  final String governorate;
  final String city;
  final String address;
  final String phone;
  final String whatsapp;
  final Map<String, String> workingHours;

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
      phone: json['phone'] ?? '',
      whatsapp: json['whatsapp'] ?? '',
      workingHours: (json['workingHours'] as Map?)?.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          ) ??
          {},
    );
  }

  Map<String, dynamic> toJson() => {
        'governorate': governorate,
        'city': city,
        'address': address,
        'phone': phone,
        'whatsapp': whatsapp,
        'workingHours': workingHours,
      };

  // Get working hours for a specific day
  String getWorkingHoursForDay(String dayKey) {
    final hours = workingHours[dayKey] ?? '';
    if (hours.isEmpty || hours.toLowerCase() == 'closed') {
      return 'Closed';
    }
    return hours;
  }
}

//  ServiceModel
class ServiceModel {
  final String id;
  final String serviceName;
  final String serviceType;
  final String? specialization;
  final String imageUrl;
  final Map<String, String> discounts;
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
      serviceType: json['serviceType'],
      specialization: json['specialization'],
      imageUrl: json['imageUrl'],
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
