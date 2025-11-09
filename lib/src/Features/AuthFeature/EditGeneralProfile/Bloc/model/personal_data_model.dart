class AccountDetailsModel {
  AccountDetailsModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    required this.emailVerified,
  });
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phoneNumber;
  late final Null profileImageUrl;
  late final bool emailVerified;

  AccountDetailsModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    profileImageUrl = null;
    emailVerified = json['emailVerified'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['phoneNumber'] = phoneNumber;
    _data['profileImageUrl'] = profileImageUrl;
    _data['emailVerified'] = emailVerified;
    return _data;
  }
}
