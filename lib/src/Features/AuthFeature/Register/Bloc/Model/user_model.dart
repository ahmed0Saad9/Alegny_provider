class UserModel {
  UserModel({
    required this.isSuccess,
    required this.message,
    required this.token,
    required this.roles,
    required this.profileId,
    // this.errors,
    required this.profile,
  });
  late final bool isSuccess;
  late final String message;
  late final String token;
  late final List<String> roles;
  late final String profileId;
  // late final Null errors;
  late final Profile profile;

  UserModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    token = json['token'];
    roles = List.castFrom<dynamic, String>(json['roles']);
    profileId = json['profileId'];
    profile = Profile.fromJson(json['profile']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isSuccess'] = isSuccess;
    _data['message'] = message;
    _data['token'] = token;
    _data['roles'] = roles;
    _data['profileId'] = profileId;
    // _data['errors'] = errors;
    _data['profile'] = profile.toJson();
    return _data;
  }
}

class Profile {
  Profile({
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
  late final String? profileImageUrl;
  late final bool emailVerified;

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    email = json['email'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    profileImageUrl = json['profileImageUrl'] ?? '';
    emailVerified = json['emailVerified'] ?? false;
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
