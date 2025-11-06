class Branch {
  final String address;
  final String phoneNumber;
  final String whatsAppNumber;
  final String selectedGovernorate;
  final String selectedCity;
  final Map<String, String> workingHours;

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'phone': phoneNumber,
      'whatsapp': whatsAppNumber,
      'governorate': selectedGovernorate,
      'city': selectedCity,
      'workingHours': workingHours,
    };
  }

  const Branch({
    required this.address,
    required this.phoneNumber,
    required this.whatsAppNumber,
    required this.selectedGovernorate,
    required this.selectedCity,
    required this.workingHours,
  });
}
